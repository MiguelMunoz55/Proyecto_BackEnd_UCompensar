import { useMemo, useState } from 'react'
import { useDataState, useEnrichedDevices } from '../context/DataContext'
import DeviceCard from '../components/DeviceCard'
import DeviceGlyph from '../components/DeviceGlyph'
import SearchBar from '../components/SearchBar'
import FilterPanel from '../components/FilterPanel'

const DEFAULT_FILTERS = { brandIds: [], maxPrice: 11000000, sortBy: 'release-desc' }

export default function Home() {
  const { types, loading, error } = useDataState()
  const devices = useEnrichedDevices()

  const [activeType, setActiveType] = useState('all')
  const [query, setQuery] = useState('')
  const [filters, setFilters] = useState(DEFAULT_FILTERS)

  const filtered = useMemo(() => {
    let result = devices

    if (activeType !== 'all') {
      result = result.filter((d) => d.type?.slug === activeType)
    }
    if (query.trim()) {
      const q = query.trim().toLowerCase()
      result = result.filter(
        (d) => d.name.toLowerCase().includes(q) || d.brand?.name.toLowerCase().includes(q)
      )
    }
    if (filters.brandIds.length) {
      result = result.filter((d) => filters.brandIds.includes(d.brandId))
    }
    result = result.filter((d) => d.price <= filters.maxPrice)

    const sorted = [...result].sort((a, b) => {
      switch (filters.sortBy) {
        case 'release-asc':
          return new Date(a.releaseDate) - new Date(b.releaseDate)
        case 'price-asc':
          return a.price - b.price
        case 'price-desc':
          return b.price - a.price
        case 'rating-desc':
          return (b.averageRating || 0) - (a.averageRating || 0)
        case 'name-asc':
          return a.name.localeCompare(b.name)
        case 'release-desc':
        default:
          return new Date(b.releaseDate) - new Date(a.releaseDate)
      }
    })

    return sorted
  }, [devices, activeType, query, filters])

  return (
    <>
      <section className="hero">
        <div className="container">
          <div className="hero-eyebrow">Catálogo · Fichas técnicas · Opiniones reales</div>
          <h1 style={{color:'white'}}>Encuentra tu próximo dispositivo inteligente comparando ficha a ficha.</h1>
          <p>
            Celulares, portátiles, tablets y smartwatches organizados por fecha de lanzamiento, marca y
            especificaciones clave — para que decidas con datos, no con anuncios.
          </p>
          <div className="mt-3" style={{ maxWidth: 480 }}>
            <SearchBar value={query} onChange={setQuery} />
          </div>
          <div className="category-rail">
            <button
              className={`category-pill ${activeType === 'all' ? 'active' : ''}`}
              onClick={() => setActiveType('all')}
            >
              Todos ({devices.length})
            </button>
            {types.map((t) => (
              <button
                key={t.id}
                className={`category-pill ${activeType === t.slug ? 'active' : ''}`}
                onClick={() => setActiveType(t.slug)}
              >
                {t.name} ({devices.filter((d) => d.type?.slug === t.slug).length})
              </button>
            ))}
          </div>
        </div>
      </section>

      <section className="container py-4">
        <div className="row g-4">
          <div className="col-lg-3">
            <FilterPanel
              brands={[...new Map(devices.map((d) => [d.brand?.id, d.brand])).values()].filter(Boolean)}
              filters={filters}
              onChange={setFilters}
              onReset={() => setFilters(DEFAULT_FILTERS)}
            />
          </div>
          <div className="col-lg-9">
            <div className="d-flex justify-content-between align-items-baseline mb-3">
              <span className="text-muted small">
                {filtered.length} dispositivo{filtered.length !== 1 ? 's' : ''} encontrado{filtered.length !== 1 ? 's' : ''}
              </span>
            </div>

            {loading ? (
              <div className="empty-state">
                <div className="empty-state-glyph"><DeviceGlyph typeSlug="celular" tone="phone-graphite" size={56} /></div>
                <p className="text-muted mb-0">Cargando catálogo…</p>
              </div>
            ) : error ? (
              <div className="empty-state">
                <p className="text-danger mb-0">
                  No pudimos cargar el catálogo ({error}). Verifica que el backend esté corriendo.
                </p>
              </div>
            ) : filtered.length === 0 ? (
              <div className="empty-state">
                <div className="empty-state-glyph"><DeviceGlyph typeSlug="tablet" tone="tablet-graphite" size={56} /></div>
                <p className="text-muted mb-0">
                  No encontramos dispositivos con esos filtros. Prueba ajustando el precio máximo o la búsqueda.
                </p>
              </div>
            ) : (
              <div className="row row-cols-1 row-cols-sm-2 row-cols-xl-3 g-3">
                {filtered.map((device) => (
                  <div className="col" key={device.id}>
                    <DeviceCard device={device} />
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>
      </section>
    </>
  )
}
