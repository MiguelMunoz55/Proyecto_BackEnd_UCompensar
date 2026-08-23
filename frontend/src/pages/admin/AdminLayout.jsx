import { NavLink, Outlet } from 'react-router-dom'
import { useDataDispatch } from '../../context/DataContext'

export default function AdminLayout() {
  const dispatch = useDataDispatch()

  function handleReset() {
    if (window.confirm('¿Restaurar los datos de demostración? Se perderán los cambios hechos en este panel.')) {
      dispatch({ type: 'RESET_DEMO' })
    }
  }

  return (
    <div className="container py-4">
      <div className="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-1">
        <div>
          <h1 className="h4 font-display mb-1">Panel de administración</h1>
          <p className="text-muted small mb-0">
            Alta, edición y baja de la información base del catálogo (dispositivos, marcas, tipos y comentarios).
            En producción, estas acciones llamarían a la API REST del backend — ver{' '}
            <code>docs/ARQUITECTURA-BACKEND.md</code>.
          </p>
        </div>
        <button className="btn btn-sm btn-outline-graphite" onClick={handleReset}>
          Restaurar datos de demo
        </button>
      </div>

      <div className="d-flex gap-1 border-bottom my-3" style={{ borderColor: 'var(--line)' }}>
        <NavLink to="/admin" end className={({ isActive }) => `tab-btn ${isActive ? 'active' : ''}`}>
          Dispositivos
        </NavLink>
        <NavLink to="/admin/taxonomia" className={({ isActive }) => `tab-btn ${isActive ? 'active' : ''}`}>
          Marcas y tipos
        </NavLink>
        <NavLink to="/admin/comentarios" className={({ isActive }) => `tab-btn ${isActive ? 'active' : ''}`}>
          Comentarios
        </NavLink>
      </div>

      <Outlet />
    </div>
  )
}
