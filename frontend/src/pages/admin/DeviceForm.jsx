import { useEffect, useRef, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { resolveImageUrl, useDataDispatch, useDataState } from '../../context/DataContext'

const TONE_OPTIONS = ['graphite', 'blue', 'teal', 'amber', 'purple']

function emptyDevice(typeId, brandId) {
  return {
    name: '',
    brandId: brandId || '',
    typeId: typeId || '',
    releaseDate: new Date().toISOString().slice(0, 10),
    price: 0,
    shortDescription: '',
    review: '',
    imageTone: 'graphite',
    specs: { Pantalla: '', Procesador: '', RAM: '', Batería: '' },
  }
}

export default function DeviceForm() {
  const { id } = useParams()
  const navigate = useNavigate()
  const { devices, brands, types, loading } = useDataState()
  const dispatch = useDataDispatch()

  const editing = id ? devices.find((d) => String(d.id) === String(id)) : null
  const [form, setForm] = useState(() => editing || emptyDevice(types[0]?.id, brands[0]?.id))
  const [specRows, setSpecRows] = useState(() =>
    Object.entries(form.specs).map(([key, value]) => ({ key, value }))
  )

  const [imageFile, setImageFile] = useState(null)
  const [imagePreview, setImagePreview] = useState(() => resolveImageUrl(editing?.imageUrl))
  const [saving, setSaving] = useState(false)
  const fileInputRef = useRef(null)

  function handleFileChange(e) {
    const file = e.target.files?.[0]
    if (!file) return

    if (!file.type.startsWith('image/')) {
      window.alert('Selecciona un archivo de imagen válido (JPG, PNG, WEBP o GIF).')
      e.target.value = ''
      return
    }
    if (file.size > 5 * 1024 * 1024) {
      window.alert('La imagen no puede superar 5 MB.')
      e.target.value = ''
      return
    }

    setImageFile(file)
    setImagePreview(URL.createObjectURL(file))
  }

  function clearImageSelection() {
    setImageFile(null)
    setImagePreview(resolveImageUrl(editing?.imageUrl))
    if (fileInputRef.current) fileInputRef.current.value = ''
  }

  // Si el formulario de "nuevo dispositivo" se monta antes de que brands/types
  // terminen de llegar de la API, completa marca/tipo apenas estén listos.
  useEffect(() => {
    if (editing) return
    setForm((f) => ({
      ...f,
      typeId: f.typeId || types[0]?.id || '',
      brandId: f.brandId || brands[0]?.id || '',
    }))
  }, [types, brands, editing])

  function updateField(field, value) {
    setForm((f) => ({ ...f, [field]: value }))
  }

  function updateSpecRow(index, field, value) {
    setSpecRows((rows) => rows.map((r, i) => (i === index ? { ...r, [field]: value } : r)))
  }

  function addSpecRow() {
    setSpecRows((rows) => [...rows, { key: '', value: '' }])
  }

  function removeSpecRow(index) {
    setSpecRows((rows) => rows.filter((_, i) => i !== index))
  }

  async function handleSubmit(e) {
    e.preventDefault()
    const specs = {}
    specRows.forEach((row) => {
      if (row.key.trim()) specs[row.key.trim()] = row.value.trim()
    })

    const typeSlug = types.find((t) => String(t.id) === String(form.typeId))?.slug || 'celular'
    const glyphShape = { celular: 'phone', portatil: 'laptop', tablet: 'tablet', smartwatch: 'watch' }[typeSlug]
    const payload = {
      ...form,
      price: Number(form.price),
      specs,
      imageTone: `${glyphShape}-${form.imageTone}`,
    }

    setSaving(true)
    try {
      const saved = editing
        ? await dispatch({ type: 'UPDATE_DEVICE', payload: { ...editing, ...payload } })
        : await dispatch({ type: 'ADD_DEVICE', payload })

      const deviceId = saved?.id ?? editing?.id
      if (imageFile && deviceId) {
        await dispatch({ type: 'UPLOAD_DEVICE_IMAGE', payload: { deviceId, file: imageFile } })
      }
      navigate('/admin')
    } catch {
      // El error ya se muestra desde DataContext (window.alert); nos
      // quedamos en el formulario para que el usuario pueda reintentar.
    } finally {
      setSaving(false)
    }
  }

  if (loading && id && !editing) {
    return <div className="admin-shell p-3">Cargando dispositivo…</div>
  }

  return (
    <form className="admin-shell p-3" onSubmit={handleSubmit} style={{ maxWidth: 760 }}>
      <h2 className="h6 font-display mb-3">{editing ? `Editar: ${editing.name}` : 'Nuevo dispositivo'}</h2>

      <div className="row g-3">
        <div className="col-md-6">
          <label className="form-label small">Nombre</label>
          <input className="form-control" required value={form.name} onChange={(e) => updateField('name', e.target.value)} />
        </div>
        <div className="col-md-3">
          <label className="form-label small">Tipo</label>
          <select className="form-select" value={form.typeId} onChange={(e) => updateField('typeId', e.target.value)}>
            {types.map((t) => <option key={t.id} value={t.id}>{t.name}</option>)}
          </select>
        </div>
        <div className="col-md-3">
          <label className="form-label small">Marca</label>
          <select className="form-select" value={form.brandId} onChange={(e) => updateField('brandId', e.target.value)}>
            {brands.map((b) => <option key={b.id} value={b.id}>{b.name}</option>)}
          </select>
        </div>

        <div className="col-md-4">
          <label className="form-label small">Fecha de lanzamiento</label>
          <input type="date" className="form-control" value={form.releaseDate} onChange={(e) => updateField('releaseDate', e.target.value)} />
        </div>
        <div className="col-md-4">
          <label className="form-label small">Precio (COP)</label>
          <input type="number" min="0" step="10000" className="form-control" value={form.price} onChange={(e) => updateField('price', e.target.value)} />
        </div>
        <div className="col-md-4">
          <label className="form-label small">Color de icono</label>
          <select className="form-select" value={form.imageTone.split('-').pop()} onChange={(e) => updateField('imageTone', e.target.value)}>
            {TONE_OPTIONS.map((t) => <option key={t} value={t}>{t}</option>)}
          </select>
        </div>

        <div className="col-12">
          <label className="form-label small">Foto del dispositivo</label>
          <div className="d-flex align-items-center gap-3">
            <div className="device-photo-preview">
              {imagePreview ? (
                <img src={imagePreview} alt="Vista previa" />
              ) : (
                <span className="text-body-secondary small">Sin foto</span>
              )}
            </div>
            <div>
              <input
                ref={fileInputRef}
                type="file"
                accept="image/jpeg,image/png,image/webp,image/gif"
                className="form-control form-control-sm"
                onChange={handleFileChange}
              />
              <div className="form-text">JPG, PNG, WEBP o GIF. Máximo 5 MB.</div>
              {imageFile && (
                <button type="button" className="btn btn-sm btn-link p-0 mt-1" onClick={clearImageSelection}>
                  Cancelar selección
                </button>
              )}
            </div>
          </div>
        </div>

        <div className="col-12">
          <label className="form-label small">Descripción corta (aparece en la tarjeta del listado)</label>
          <input className="form-control" value={form.shortDescription} onChange={(e) => updateField('shortDescription', e.target.value)} />
        </div>

        <div className="col-12">
          <label className="form-label small">Reseña / sinopsis</label>
          <textarea className="form-control" rows="4" value={form.review} onChange={(e) => updateField('review', e.target.value)} />
        </div>

        <div className="col-12">
          <label className="form-label small d-flex justify-content-between align-items-center">
            Ficha técnica (especificaciones)
            <button type="button" className="btn btn-sm btn-outline-graphite" onClick={addSpecRow}>+ Agregar campo</button>
          </label>
          {specRows.map((row, i) => (
            <div className="row g-2 mb-2" key={i}>
              <div className="col-5">
                <input className="form-control form-control-sm" placeholder="Ej. Procesador" value={row.key} onChange={(e) => updateSpecRow(i, 'key', e.target.value)} />
              </div>
              <div className="col-6">
                <input className="form-control form-control-sm" placeholder="Ej. Snapdragon 8 Gen 3" value={row.value} onChange={(e) => updateSpecRow(i, 'value', e.target.value)} />
              </div>
              <div className="col-1">
                <button type="button" className="btn btn-sm btn-outline-danger" onClick={() => removeSpecRow(i)}>×</button>
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="d-flex gap-2 mt-3">
        <button type="submit" className="btn btn-accent" disabled={saving}>
          {saving ? 'Guardando…' : editing ? 'Guardar cambios' : 'Crear dispositivo'}
        </button>
        <button type="button" className="btn btn-outline-graphite" disabled={saving} onClick={() => navigate('/admin')}>
          Cancelar
        </button>
      </div>
    </form>
  )
}
