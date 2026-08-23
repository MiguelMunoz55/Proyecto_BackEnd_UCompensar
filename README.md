# SpecHub — Catálogo de dispositivos inteligentes

Sitio web para explorar celulares, portátiles, tablets y smartwatches, ver su
ficha técnica y reseña, y dejar comentarios/calificaciones. Incluye un panel
de administración para gestionar los datos base del catálogo.

**Alcance de esta entrega:** el front-end completo en **React**. El backend
queda **diseñado** (arquitectura en capas para una API en Java/Spring Boot y
modelo entidad-relación de la base de datos) pero no implementado — ver
`docs/`.

## Estructura del repositorio

```
smart-devices/
├── frontend/          Aplicación React (Vite + React Router + Bootstrap)
└── docs/
    ├── ARQUITECTURA-BACKEND.md        Diseño de la futura API en Java
    ├── MODELO-ENTIDAD-RELACION.md     Modelo entidad-relación (Mermaid + diccionario de datos)
    └── schema.sql                     DDL de referencia (PostgreSQL/MySQL)
```

## Funcionalidades

- **Listado (`/`)**: dispositivos organizados por fecha de lanzamiento,
  marca y tipo, con buscador por nombre/marca y filtros de marca, precio
  máximo y orden.
- **Detalle (`/dispositivos/:id`)**: ficha técnica completa, reseña/sinopsis,
  precio, calificación promedio y dispositivos relacionados.
- **Comentarios**: cada dispositivo permite calificar (1-5 estrellas) y
  dejar una opinión, visible de inmediato en la ficha.
- **Panel de administración (`/admin`)**: alta, edición y baja de
  dispositivos (incluida su ficha técnica dinámica), gestión de marcas y
  tipos, y moderación de comentarios.

## Cómo ejecutar el front-end

```bash
cd frontend
npm install
npm run dev
```

Abre la URL que indique la terminal (por defecto `http://localhost:5173`).

Para generar la build de producción:

```bash
npm run build
npm run preview
```

## Persistencia de datos (mientras no existe backend)

La app arranca con datos de demostración (`src/data/seed*.js`). Los cambios
hechos desde el panel de administración (crear/editar/eliminar dispositivos,
marcas, tipos y comentarios) se guardan en `localStorage` del navegador para
que sobrevivan a un refresco de página durante la evaluación. El botón
**"Restaurar datos de demo"** del panel admin vuelve a los datos originales.

Toda esta lógica vive en `src/context/DataContext.jsx`, escrita para que el
mismo contrato de datos se pueda conectar más adelante a la API REST descrita
en `docs/ARQUITECTURA-BACKEND.md` sin tener que rehacer las páginas.

## Stack técnico

- **React 19** + **React Router 7** (SPA con rutas para catálogo, detalle y admin)
- **Bootstrap 5** como framework CSS base, con una capa de tokens de diseño
  propios (`src/index.css`) para tipografía, color y componentes tipo
  "ficha técnica"
- **Context API + useReducer** como manejo de estado global
- Sin backend: capa de datos en memoria/`localStorage` que emula la futura API
