import { Link } from 'react-router-dom'
import DeviceGlyph from './DeviceGlyph'
import StarRating from './StarRating'
import { formatDate, formatPrice, isRecent } from '../utils/format'

const KEY_SPECS_BY_TYPE = {
  celular: ['Pantalla', 'RAM', 'Batería'],
  portatil: ['Procesador', 'RAM', 'Almacenamiento'],
  tablet: ['Pantalla', 'Almacenamiento', 'Batería'],
  smartwatch: ['Pantalla', 'Batería', 'Conectividad'],
}

export default function DeviceCard({ device }) {
  const keySpecs = KEY_SPECS_BY_TYPE[device.type?.slug] || Object.keys(device.specs).slice(0, 3)

  return (
    <Link to={`/dispositivos/${device.id}`} className="device-card">
      <div className="device-card-media">
        <DeviceGlyph typeSlug={device.type?.slug} tone={device.imageTone} size={92} />
        {isRecent(device.releaseDate) && <span className="tag tag-new position-absolute top-0 end-0 m-2">Nuevo</span>}
      </div>
      <div className="device-card-body">
        <div className="d-flex gap-1 flex-wrap">
          <span className="tag tag-type">{device.type?.name}</span>
          <span className="tag tag-brand">{device.brand?.name}</span>
        </div>
        <h3 className="h6 mb-0 font-display">{device.name}</h3>
        <div className="text-muted small">Lanzamiento: {formatDate(device.releaseDate)}</div>

        <div className="spec-strip">
          {keySpecs.map((key) => (
            <span key={key}>
              <b>{key}:</b> {device.specs[key]}
            </span>
          ))}
        </div>

        <div className="price-row">
          <span className="price">{formatPrice(device.price)}</span>
          <StarRating value={device.averageRating || 0} count={device.commentCount} />
        </div>
      </div>
    </Link>
  )
}
