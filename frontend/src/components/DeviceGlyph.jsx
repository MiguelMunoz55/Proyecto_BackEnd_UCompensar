const TONES = {
  'phone-blue': '#3B6FDB',
  'phone-graphite': '#4B5760',
  'phone-amber': '#FF6A1A',
  'phone-teal': '#0EA5A5',
  'laptop-graphite': '#4B5760',
  'laptop-blue': '#3B6FDB',
  'laptop-purple': '#7C5CFF',
  'laptop-teal': '#0EA5A5',
  'tablet-graphite': '#4B5760',
  'tablet-blue': '#3B6FDB',
  'watch-graphite': '#4B5760',
  'watch-teal': '#0EA5A5',
}

function shapeFor(typeSlug) {
  if (typeSlug === 'celular') return 'phone'
  if (typeSlug === 'portatil') return 'laptop'
  if (typeSlug === 'tablet') return 'tablet'
  return 'watch'
}

/**
 * Silueta técnica generada en SVG (línea, estilo datasheet) que representa
 * la categoría del dispositivo. Se usa en lugar de fotografías de producto
 * reales para evitar el uso de imágenes de marca con derechos reservados.
 */
export default function DeviceGlyph({ typeSlug, tone = 'phone-graphite', size = 96 }) {
  const color = TONES[tone] || '#4B5760'
  const shape = shapeFor(typeSlug)

  return (
    <svg width={size} height={size} viewBox="0 0 100 100" fill="none" aria-hidden="true">
      {shape === 'phone' && (
        <g>
          <rect x="32" y="8" width="36" height="84" rx="8" stroke={color} strokeWidth="2.5" />
          <line x1="40" y1="18" x2="60" y2="18" stroke={color} strokeWidth="2.5" strokeLinecap="round" />
          <rect x="38" y="26" width="24" height="42" rx="2" stroke={color} strokeWidth="1.5" opacity="0.5" />
          <circle cx="50" cy="82" r="3" stroke={color} strokeWidth="2" />
        </g>
      )}
      {shape === 'laptop' && (
        <g>
          <rect x="14" y="20" width="72" height="46" rx="3" stroke={color} strokeWidth="2.5" />
          <rect x="20" y="26" width="60" height="34" rx="1.5" stroke={color} strokeWidth="1.5" opacity="0.5" />
          <path d="M8 74h84l-6 10H14l-6-10Z" stroke={color} strokeWidth="2.5" strokeLinejoin="round" />
        </g>
      )}
      {shape === 'tablet' && (
        <g>
          <rect x="20" y="10" width="60" height="80" rx="7" stroke={color} strokeWidth="2.5" />
          <rect x="27" y="18" width="46" height="58" rx="1.5" stroke={color} strokeWidth="1.5" opacity="0.5" />
          <circle cx="50" cy="83" r="2.5" stroke={color} strokeWidth="2" />
        </g>
      )}
      {shape === 'watch' && (
        <g>
          <rect x="32" y="4" width="12" height="14" rx="2" stroke={color} strokeWidth="2" />
          <rect x="32" y="82" width="12" height="14" rx="2" stroke={color} strokeWidth="2" />
          <rect x="24" y="24" width="52" height="52" rx="14" stroke={color} strokeWidth="2.5" />
          <circle cx="50" cy="50" r="16" stroke={color} strokeWidth="1.5" opacity="0.5" />
          <rect x="74" y="42" width="5" height="8" rx="1.5" fill={color} />
        </g>
      )}
    </svg>
  )
}
