-- =============================================================
-- SpecHub · Esquema de base de datos (MySQL 8+)
-- Nombres de tablas y columnas en español, alineados con las
-- entidades JPA en com.spechub.api.model.
-- Corresponde al modelo entidad-relación documentado en
-- MODELO-ENTIDAD-RELACION.md
-- =============================================================

CREATE TABLE marca (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre      VARCHAR(80)  NOT NULL UNIQUE,
    pais        VARCHAR(60)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tipo_dispositivo (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre      VARCHAR(60)  NOT NULL UNIQUE,
    slug        VARCHAR(60)  NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE dispositivo (
    id                  BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre              VARCHAR(120) NOT NULL,
    marca_id            BIGINT NOT NULL,
    tipo_id             BIGINT NOT NULL,
    fecha_lanzamiento   DATE NOT NULL,
    precio              DECIMAL(12,2) NOT NULL,
    moneda              VARCHAR(3) NOT NULL DEFAULT 'COP',
    descripcion_corta   VARCHAR(200),
    resena              TEXT,
    tono_imagen         VARCHAR(40),
    creado_en           TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    actualizado_en      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_dispositivo_marca FOREIGN KEY (marca_id) REFERENCES marca(id),
    CONSTRAINT fk_dispositivo_tipo FOREIGN KEY (tipo_id) REFERENCES tipo_dispositivo(id),
    CONSTRAINT chk_dispositivo_precio CHECK (precio >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_dispositivo_marca ON dispositivo(marca_id);
CREATE INDEX idx_dispositivo_tipo ON dispositivo(tipo_id);
CREATE INDEX idx_dispositivo_fecha_lanzamiento ON dispositivo(fecha_lanzamiento);

CREATE TABLE especificacion_dispositivo (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    dispositivo_id  BIGINT NOT NULL,
    clave           VARCHAR(80) NOT NULL,
    valor           VARCHAR(200) NOT NULL,
    orden           INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_especificacion_dispositivo FOREIGN KEY (dispositivo_id) REFERENCES dispositivo(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_especificacion_dispositivo_id ON especificacion_dispositivo(dispositivo_id);

CREATE TABLE imagen_dispositivo (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    dispositivo_id  BIGINT NOT NULL,
    url_imagen      VARCHAR(300) NOT NULL,
    texto_alternativo VARCHAR(150),
    orden           INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_imagen_dispositivo FOREIGN KEY (dispositivo_id) REFERENCES dispositivo(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_imagen_dispositivo_id ON imagen_dispositivo(dispositivo_id);

CREATE TABLE comentario (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    dispositivo_id  BIGINT NOT NULL,
    nombre_autor    VARCHAR(100) NOT NULL,
    email_autor     VARCHAR(150),
    calificacion    SMALLINT NOT NULL,
    contenido       TEXT NOT NULL,
    creado_en       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_comentario_dispositivo FOREIGN KEY (dispositivo_id) REFERENCES dispositivo(id) ON DELETE CASCADE,
    CONSTRAINT chk_comentario_calificacion CHECK (calificacion BETWEEN 1 AND 5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_comentario_dispositivo ON comentario(dispositivo_id);

CREATE TABLE usuario_admin (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario  VARCHAR(60) NOT NULL UNIQUE,
    contrasena_hash VARCHAR(255) NOT NULL,
    rol             VARCHAR(20) NOT NULL DEFAULT 'ADMIN',
    creado_en       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================================
-- Datos base de ejemplo
-- =============================================================
INSERT INTO tipo_dispositivo (nombre, slug) VALUES
    ('Celular', 'celular'),
    ('Portátil', 'portatil'),
    ('Tablet', 'tablet'),
    ('Smartwatch', 'smartwatch');

INSERT INTO marca (nombre, pais) VALUES
    ('Samsung', 'Corea del Sur'),
    ('Apple', 'Estados Unidos'),
    ('Xiaomi', 'China'),
    ('Motorola', 'Estados Unidos'),
    ('Lenovo', 'China'),
    ('Asus', 'Taiwán'),
    ('HP', 'Estados Unidos');

-- Usuario admin de arranque: username "admin", contraseña "admin123".
-- Cambia la contraseña (o borra este usuario y crea el tuyo) antes de producción.
INSERT INTO usuario_admin (nombre_usuario, contrasena_hash, rol) VALUES
    ('admin', '$2b$10$MFLvOZVQOoQi2ayi4h2eVOc74eyqdZ8yngzqtZ9vvux0ko2IXTEq6', 'ADMIN');
