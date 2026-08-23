import { useState } from 'react'
import { useDataDispatch, useDataState } from '../../context/DataContext'

export default function AdminTaxonomy() {
  const { brands, types, devices } = useDataState()
  const dispatch = useDataDispatch()
  const [brandName, setBrandName] = useState('')
  const [brandCountry, setBrandCountry] = useState('')
  const [typeName, setTypeName] = useState('')

  function addBrand(e) {
    e.preventDefault()
    if (!brandName.trim()) return
    dispatch({ type: 'ADD_BRAND', payload: { name: brandName.trim(), country: brandCountry.trim() } })
    setBrandName('')
    setBrandCountry('')
  }

  function addType(e) {
    e.preventDefault()
    if (!typeName.trim()) return
    const slug = typeName.trim().toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '').replace(/\s+/g, '-')
    dispatch({ type: 'ADD_TYPE', payload: { name: typeName.trim(), slug } })
    setTypeName('')
  }

  function removeBrand(brand) {
    const inUse = devices.some((d) => d.brandId === brand.id)
    if (inUse) {
      window.alert('No se puede eliminar: hay dispositivos asociados a esta marca.')
      return
    }
    dispatch({ type: 'DELETE_BRAND', payload: brand.id })
  }

  function removeType(type) {
    const inUse = devices.some((d) => d.typeId === type.id)
    if (inUse) {
      window.alert('No se puede eliminar: hay dispositivos asociados a este tipo.')
      return
    }
    dispatch({ type: 'DELETE_TYPE', payload: type.id })
  }

  return (
    <div className="row g-4">
      <div className="col-md-6">
        <div className="admin-shell p-3">
          <h2 className="h6 font-display">Marcas</h2>
          <form className="d-flex gap-2 mb-3" onSubmit={addBrand}>
            <input className="form-control form-control-sm" placeholder="Nombre" value={brandName} onChange={(e) => setBrandName(e.target.value)} />
            <input className="form-control form-control-sm" placeholder="País" value={brandCountry} onChange={(e) => setBrandCountry(e.target.value)} />
            <button className="btn btn-accent btn-sm text-nowrap">Agregar</button>
          </form>
          <ul className="list-group list-group-flush">
            {brands.map((b) => (
              <li key={b.id} className="list-group-item d-flex justify-content-between align-items-center px-0">
                <span>{b.name} <span className="text-muted small">— {b.country}</span></span>
                <button className="btn btn-sm btn-outline-danger" onClick={() => removeBrand(b)}>Eliminar</button>
              </li>
            ))}
          </ul>
        </div>
      </div>

      <div className="col-md-6">
        <div className="admin-shell p-3">
          <h2 className="h6 font-display">Tipos de dispositivo</h2>
          <form className="d-flex gap-2 mb-3" onSubmit={addType}>
            <input className="form-control form-control-sm" placeholder="Ej. Consola portátil" value={typeName} onChange={(e) => setTypeName(e.target.value)} />
            <button className="btn btn-accent btn-sm text-nowrap">Agregar</button>
          </form>
          <ul className="list-group list-group-flush">
            {types.map((t) => (
              <li key={t.id} className="list-group-item d-flex justify-content-between align-items-center px-0">
                <span>{t.name} <span className="text-muted small font-mono">/{t.slug}</span></span>
                <button className="btn btn-sm btn-outline-danger" onClick={() => removeType(t)}>Eliminar</button>
              </li>
            ))}
          </ul>
        </div>
      </div>
    </div>
  )
}
