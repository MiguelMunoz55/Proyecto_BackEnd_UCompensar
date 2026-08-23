import { Link } from 'react-router-dom'

export default function NotFound() {
  return (
    <div className="container py-5 text-center">
      <div className="font-mono text-muted mb-2">404</div>
      <h1 className="h4 font-display mb-2">Página no encontrada</h1>
      <p className="text-muted">La ruta que buscas no existe o fue movida.</p>
      <Link to="/" className="btn btn-accent btn-sm">Volver al catálogo</Link>
    </div>
  )
}
