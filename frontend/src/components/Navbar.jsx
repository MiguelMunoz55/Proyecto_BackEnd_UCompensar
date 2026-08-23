import { NavLink } from 'react-router-dom'

export default function Navbar() {
  return (
    <div className="topbar">
      <div className="container d-flex align-items-center justify-content-between py-2">
        <NavLink to="/" className="brand">
          Spec<span>Hub</span>
        </NavLink>
        <nav className="topbar-nav d-flex gap-1">
          <NavLink to="/" end className={({ isActive }) => (isActive ? 'active' : '')}>
            Catálogo
          </NavLink>
          <NavLink to="/admin" className={({ isActive }) => (isActive ? 'active' : '')}>
            Panel admin
          </NavLink>
        </nav>
      </div>
    </div>
  )
}
