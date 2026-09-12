import { Route, Routes } from 'react-router-dom'
import Navbar from './components/Navbar'
import Footer from './components/Footer'
import Home from './pages/Home'
import DeviceDetail from './pages/DeviceDetail'
import AdminLayout from './pages/admin/AdminLayout'
import AdminLogin from './pages/admin/AdminLogin'
import RequireAuth from './pages/admin/RequireAuth'
import AdminDevices from './pages/admin/AdminDevices'
import DeviceForm from './pages/admin/DeviceForm'
import AdminTaxonomy from './pages/admin/AdminTaxonomy'
import AdminComments from './pages/admin/AdminComments'
import NotFound from './pages/NotFound'

export default function App() {
  return (
    <div className="d-flex flex-column min-vh-100">
      <Navbar />
      <main className="flex-grow-1">
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/dispositivos/:id" element={<DeviceDetail />} />

          <Route path="/admin/login" element={<AdminLogin />} />
          <Route
            path="/admin"
            element={
              <RequireAuth>
                <AdminLayout />
              </RequireAuth>
            }
          >
            <Route index element={<AdminDevices />} />
            <Route path="dispositivos/nuevo" element={<DeviceForm />} />
            <Route path="dispositivos/:id/editar" element={<DeviceForm />} />
            <Route path="taxonomia" element={<AdminTaxonomy />} />
            <Route path="comentarios" element={<AdminComments />} />
          </Route>

          <Route path="*" element={<NotFound />} />
        </Routes>
      </main>
      <Footer />
    </div>
  )
}
