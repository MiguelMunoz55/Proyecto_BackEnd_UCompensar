import { createContext, useContext, useEffect, useMemo, useReducer } from 'react'
import { seedBrands, seedTypes } from '../data/seedBrandsTypes'
import { seedDevices } from '../data/seedDevices'
import { seedComments } from '../data/seedComments'

// ---------------------------------------------------------------------------
// Esta capa reemplaza, por ahora, a la API REST descrita en
// docs/ARQUITECTURA-BACKEND.md. Cada acción de este contexto está pensada
// para mapear 1 a 1 con un endpoint del futuro backend en Java:
//   ADD_DEVICE    -> POST   /api/devices
//   UPDATE_DEVICE -> PUT    /api/devices/{id}
//   DELETE_DEVICE -> DELETE /api/devices/{id}
//   ADD_COMMENT   -> POST   /api/devices/{id}/comments
// Mientras no exista el backend, el estado se persiste en localStorage para
// que los cambios hechos desde el panel de administración sobrevivan a un
// refresco de página durante la demostración.
// ---------------------------------------------------------------------------

const STORAGE_KEY = 'spechub_v1'

function loadInitialState() {
  try {
    const raw = window.localStorage.getItem(STORAGE_KEY)
    if (raw) {
      const parsed = JSON.parse(raw)
      if (parsed?.devices?.length) return parsed
    }
  } catch {
    // localStorage no disponible o datos corruptos: se usa la semilla
  }
  return {
    brands: seedBrands,
    types: seedTypes,
    devices: seedDevices,
    comments: seedComments,
  }
}

function uid(prefix) {
  return `${prefix}_${Date.now().toString(36)}${Math.random().toString(36).slice(2, 7)}`
}

function reducer(state, action) {
  switch (action.type) {
    case 'ADD_DEVICE':
      return { ...state, devices: [{ ...action.payload, id: uid('d') }, ...state.devices] }
    case 'UPDATE_DEVICE':
      return {
        ...state,
        devices: state.devices.map((d) => (d.id === action.payload.id ? action.payload : d)),
      }
    case 'DELETE_DEVICE':
      return {
        ...state,
        devices: state.devices.filter((d) => d.id !== action.payload),
        comments: state.comments.filter((c) => c.deviceId !== action.payload),
      }
    case 'ADD_BRAND':
      return { ...state, brands: [...state.brands, { ...action.payload, id: uid('b') }] }
    case 'DELETE_BRAND':
      return { ...state, brands: state.brands.filter((b) => b.id !== action.payload) }
    case 'ADD_TYPE':
      return { ...state, types: [...state.types, { ...action.payload, id: uid('t') }] }
    case 'DELETE_TYPE':
      return { ...state, types: state.types.filter((t) => t.id !== action.payload) }
    case 'ADD_COMMENT':
      return { ...state, comments: [{ ...action.payload, id: uid('c') }, ...state.comments] }
    case 'DELETE_COMMENT':
      return { ...state, comments: state.comments.filter((c) => c.id !== action.payload) }
    case 'RESET_DEMO':
      return {
        brands: seedBrands,
        types: seedTypes,
        devices: seedDevices,
        comments: seedComments,
      }
    default:
      return state
  }
}

const DataStateContext = createContext(null)
const DataDispatchContext = createContext(null)

export function DataProvider({ children }) {
  const [state, dispatch] = useReducer(reducer, undefined, loadInitialState)

  useEffect(() => {
    try {
      window.localStorage.setItem(STORAGE_KEY, JSON.stringify(state))
    } catch {
      // Si el almacenamiento local falla, la app sigue funcionando en memoria
    }
  }, [state])

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

export function useEnrichedDevices() {
  const { devices, brands, types, comments } = useDataState()
  return useMemo(() => {
    return devices.map((d) => enrichDevice(d, { brands, types, comments }))
  }, [devices, brands, types, comments])
}

export function useEnrichedDevice(id) {
  const state = useDataState()
  return useMemo(() => {
    const device = state.devices.find((d) => d.id === id)
    if (!device) return null
    return enrichDevice(device, state)
  }, [id, state])
}

function enrichDevice(device, { brands, types, comments }) {
  const brand = brands.find((b) => b.id === device.brandId) || null
  const type = types.find((t) => t.id === device.typeId) || null
  const deviceComments = comments
    .filter((c) => c.deviceId === device.id)
    .sort((a, b) => new Date(b.date) - new Date(a.date))
  const averageRating = deviceComments.length
    ? deviceComments.reduce((sum, c) => sum + c.rating, 0) / deviceComments.length
    : null
  return {
    ...device,
    brand,
    type,
    comments: deviceComments,
    averageRating,
    commentCount: deviceComments.length,
  }
}
