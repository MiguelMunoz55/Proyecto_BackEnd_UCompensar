export default function Footer() {
  return (
    <footer className="site-footer">
      <div className="container d-flex flex-column flex-md-row justify-content-between gap-2">
        <span>© {new Date().getFullYear()} SpecHub · Catálogo académico de dispositivos inteligentes</span>
        <span className="font-mono">Proyecto de práctica · Front-end en React</span>
      </div>
    </footer>
  )
}
