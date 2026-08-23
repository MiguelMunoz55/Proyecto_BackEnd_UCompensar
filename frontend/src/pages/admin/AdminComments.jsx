import { useDataDispatch, useDataState } from '../../context/DataContext'
import { formatDate } from '../../utils/format'

export default function AdminComments() {
  const { comments, devices } = useDataState()
  const dispatch = useDataDispatch()

  function deviceName(deviceId) {
    return devices.find((d) => d.id === deviceId)?.name || 'Dispositivo eliminado'
  }

  return (
    <div className="admin-shell p-3">
      <span className="text-muted small">{comments.length} comentarios publicados</span>
      <div className="table-responsive mt-2">
        <table className="table admin-table">
          <thead>
            <tr>
              <th>Dispositivo</th>
              <th>Autor</th>
              <th>Calificación</th>
              <th>Comentario</th>
              <th>Fecha</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {comments.map((c) => (
              <tr key={c.id}>
                <td className="fw-semibold">{deviceName(c.deviceId)}</td>
                <td>{c.author}</td>
                <td className="font-mono">{c.rating} / 5</td>
                <td style={{ maxWidth: 320 }}>{c.content}</td>
                <td>{formatDate(c.date)}</td>
                <td className="text-end">
                  <button
                    className="btn btn-sm btn-outline-danger"
                    onClick={() => dispatch({ type: 'DELETE_COMMENT', payload: c.id })}
                  >
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
