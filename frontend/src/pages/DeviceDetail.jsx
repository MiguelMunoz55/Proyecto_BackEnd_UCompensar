import { useState } from 'react'
import { Link, useNavigate, useParams } from 'react-router-dom'
import { useDataDispatch, useEnrichedDevice, useEnrichedDevices } from '../context/DataContext'
import DeviceGlyph from '../components/DeviceGlyph'
import StarRating from '../components/StarRating'
import DeviceCard from '../components/DeviceCard'
import CommentForm from '../components/CommentForm'
import CommentList from '../components/CommentList'
import { formatDate, formatPrice } from '../utils/format'

export default function DeviceDetail() {
  const { id } = useParams()
  const navigate = useNavigate()
  const device = useEnrichedDevice(id)
  const allDevices = useEnrichedDevices()
  const dispatch = useDataDispatch()
  const [tab, setTab] = useState('ficha')

  if (!device) {
    return (
      <div className="container py-5 text-center">
        <p>No encontramos este dispositivo. Puede que haya sido eliminado del catálogo.</p>
        <Link to="/" className="btn btn-accent btn-sm">Volver al catálogo</Link>
      </div>
    )
  }

  const related = allDevices
    .filter((d) => d.id !== device.id && d.typeId === device.typeId)
    .slice(0, 3)

  function handleAddComment(comment) {
    dispatch({ type: 'ADD_COMMENT', payload: { ...comment, deviceId: device.id } })
  }

  return (
    <div className="container py-4">
      <nav className="small text-muted mb-3">
        <Link to="/" className="text-decoration-none">Catálogo</Link>
        <span className="mx-1">/</span>
        <Link to="/" className="text-decoration-none">{device.type?.name}</Link>
        <span className="mx-1">/</span>
        <span>{device.name}</span>
      </nav>

      <button className="btn btn-sm btn-outline-graphite mb-3" onClick={() => navigate(-1)}>
        ← Volver
      </button>

      <div className="row g-4">
        <div className="col-md-5">
          <div className="detail-media">
            <DeviceGlyph typeSlug={device.type?.slug} tone={device.imageTone} size={200} />
          </div>
        </div>

        <div className="col-md-7">
          <div className="d-flex gap-1 mb-2">
            <span className="tag tag-type">{device.type?.name}</span>
            <span className="tag tag-brand">{device.brand?.name}</span>
          </div>
          <h1 className="h3 font-display">{device.name}</h1>
          <p className="text-muted">{device.shortDescription}</p>

          <div className="d-flex align-items-center gap-3 mb-3">
            <StarRating value={device.averageRating || 0} count={device.commentCount} size="lg" />
          </div>

          <div className="font-mono price mb-1" style={{ fontSize: '1.6rem' }}>
            {formatPrice(device.price)}
          </div>
          <div className="text-muted small mb-3">Fecha de lanzamiento: {formatDate(device.releaseDate)}</div>

          <div className="spec-strip mb-0" style={{ borderTop: 'none', paddingTop: 0 }}>
            {Object.entries(device.specs).slice(0, 3).map(([k, v]) => (
              <span key={k}><b>{k}:</b> {v}</span>
            ))}
          </div>
        </div>
      </div>

      <div className="mt-4 border-bottom d-flex gap-1" style={{ borderColor: 'var(--line)' }}>
        <button className={`tab-btn ${tab === 'ficha' ? 'active' : ''}`} onClick={() => setTab('ficha')}>
          Ficha técnica
        </button>
        <button className={`tab-btn ${tab === 'resena' ? 'active' : ''}`} onClick={() => setTab('resena')}>
          Reseña
        </button>
        <button className={`tab-btn ${tab === 'comentarios' ? 'active' : ''}`} onClick={() => setTab('comentarios')}>
          Comentarios ({device.commentCount})
        </button>
      </div>

      <div className="py-4" style={{ maxWidth: 780 }}>
        {tab === 'ficha' && (
          <table className="spec-table">
            <tbody>
              {Object.entries(device.specs).map(([key, value]) => (
                <tr key={key}>
                  <td>{key}</td>
                  <td>{value}</td>
                </tr>
              ))}
            </tbody>
          </table>
        )}

        {tab === 'resena' && <p style={{ lineHeight: 1.7 }}>{device.review}</p>}

        {tab === 'comentarios' && (
          <div className="d-flex flex-column gap-3">
            <CommentForm onSubmit={handleAddComment} />
            <CommentList comments={device.comments} />
          </div>
        )}
      </div>

      {related.length > 0 && (
        <div className="mt-3">
          <h2 className="h5 font-display mb-3">También te puede interesar</h2>
          <div className="row row-cols-1 row-cols-sm-2 row-cols-lg-3 g-3">
            {related.map((d) => (
              <div className="col" key={d.id}>
                <DeviceCard device={d} />
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  )
}
