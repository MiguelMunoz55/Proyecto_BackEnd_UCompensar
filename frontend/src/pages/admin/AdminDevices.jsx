import { Link } from 'react-router-dom'
import { resolveImageUrl, useDataDispatch, useEnrichedDevices } from '../../context/DataContext'
import DeviceGlyph from '../../components/DeviceGlyph'
import { formatDate, formatPrice } from '../../utils/format'

export default function AdminDevices() {
  const devices = useEnrichedDevices()
  const dispatch = useDataDispatch()

  function handleDelete(device) {
    if (window.confirm(`¿Eliminar "${device.name}" del catálogo? Esto también borra sus comentarios.`)) {
      dispatch({ type: 'DELETE_DEVICE', payload: device.id })
    }
  }

  return (
    <div className="admin-shell p-3">
      <div className="d-flex justify-content-between align-items-center mb-3">
        <span className="text-muted small">{devices.length} dispositivos registrados</span>
        <Link to="/admin/dispositivos/nuevo" className="btn btn-accent btn-sm">
          + Nuevo dispositivo
        </Link>
      </div>

      <div className="table-responsive">
        <table className="table admin-table">
          <thead>
            <tr>
              <th></th>
              <th>Nombre</th>
              <th>Tipo</th>
              <th>Marca</th>
              <th>Lanzamiento</th>
              <th>Precio</th>
              <th>Comentarios</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {devices.map((d) => (
              <tr key={d.id}>
                <td>
                  <div className="admin-thumb">
                    {resolveImageUrl(d.imageUrl) ? (
                      <img src={resolveImageUrl(d.imageUrl)} alt={d.name} />
                    ) : (
                      <DeviceGlyph typeSlug={d.type?.slug} tone={d.imageTone} size={28} />
                    )}
                  </div>
                </td>
                <td className="fw-semibold">{d.name}</td>
                <td><span className="badge badge-soft-accent">{d.type?.name}</span></td>
                <td>{d.brand?.name}</td>
                <td>{formatDate(d.releaseDate)}</td>
                <td className="font-mono">{formatPrice(d.price)}</td>
                <td>{d.commentCount}</td>
                <td className="text-end">
                  <Link to={`/admin/dispositivos/${d.id}/editar`} className="btn btn-sm btn-outline-graphite me-1">
                    Editar
                  </Link>
                  <button className="btn btn-sm btn-outline-danger" onClick={() => handleDelete(d)}>
                    Eliminar
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}
