export default function FilterPanel({ brands, filters, onChange, onReset }) {
  function toggleBrand(brandId) {
    const next = filters.brandIds.includes(brandId)
      ? filters.brandIds.filter((id) => id !== brandId)
      : [...filters.brandIds, brandId]
    onChange({ ...filters, brandIds: next })
  }

  return (
    <div className="filter-panel d-flex flex-column gap-3">
      <div>
        <div className="filter-title">Marca</div>
        {brands.map((brand) => (
          <div className="form-check" key={brand.id}>
            <input
              className="form-check-input"
              type="checkbox"
              id={`brand-${brand.id}`}
              checked={filters.brandIds.includes(brand.id)}
              onChange={() => toggleBrand(brand.id)}
            />
            <label className="form-check-label" htmlFor={`brand-${brand.id}`}>
              {brand.name}
            </label>
          </div>
        ))}
      </div>

      <div>
        <div className="filter-title">Precio máximo</div>
        <input
          type="range"
          className="form-range"
          min="1000000"
          max="11000000"
          step="200000"
          value={filters.maxPrice}
          onChange={(e) => onChange({ ...filters, maxPrice: Number(e.target.value) })}
        />
        <div className="small text-muted font-mono">
          Hasta {new Intl.NumberFormat('es-CO', { style: 'currency', currency: 'COP', maximumFractionDigits: 0 }).format(filters.maxPrice)}
        </div>
      </div>

      <div>
        <div className="filter-title">Ordenar por</div>
        <select
          className="form-select form-select-sm"
          value={filters.sortBy}
          onChange={(e) => onChange({ ...filters, sortBy: e.target.value })}
        >
          <option value="release-desc">Más recientes primero</option>
          <option value="release-asc">Más antiguos primero</option>
          <option value="price-asc">Precio: menor a mayor</option>
          <option value="price-desc">Precio: mayor a menor</option>
          <option value="rating-desc">Mejor calificados</option>
          <option value="name-asc">Nombre A-Z</option>
        </select>
      </div>

      <button type="button" className="btn btn-sm btn-outline-graphite" onClick={onReset}>
        Limpiar filtros
      </button>
    </div>
  )
}
