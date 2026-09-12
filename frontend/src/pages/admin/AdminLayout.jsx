import { NavLink, Outlet, useNavigate } from 'react-router-dom'
import { useAuth } from '../../context/AuthContext'
import { useDataState } from '../../context/DataContext'

export default function AdminLayout() {
  const { username, logout } = useAuth()
  const { devices, brands, types, comments } = useDataState()
  const navigate = useNavigate()

  function handleLogout() {
    logout()
    navigate('/')
  }

  const stats = [
    { label: 'Dispositivos', value: devices.length },
    { label: 'Marcas', value: brands.length },
    { label: 'Tipos', value: types.length },
    { label: 'Comentarios', value: comments.length },
  ]

  return (
    <div className="container py-4">
      <div className="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-3">
        <div>
          <h1 className="h4 font-display mb-1">Panel de administración</h1>
          <p className="text-muted small mb-0">
            Alta, edición y baja de la información base del catálogo (dispositivos, marcas, tipos y comentarios).
          </p>
        </div>
        <div className="d-flex align-items-center gap-2">
          {username && <span className="text-muted small">Sesión: {username}</span>}
          <button className="btn btn-sm btn-outline-graphite" onClick={handleLogout}>
            Cerrar sesión
          </button>
        </div>
      </div>

      <div className="admin-stats mb-3">
        {stats.map((s) => (
          <div className="admin-stat" key={s.label}>
            <span className="admin-stat-value font-mono">{s.value}</span>
            <span className="admin-stat-label">{s.label}</span>
          </div>
        ))}
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
