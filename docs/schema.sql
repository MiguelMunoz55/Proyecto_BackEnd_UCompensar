-- =============================================================
-- SpecHub · Esquema de base de datos (PostgreSQL / MySQL compatible)
-- Corresponde al modelo entidad-relación documentado en
-- MODELO-ENTIDAD-RELACION.md
-- =============================================================

CREATE TABLE brand (
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(80)  NOT NULL UNIQUE,
    country     VARCHAR(60)
);

CREATE TABLE device_type (
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(60)  NOT NULL UNIQUE,
    slug        VARCHAR(60)  NOT NULL UNIQUE
);

CREATE TABLE device (
    id                  BIGSERIAL PRIMARY KEY,
    name                VARCHAR(120) NOT NULL,
    brand_id            BIGINT NOT NULL REFERENCES brand(id),
    type_id             BIGINT NOT NULL REFERENCES device_type(id),
    release_date        DATE NOT NULL,
    price               NUMERIC(12,2) NOT NULL CHECK (price >= 0),
    currency            VARCHAR(3) NOT NULL DEFAULT 'COP',
    short_description   VARCHAR(200),
    review              TEXT,
    main_image_tone     VARCHAR(40),
    created_at          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_device_brand ON device(brand_id);
CREATE INDEX idx_device_type ON device(type_id);
CREATE INDEX idx_device_release_date ON device(release_date);

CREATE TABLE device_spec (
    id              BIGSERIAL PRIMARY KEY,
    device_id       BIGINT NOT NULL REFERENCES device(id) ON DELETE CASCADE,
    spec_key        VARCHAR(80) NOT NULL,
    spec_value      VARCHAR(200) NOT NULL,
    display_order   INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_device_spec_device ON device_spec(device_id);

CREATE TABLE device_image (
    id              BIGSERIAL PRIMARY KEY,
    device_id       BIGINT NOT NULL REFERENCES device(id) ON DELETE CASCADE,
    image_url       VARCHAR(300) NOT NULL,
    alt_text        VARCHAR(150),
    display_order   INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_device_image_device ON device_image(device_id);

CREATE TABLE comment (
    id              BIGSERIAL PRIMARY KEY,
    device_id       BIGINT NOT NULL REFERENCES device(id) ON DELETE CASCADE,
    author_name     VARCHAR(100) NOT NULL,
    author_email    VARCHAR(150),
    rating          SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    content         TEXT NOT NULL,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_comment_device ON comment(device_id);

CREATE TABLE admin_user (
    id              BIGSERIAL PRIMARY KEY,
    username        VARCHAR(60) NOT NULL UNIQUE,
    password_hash   VARCHAR(255) NOT NULL,
    role            VARCHAR(20) NOT NULL DEFAULT 'ADMIN',
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================
-- Datos base de ejemplo
-- =============================================================
INSERT INTO device_type (name, slug) VALUES
    ('Celular', 'celular'),
    ('Portátil', 'portatil'),
    ('Tablet', 'tablet'),
    ('Smartwatch', 'smartwatch');

INSERT INTO brand (name, country) VALUES
    ('Samsung', 'Corea del Sur'),
    ('Apple', 'Estados Unidos'),
    ('Xiaomi', 'China'),
    ('Motorola', 'Estados Unidos'),
    ('Lenovo', 'China'),
    ('Asus', 'Taiwán'),
    ('HP', 'Estados Unidos');
