export default function StarRating({ value = 0, count, onChange, size = 'sm' }) {
  const rounded = Math.round(value)
  const interactive = typeof onChange === 'function'
  const cls = size === 'lg' ? 'fs-4' : ''

  return (
    <span className="rating d-inline-flex align-items-center gap-1">
      <span className={`stars ${cls}`}>
        {[1, 2, 3, 4, 5].map((n) =>
          interactive ? (
            <button
              key={n}
              type="button"
              onClick={() => onChange(n)}
              aria-label={`Calificar con ${n} estrella${n > 1 ? 's' : ''}`}
              style={{ background: 'none', border: 'none', padding: 0, color: n <= value ? 'var(--accent)' : '#C8CDD0', cursor: 'pointer', fontSize: '1.3rem', lineHeight: 1 }}
            >
              ★
            </button>
          ) : (
            <span key={n} style={{ opacity: n <= rounded ? 1 : 0.25 }}>
              ★
            </span>
          )
        )}
      </span>
      {typeof count === 'number' && (
        <span className="text-muted">
          {value ? value.toFixed(1) : 'Sin calificar'} {count ? `(${count})` : ''}
        </span>
      )}
    </span>
  )
}
