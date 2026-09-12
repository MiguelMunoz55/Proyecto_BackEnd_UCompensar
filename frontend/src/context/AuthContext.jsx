import { createContext, useCallback, useContext, useMemo, useState } from 'react'

const API_BASE = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080/api'
const STORAGE_KEY = 'spechub_admin_auth'

const AuthContext = createContext(null)

function loadStoredAuth() {
  try {
    const raw = window.localStorage.getItem(STORAGE_KEY)
    return raw ? JSON.parse(raw) : null
  } catch {
    return null
  }
}

export function AuthProvider({ children }) {
  const [auth, setAuth] = useState(loadStoredAuth)

  const login = useCallback(async (username, password) => {
    const response = await fetch(`${API_BASE}/auth/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ username, password }),
    })

    if (!response.ok) {
      const body = await response.json().catch(() => null)
      throw new Error(body?.mensaje || 'Usuario o contraseña incorrectos')
    }

    const data = await response.json()
    const nextAuth = { token: data.token, username: data.username, role: data.role }
    window.localStorage.setItem(STORAGE_KEY, JSON.stringify(nextAuth))
    setAuth(nextAuth)
    return nextAuth
  }, [])

  const logout = useCallback(() => {
    window.localStorage.removeItem(STORAGE_KEY)
    setAuth(null)
  }, [])

  const value = useMemo(
    () => ({
      token: auth?.token || null,
      username: auth?.username || null,
      role: auth?.role || null,
      isAuthenticated: Boolean(auth?.token),
      login,
      logout,
    }),
    [auth, login, logout]
  )

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>
}

export function useAuth() {
  const ctx = useContext(AuthContext)
  if (!ctx) throw new Error('useAuth debe usarse dentro de <AuthProvider>')
  return ctx
}
