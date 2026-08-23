# Arquitectura del backend (diseño) — API en Java

> **Estado:** este documento describe el diseño de la API que consumirá el
> front-end de SpecHub. **No está implementada todavía** — el alcance actual
> del proyecto es el front-end en React, que simula estas respuestas con
> datos en memoria (`frontend/src/context/DataContext.jsx`). Este diseño
> queda listo para una siguiente iteración del proyecto.

## 1. Estilo de arquitectura

Arquitectura en capas (*layered architecture*) sobre **Spring Boot 3 / Java
17+**, exponiendo una API REST consumida por el front-end React vía JSON.

```
┌─────────────────────────────────────────────────────────┐
│  Cliente (React SPA)                                     │
└───────────────────────────┬────────────────────────────-─┘
                             │ HTTPS / JSON
┌───────────────────────────▼────────────────────────────-─┐
│  CAPA WEB (controller)                                    │
│  - Recibe HTTP, valida DTOs de entrada (Bean Validation)   │
│  - Traduce excepciones de negocio a códigos HTTP           │
├─────────────────────────────────────────────────────────-─┤
│  CAPA DE SERVICIO (service)                                │
│  - Reglas de negocio: filtros de catálogo, promedios de    │
│    calificación, validaciones de dominio                   │
│  - Orquesta transacciones (@Transactional)                 │
├─────────────────────────────────────────────────────────-─┤
│  CAPA DE ACCESO A DATOS (repository)                        │
│  - Spring Data JPA: DeviceRepository, BrandRepository...     │
│  - Consultas derivadas y @Query específicas                  │
├─────────────────────────────────────────────────────────-─┤
│  CAPA DE PERSISTENCIA (entity / base de datos)                │
│  - Entidades JPA mapeadas 1:1 al modelo entidad-relación       │
│  - PostgreSQL (o MySQL) — ver docs/schema.sql                  │
└─────────────────────────────────────────────────────────-─┘
```

Cada capa solo conoce a la inmediatamente inferior (el controller nunca usa
un repository directamente, por ejemplo), lo que permite cambiar la base de
datos o la capa web sin reescribir las reglas de negocio.

## 2. Paquetes propuestos

```
com.spechub.api
├── controller/       DeviceController, BrandController, DeviceTypeController,
│                     CommentController, AdminAuthController
├── service/           DeviceService, CommentService, CatalogService (+ impl/)
├── repository/         DeviceRepository, BrandRepository, DeviceTypeRepository,
│                       CommentRepository, AdminUserRepository
├── model/ (entity)      Device, Brand, DeviceType, DeviceSpec, DeviceImage,
│                        Comment, AdminUser
├── dto/                 DeviceSummaryDTO, DeviceDetailDTO, DeviceRequestDTO,
│                        CommentRequestDTO, CommentResponseDTO
├── mapper/               DeviceMapper, CommentMapper (MapStruct)
├── config/                SecurityConfig, CorsConfig, OpenApiConfig
├── exception/              ResourceNotFoundException, GlobalExceptionHandler
└── security/                JwtService, JwtAuthFilter
```

## 3. Endpoints REST propuestos

| Método | Ruta | Descripción | Acceso |
|---|---|---|---|
| GET | `/api/devices` | Lista dispositivos con filtros `?type=celular&brandId=&maxPrice=&q=&sort=` | Público |
| GET | `/api/devices/{id}` | Detalle de un dispositivo (specs, imágenes, promedio de calificación) | Público |
| POST | `/api/devices` | Crea un dispositivo | Admin |
| PUT | `/api/devices/{id}` | Edita un dispositivo | Admin |
| DELETE | `/api/devices/{id}` | Elimina un dispositivo (cascada a specs, imágenes y comentarios) | Admin |
| GET | `/api/brands` | Lista marcas | Público |
| POST | `/api/brands` | Crea marca | Admin |
| DELETE | `/api/brands/{id}` | Elimina marca (rechaza si tiene dispositivos asociados) | Admin |
| GET | `/api/device-types` | Lista tipos de dispositivo | Público |
| POST | `/api/device-types` | Crea tipo | Admin |
| GET | `/api/devices/{id}/comments` | Lista comentarios de un dispositivo | Público |
| POST | `/api/devices/{id}/comments` | Publica un comentario (nombre, calificación, texto) | Público (con rate-limit) |
| DELETE | `/api/comments/{id}` | Elimina un comentario | Admin |
| POST | `/api/auth/login` | Autentica un usuario admin y devuelve un JWT | Público |

Esta tabla es exactamente el contrato que hoy simula
`frontend/src/context/DataContext.jsx` (cada `dispatch` tiene, en comentario,
el endpoint equivalente), de modo que conectar el front real solo implica
reemplazar esas funciones por `fetch`/`axios` contra esta API.

## 4. Seguridad

- Endpoints públicos de lectura (catálogo, detalle, comentarios) sin
  autenticación.
- Publicar un comentario es público pero con *rate limiting* por IP para
  evitar spam.
- Rutas de administración (`POST/PUT/DELETE` de dispositivos, marcas, tipos
  y comentarios) protegidas con JWT emitido en `/api/auth/login`, validado
  por un `JwtAuthFilter` de Spring Security antes de llegar al controller.

## 5. Validación y manejo de errores

- DTOs de entrada anotados con Bean Validation (`@NotBlank`, `@Min`,
  `@Positive`, etc.).
- Un `@ControllerAdvice` (`GlobalExceptionHandler`) centraliza la traducción
  de excepciones de negocio a respuestas HTTP consistentes:
  - `ResourceNotFoundException` → 404
  - `ValidationException` / errores de Bean Validation → 400
  - Violación de integridad (marca en uso, etc.) → 409

## 6. Base de datos

Ver `MODELO-ENTIDAD-RELACION.md` y `schema.sql`. Se recomienda PostgreSQL en
producción y **Flyway** para versionar las migraciones del esquema junto con
el código de la API.

## 7. Cómo evoluciona el front-end actual hacia esta API

1. Sustituir las funciones de `DataContext.jsx` por una capa `services/api.js`
   que use `fetch`/`axios` contra las rutas de la tabla anterior.
2. Los componentes de React (`Home`, `DeviceDetail`, panel `admin/*`) no
   cambian: ya reciben los datos "enriquecidos" (dispositivo + marca + tipo +
   comentarios) a través de los mismos hooks (`useEnrichedDevices`,
   `useEnrichedDevice`), solo cambia de dónde vienen esos datos.
3. El login del panel admin pasa de no existir (acceso libre a `/admin`) a
   requerir el JWT de `/api/auth/login`.
