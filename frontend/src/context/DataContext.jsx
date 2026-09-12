import { createContext, useCallback, useContext, useEffect, useMemo, useState } from 'react'
import { useAuth } from './AuthContext'

// ---------------------------------------------------------------------------
// Esta capa reemplaza la simulación en memoria/localStorage por llamadas
// reales al backend descrito en docs/ARQUITECTURA-BACKEND.md:
//   ADD_DEVICE    -> POST   /api/devices
//   UPDATE_DEVICE -> PUT    /api/devices/{id}
//   DELETE_DEVICE -> DELETE /api/devices/{id}
//   ADD_BRAND     -> POST   /api/brands
//   DELETE_BRAND  -> DELETE /api/brands/{id}
//   ADD_TYPE      -> POST   /api/device-types
//   DELETE_TYPE   -> DELETE /api/device-types/{id}
//   ADD_COMMENT   -> POST   /api/devices/{id}/comments (público)
//   DELETE_COMMENT-> DELETE /api/comments/{id}
// GET /api/devices ya devuelve el dispositivo "enriquecido" (marca, tipo,
// comentarios, promedio de calificación), así que no hace falta recalcularlo
// en el cliente como hacía enrichDevice() antes.
// ---------------------------------------------------------------------------

const API_BASE = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080/api'
// El backend guarda las imágenes con una URL relativa ("/uploads/..."), así
// que para pintarlas necesitamos el origen del backend sin el sufijo "/api".
export const API_ORIGIN = API_BASE.replace(/\/api\/?$/, '')

export function resolveImageUrl(imageUrl) {
  if (!imageUrl) return null
  if (/^https?:\/\//i.test(imageUrl)) return imageUrl
  return `${API_ORIGIN}${imageUrl}`
}

const DataStateContext = createContext(null)
const DataDispatchContext = createContext(null)

async function apiFetch(path, { method = 'GET', body, token, isFormData = false } = {}) {
  const headers = {}
  if (token) headers.Authorization = `Bearer ${token}`
  // Con FormData el navegador arma el Content-Type (con el boundary) solo;
  // si lo fijamos nosotros a mano, el backend no puede parsear el multipart.
  if (!isFormData) headers['Content-Type'] = 'application/json'

  const response = await fetch(`${API_BASE}${path}`, {
    method,
    headers,
    body: isFormData ? body : body !== undefined ? JSON.stringify(body) : undefined,
  })

  if (!response.ok) {
    const errorBody = await response.json().catch(() => null)
    throw new Error(errorBody?.mensaje || errorBody?.error || `Error ${response.status}`)
  }
  if (response.status === 204) return null
  return response.json()
}

// El formulario de admin trabaja con brandId/typeId/price como texto (vienen
// de <select>/<input>); aquí se normalizan al tipo que espera el backend.
function toDeviceRequest(device) {
  return {
    name: device.name,
    brandId: Number(device.brandId),
    typeId: Number(device.typeId),
    releaseDate: device.releaseDate,
    price: Number(device.price),
    shortDescription: device.shortDescription,
    review: device.review,
    imageTone: device.imageTone,
    specs: device.specs || {},
  }
}

export function DataProvider({ children }) {
  const { token } = useAuth()
  const [brands, setBrands] = useState([])
  const [types, setTypes] = useState([])
  const [devices, setDevices] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  const refresh = useCallback(async () => {
    setLoading(true)
    setError(null)
    try {
      const [brandsData, typesData, devicesData] = await Promise.all([
        apiFetch('/brands'),
        apiFetch('/device-types'),
        apiFetch('/devices'),
      ])
      setBrands(brandsData)
      setTypes(typesData)
      setDevices(devicesData)
    } catch (err) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => {
    refresh()
  }, [refresh])

  // Comentarios "planos" para el panel de admin: cada DispositivoDTO ya trae
  // sus propios comentarios embebidos (con deviceId incluido).
  const comments = useMemo(() => devices.flatMap((d) => d.comments || []), [devices])

  const state = useMemo(
    () => ({ brands, types, devices, comments, loading, error }),
    [brands, types, devices, comments, loading, error]
  )

  const dispatch = useCallback(
    async (action) => {
      let result
      try {
        switch (action.type) {
          case 'ADD_DEVICE':
            result = await apiFetch('/devices', { method: 'POST', token, body: toDeviceRequest(action.payload) })
            break
          case 'UPDATE_DEVICE':
            result = await apiFetch(`/devices/${action.payload.id}`, {
              method: 'PUT',
              token,
              body: toDeviceRequest(action.payload),
            })
            break
          case 'UPLOAD_DEVICE_IMAGE': {
            const formData = new FormData()
            formData.append('file', action.payload.file)
            result = await apiFetch(`/devices/${action.payload.deviceId}/image`, {
              method: 'POST',
              token,
              body: formData,
              isFormData: true,
            })
            break
          }
          case 'DELETE_DEVICE':
            await apiFetch(`/devices/${action.payload}`, { method: 'DELETE', token })
            break
          case 'ADD_BRAND':
            await apiFetch('/brands', { method: 'POST', token, body: action.payload })
            break
          case 'DELETE_BRAND':
            await apiFetch(`/brands/${action.payload}`, { method: 'DELETE', token })
            break
          case 'ADD_TYPE':
            await apiFetch('/device-types', { method: 'POST', token, body: action.payload })
            break
          case 'DELETE_TYPE':
            await apiFetch(`/device-types/${action.payload}`, { method: 'DELETE', token })
            break
          case 'ADD_COMMENT':
            // Público: no requiere token.
            await apiFetch(`/devices/${action.payload.deviceId}/comments`, {
              method: 'POST',
              body: {
                author: action.payload.author,
                rating: action.payload.rating,
                content: action.payload.content,
              },
            })
            break
          case 'DELETE_COMMENT':
            await apiFetch(`/comments/${action.payload}`, { method: 'DELETE', token })
            break
          default:
            return
        }
        await refresh()
        return result
      } catch (err) {
        window.alert(err.message)
        throw err
      }
    },
    [token, refresh]
  )

  return (
    <DataStateContext.Provider value={state}>
      <DataDispatchContext.Provider value={dispatch}>{children}</DataDispatchContext.Provider>
    </DataStateContext.Provider>
  )
}

export function useDataState() {
  const ctx = useContext(DataStateContext)
  if (!ctx) throw new Error('useDataState debe usarse dentro de <DataProvider>')
  return ctx
}

export function useDataDispatch() {
  const ctx = useContext(DataDispatchContext)
  if (!ctx) throw new Error('useDataDispatch debe usarse dentro de <DataProvider>')
  return ctx
}

// ---------------------------- Selectores útiles ----------------------------
// Los dispositivos que devuelve la API ya vienen enriquecidos (brand, type,
// comments, averageRating, commentCount), así que estos selectores ya no
// necesitan recalcular nada — se conservan para no tener que tocar las
// páginas que ya los consumían.

export function useEnrichedDevices() {
  const { devices } = useDataState()
  return devices
}

export function useEnrichedDevice(id) {
  const { devices } = useDataState()
  return useMemo(
    () => devices.find((d) => String(d.id) === String(id)) || null,
    [devices, id]
  )
}
