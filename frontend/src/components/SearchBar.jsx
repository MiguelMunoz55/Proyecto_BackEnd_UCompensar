export default function SearchBar({ value, onChange, placeholder = 'Buscar por nombre o marca…' }) {
  return (
    <div className="search-shell">
      <input
        type="search"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        aria-label="Buscar dispositivos"
      />
      <button type="button" onClick={() => onChange(value)}>
        Buscar
      </button>
    </div>
  )
}
