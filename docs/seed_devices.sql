-- =============================================================
-- SpecHub · Datos semilla de dispositivos, migrados desde
-- frontend/src/data/seedDevices.js, seedComments.js
-- Requiere que marca y tipo_dispositivo ya tengan los datos base
-- insertados por la primera parte de este mismo schema.sql.
-- =============================================================

-- Galaxy S24 Ultra
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, descripcion_corta, resena, tono_imagen) VALUES (
    'Galaxy S24 Ultra',
    (SELECT id FROM marca WHERE nombre = 'Samsung'),
    (SELECT id FROM tipo_dispositivo WHERE slug = 'celular'),
    '2024-01-17',
    5799900,
    'Buque insignia con S Pen integrado y cámara de 200 MP.',
    'El Galaxy S24 Ultra mantiene el marco de titanio de su antecesor y suma un procesador más eficiente, lo que se nota en sesiones largas de cámara y juegos sin recalentarse. La pantalla es una de las más brillantes del mercado bajo sol directo, y las funciones de IA para edición de fotos son las más completas que hemos probado en un Android. El S Pen sigue siendo un diferencial real para tomar notas o firmar documentos, aunque su uso cotidiano depende mucho del perfil del usuario.',
    'phone-blue'
);
SET @dispositivo_id = LAST_INSERT_ID();

INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES
    (@dispositivo_id, 'Pantalla', '6.8" QHD+ Dynamic AMOLED 2X, 120Hz', 0),
    (@dispositivo_id, 'Procesador', 'Snapdragon 8 Gen 3 for Galaxy', 1),
    (@dispositivo_id, 'RAM', '12 GB', 2),
    (@dispositivo_id, 'Almacenamiento', '256 GB', 3),
    (@dispositivo_id, 'Cámara principal', '200 MP + 12 MP UGA + 50 MP tele + 10 MP tele', 4),
    (@dispositivo_id, 'Batería', '5000 mAh, carga 45W', 5),
    (@dispositivo_id, 'Sistema operativo', 'Android 14 con One UI 6.1', 6),
    (@dispositivo_id, 'Conectividad', '5G, Wi-Fi 7, Bluetooth 5.3', 7),
    (@dispositivo_id, 'Resistencia', 'IP68', 8),
    (@dispositivo_id, 'Peso', '232 g', 9);

INSERT INTO comentario (dispositivo_id, nombre_autor, calificacion, contenido, creado_en) VALUES
    (@dispositivo_id, 'Laura M.', 5, 'Lo compré para uso profesional de fotografía y el zoom de 5x es sorprendentemente nítido. La batería me rinde el día completo con uso intenso.', '2024-03-02 12:00:00'),
    (@dispositivo_id, 'Carlos R.', 4, 'Excelente pantalla, pero se siente pesado en la mano después de un rato de uso continuo. Aun así, muy recomendado si vienes de un S22 Ultra.', '2024-03-18 12:00:00');


-- iPhone 15 Pro
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, descripcion_corta, resena, tono_imagen) VALUES (
    'iPhone 15 Pro',
    (SELECT id FROM marca WHERE nombre = 'Apple'),
    (SELECT id FROM tipo_dispositivo WHERE slug = 'celular'),
    '2023-09-22',
    5399900,
    'Chasis de titanio, botón de Acción y chip A17 Pro.',
    'El cambio a titanio hace que el iPhone 15 Pro se sienta notablemente más liviano que el modelo anterior sin perder rigidez. El botón de Acción es cómodo una vez se personaliza, y el puerto USB-C simplifica el ecosistema de cables. El rendimiento del A17 Pro sobresale en edición de video 4K directamente en el teléfono, aunque el salto de cámara frente a la generación anterior es más incremental que revolucionario.',
    'phone-graphite'
);
SET @dispositivo_id = LAST_INSERT_ID();

INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES
    (@dispositivo_id, 'Pantalla', '6.1" Super Retina XDR OLED, 120Hz', 0),
    (@dispositivo_id, 'Procesador', 'Apple A17 Pro', 1),
    (@dispositivo_id, 'RAM', '8 GB', 2),
    (@dispositivo_id, 'Almacenamiento', '256 GB', 3),
    (@dispositivo_id, 'Cámara principal', '48 MP + 12 MP ultra gran angular + 12 MP tele', 4),
    (@dispositivo_id, 'Batería', 'Hasta 23h de video, carga rápida 20W', 5),
    (@dispositivo_id, 'Sistema operativo', 'iOS 17', 6),
    (@dispositivo_id, 'Conectividad', '5G, Wi-Fi 6E, Bluetooth 5.3, USB-C', 7),
    (@dispositivo_id, 'Resistencia', 'IP68', 8),
    (@dispositivo_id, 'Peso', '187 g', 9);

INSERT INTO comentario (dispositivo_id, nombre_autor, calificacion, contenido, creado_en) VALUES
    (@dispositivo_id, 'Daniela P.', 5, 'El cambio a USB-C simplificó mi vida, ya no cargo dos cables distintos. El chip A17 Pro se nota fluido incluso editando video en 4K.', '2024-01-10 12:00:00');


-- Xiaomi 14
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, descripcion_corta, resena, tono_imagen) VALUES (
    'Xiaomi 14',
    (SELECT id FROM marca WHERE nombre = 'Xiaomi'),
    (SELECT id FROM tipo_dispositivo WHERE slug = 'celular'),
    '2024-02-25',
    3299900,
    'Óptica Leica y carga ultrarrápida de 90W.',
    'Xiaomi apostó por un cuerpo compacto poco común en la gama alta actual, lo que se agradece para uso a una mano. La colaboración con Leica se nota en el procesamiento de color, con tonos más naturales que otros teléfonos con tendencia a sobresaturar. La carga de 90W llena la batería en menos de 30 minutos, un punto fuerte frente a la competencia directa.',
    'phone-amber'
);
SET @dispositivo_id = LAST_INSERT_ID();

INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES
    (@dispositivo_id, 'Pantalla', '6.36" LTPO AMOLED, 120Hz', 0),
    (@dispositivo_id, 'Procesador', 'Snapdragon 8 Gen 3', 1),
    (@dispositivo_id, 'RAM', '12 GB', 2),
    (@dispositivo_id, 'Almacenamiento', '256 GB', 3),
    (@dispositivo_id, 'Cámara principal', '50 MP Leica + 50 MP ultra gran angular + 50 MP tele', 4),
    (@dispositivo_id, 'Batería', '4610 mAh, carga 90W', 5),
    (@dispositivo_id, 'Sistema operativo', 'Android 14 con HyperOS', 6),
    (@dispositivo_id, 'Conectividad', '5G, Wi-Fi 7, Bluetooth 5.4', 7),
    (@dispositivo_id, 'Resistencia', 'IP68', 8),
    (@dispositivo_id, 'Peso', '193 g', 9);


-- Motorola Edge 50 Pro
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, descripcion_corta, resena, tono_imagen) VALUES (
    'Motorola Edge 50 Pro',
    (SELECT id FROM marca WHERE nombre = 'Motorola'),
    (SELECT id FROM tipo_dispositivo WHERE slug = 'celular'),
    '2024-04-11',
    2199900,
    'Pantalla curva con certificación de brillo y carga 125W.',
    'El Edge 50 Pro ofrece una relación precio-características muy competitiva, con carga cableada de 125W que en la práctica llena el equipo en poco más de 20 minutos. La curvatura de la pantalla en los bordes es pronunciada y puede generar toques accidentales a quienes vienen de pantallas planas. El software cercano a Android puro es un acierto para quienes prefieren pocas capas de personalización.',
    'phone-teal'
);
SET @dispositivo_id = LAST_INSERT_ID();

INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES
    (@dispositivo_id, 'Pantalla', '6.7" P-OLED curva, 144Hz', 0),
    (@dispositivo_id, 'Procesador', 'Snapdragon 7 Gen 3', 1),
    (@dispositivo_id, 'RAM', '12 GB', 2),
    (@dispositivo_id, 'Almacenamiento', '512 GB', 3),
    (@dispositivo_id, 'Cámara principal', '50 MP + 13 MP ultra gran angular + 10 MP tele', 4),
    (@dispositivo_id, 'Batería', '4500 mAh, carga 125W', 5),
    (@dispositivo_id, 'Sistema operativo', 'Android 14', 6),
    (@dispositivo_id, 'Conectividad', '5G, Wi-Fi 6, Bluetooth 5.3', 7),
    (@dispositivo_id, 'Resistencia', 'IP68', 8),
    (@dispositivo_id, 'Peso', '186 g', 9);


-- MacBook Air 15" M3
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, descripcion_corta, resena, tono_imagen) VALUES (
    'MacBook Air 15" M3',
    (SELECT id FROM marca WHERE nombre = 'Apple'),
    (SELECT id FROM tipo_dispositivo WHERE slug = 'portatil'),
    '2024-03-08',
    8999900,
    'Portátil sin ventilador con chip M3 y pantalla de 15".',
    'La versión de 15 pulgadas del Air resuelve el principal reclamo del modelo anterior: espacio de pantalla para trabajo multitarea. El chip M3 mantiene el diseño sin ventilador, por lo que es completamente silencioso incluso en cargas de trabajo de edición de fotos o desarrollo. La autonomía real ronda las 15 horas de uso mixto, y el único punto débil sigue siendo el puerto único de expansión Thunderbolt para conectar periféricos simultáneos.',
    'laptop-graphite'
);
SET @dispositivo_id = LAST_INSERT_ID();

INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES
    (@dispositivo_id, 'Pantalla', '15.3" Liquid Retina, 500 nits', 0),
    (@dispositivo_id, 'Procesador', 'Apple M3 (8 núcleos CPU)', 1),
    (@dispositivo_id, 'RAM', '16 GB unificada', 2),
    (@dispositivo_id, 'Almacenamiento', '512 GB SSD', 3),
    (@dispositivo_id, 'Gráficos', 'GPU de 10 núcleos integrada', 4),
    (@dispositivo_id, 'Batería', 'Hasta 18h, carga rápida 70W', 5),
    (@dispositivo_id, 'Sistema operativo', 'macOS Sonoma', 6),
    (@dispositivo_id, 'Conectividad', 'Wi-Fi 6E, Bluetooth 5.3, 2x Thunderbolt', 7),
    (@dispositivo_id, 'Peso', '1.51 kg', 8);

INSERT INTO comentario (dispositivo_id, nombre_autor, calificacion, contenido, creado_en) VALUES
    (@dispositivo_id, 'Andrés G.', 5, 'Trabajo con diseño gráfico y el M3 mueve Figma y Photoshop sin esfuerzo, todo en completo silencio. La pantalla de 15" fue el cambio que necesitaba.', '2024-04-02 12:00:00');


-- ThinkPad X1 Carbon Gen 12
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, descripcion_corta, resena, tono_imagen) VALUES (
    'ThinkPad X1 Carbon Gen 12',
    (SELECT id FROM marca WHERE nombre = 'Lenovo'),
    (SELECT id FROM tipo_dispositivo WHERE slug = 'portatil'),
    '2024-01-05',
    9899900,
    'Ultraliviano empresarial con teclado insignia de Lenovo.',
    'El X1 Carbon sigue siendo la referencia de portátiles empresariales por su combinación de peso, robustez y uno de los mejores teclados del mercado para escritura prolongada. La certificación militar MIL-STD-810H da tranquilidad en viajes frecuentes. Su punto débil frente a alternativas de consumo es el precio, justificado por soporte, garantías extendidas y componentes reemplazables.',
    'laptop-blue'
);
SET @dispositivo_id = LAST_INSERT_ID();

INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES
    (@dispositivo_id, 'Pantalla', '14" WUXGA IPS, 400 nits', 0),
    (@dispositivo_id, 'Procesador', 'Intel Core Ultra 7 155U', 1),
    (@dispositivo_id, 'RAM', '32 GB LPDDR5x', 2),
    (@dispositivo_id, 'Almacenamiento', '1 TB SSD NVMe', 3),
    (@dispositivo_id, 'Gráficos', 'Intel Graphics integrada', 4),
    (@dispositivo_id, 'Batería', 'Hasta 15h, carga rápida 65W', 5),
    (@dispositivo_id, 'Sistema operativo', 'Windows 11 Pro', 6),
    (@dispositivo_id, 'Conectividad', 'Wi-Fi 6E, Bluetooth 5.3, 2x Thunderbolt 4', 7),
    (@dispositivo_id, 'Peso', '1.12 kg', 8);

INSERT INTO comentario (dispositivo_id, nombre_autor, calificacion, contenido, creado_en) VALUES
    (@dispositivo_id, 'María J.', 5, 'El mejor teclado que he usado en un portátil. Lo llevo a todas partes por el peso y aguanta bien una jornada completa de reuniones por Teams.', '2024-02-01 12:00:00');


-- ROG Zephyrus G14
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, descripcion_corta, resena, tono_imagen) VALUES (
    'ROG Zephyrus G14',
    (SELECT id FROM marca WHERE nombre = 'Asus'),
    (SELECT id FROM tipo_dispositivo WHERE slug = 'portatil'),
    '2024-02-15',
    10499900,
    'Portátil gamer compacto con GPU RTX 4070.',
    'Asus logra meter una RTX 4070 en un chasis de 14 pulgadas sin que el equipo se dispare de peso, aunque bajo carga sostenida el chasis de aluminio se calienta de forma perceptible. El panel Nebula con 165Hz responde muy bien tanto para juegos competitivos como para edición de color gracias a su cobertura de 100% DCI-P3. La autonomía fuera de juegos es sorprendentemente decente para un equipo de este segmento.',
    'laptop-purple'
);
SET @dispositivo_id = LAST_INSERT_ID();

INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES
    (@dispositivo_id, 'Pantalla', '14" QHD+ Nebula Display, 165Hz', 0),
    (@dispositivo_id, 'Procesador', 'AMD Ryzen 9 8945HS', 1),
    (@dispositivo_id, 'RAM', '32 GB DDR5', 2),
    (@dispositivo_id, 'Almacenamiento', '1 TB SSD NVMe', 3),
    (@dispositivo_id, 'Gráficos', 'NVIDIA GeForce RTX 4070 8GB', 4),
    (@dispositivo_id, 'Batería', '76 Wh, carga rápida 100W', 5),
    (@dispositivo_id, 'Sistema operativo', 'Windows 11 Home', 6),
    (@dispositivo_id, 'Conectividad', 'Wi-Fi 6E, Bluetooth 5.3, USB-C con DisplayPort', 7),
    (@dispositivo_id, 'Peso', '1.65 kg', 8);

INSERT INTO comentario (dispositivo_id, nombre_autor, calificacion, contenido, creado_en) VALUES
    (@dispositivo_id, 'Julián S.', 4, 'Muy potente para su tamaño, pero en juegos exigentes se calienta y los ventiladores se escuchan bastante. Aun así, imbatible en portabilidad para gaming.', '2024-03-11 12:00:00');


-- HP Pavilion 15
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, descripcion_corta, resena, tono_imagen) VALUES (
    'HP Pavilion 15',
    (SELECT id FROM marca WHERE nombre = 'HP'),
    (SELECT id FROM tipo_dispositivo WHERE slug = 'portatil'),
    '2023-11-20',
    3599900,
    'Portátil versátil para estudio y oficina en casa.',
    'El Pavilion 15 cumple bien las tareas cotidianas de ofimática, videollamadas y navegación con múltiples pestañas, aunque el almacenamiento de fábrica se siente justo para quienes trabajan con archivos pesados. La bisagra de 180 grados es útil para presentaciones compartidas. El chasis plástico resta algo de sensación premium frente a la competencia con cuerpos metálicos en un rango de precio similar.',
    'laptop-teal'
);
SET @dispositivo_id = LAST_INSERT_ID();

INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES
    (@dispositivo_id, 'Pantalla', '15.6" FHD IPS, 250 nits', 0),
    (@dispositivo_id, 'Procesador', 'Intel Core i5-1335U', 1),
    (@dispositivo_id, 'RAM', '16 GB DDR4', 2),
    (@dispositivo_id, 'Almacenamiento', '512 GB SSD', 3),
    (@dispositivo_id, 'Gráficos', 'Intel Iris Xe integrada', 4),
    (@dispositivo_id, 'Batería', 'Hasta 10h, carga rápida 45W', 5),
    (@dispositivo_id, 'Sistema operativo', 'Windows 11 Home', 6),
    (@dispositivo_id, 'Conectividad', 'Wi-Fi 6, Bluetooth 5.3, USB-C', 7),
    (@dispositivo_id, 'Peso', '1.75 kg', 8);


-- iPad Air M2
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, descripcion_corta, resena, tono_imagen) VALUES (
    'iPad Air M2',
    (SELECT id FROM marca WHERE nombre = 'Apple'),
    (SELECT id FROM tipo_dispositivo WHERE slug = 'tablet'),
    '2024-05-15',
    3199900,
    'Tablet delgada con chip M2 y soporte para Apple Pencil Pro.',
    'El salto al chip M2 le da al iPad Air un margen de rendimiento que en el uso diario resulta más que suficiente y que además prepara el equipo para varios años de actualizaciones de software. El soporte del nuevo Apple Pencil Pro con funciones de presión y giro es un plus real para ilustración digital. Su mayor limitante sigue siendo iPadOS, que no aprovecha del todo el potencial multitarea del hardware.',
    'tablet-graphite'
);
SET @dispositivo_id = LAST_INSERT_ID();

INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES
    (@dispositivo_id, 'Pantalla', '11" Liquid Retina IPS, 500 nits', 0),
    (@dispositivo_id, 'Procesador', 'Apple M2', 1),
    (@dispositivo_id, 'RAM', '8 GB', 2),
    (@dispositivo_id, 'Almacenamiento', '128 GB', 3),
    (@dispositivo_id, 'Cámara', '12 MP trasera, 12 MP frontal ultra gran angular', 4),
    (@dispositivo_id, 'Batería', 'Hasta 10h de uso mixto', 5),
    (@dispositivo_id, 'Sistema operativo', 'iPadOS 17', 6),
    (@dispositivo_id, 'Conectividad', 'Wi-Fi 6E, Bluetooth 5.3, USB-C', 7),
    (@dispositivo_id, 'Peso', '462 g', 8);


-- Galaxy Tab S9
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, descripcion_corta, resena, tono_imagen) VALUES (
    'Galaxy Tab S9',
    (SELECT id FROM marca WHERE nombre = 'Samsung'),
    (SELECT id FROM tipo_dispositivo WHERE slug = 'tablet'),
    '2023-08-11',
    3799900,
    'Tablet insignia de Samsung con resistencia IP68 y S Pen incluido.',
    'Samsung incluye el S Pen en la caja, algo que la competencia suele cobrar aparte, y eso mejora bastante la propuesta de valor. La pantalla AMOLED con 120Hz es de las mejores del segmento para consumo de video y lectura. DeX permite un modo escritorio funcional al conectar un monitor externo, aunque las apps de Android siguen sin optimizarse tan bien como en iPadOS para pantallas grandes.',
    'tablet-blue'
);
SET @dispositivo_id = LAST_INSERT_ID();

INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES
    (@dispositivo_id, 'Pantalla', '11" Dynamic AMOLED 2X, 120Hz', 0),
    (@dispositivo_id, 'Procesador', 'Snapdragon 8 Gen 2 for Galaxy', 1),
    (@dispositivo_id, 'RAM', '8 GB', 2),
    (@dispositivo_id, 'Almacenamiento', '128 GB', 3),
    (@dispositivo_id, 'Cámara', '13 MP trasera, 12 MP frontal', 4),
    (@dispositivo_id, 'Batería', '8400 mAh, carga 45W', 5),
    (@dispositivo_id, 'Sistema operativo', 'Android 13 con One UI 5.1', 6),
    (@dispositivo_id, 'Conectividad', 'Wi-Fi 6E, Bluetooth 5.3, USB-C', 7),
    (@dispositivo_id, 'Resistencia', 'IP68', 8),
    (@dispositivo_id, 'Peso', '498 g', 9);


-- Apple Watch Series 9
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, descripcion_corta, resena, tono_imagen) VALUES (
    'Apple Watch Series 9',
    (SELECT id FROM marca WHERE nombre = 'Apple'),
    (SELECT id FROM tipo_dispositivo WHERE slug = 'smartwatch'),
    '2023-09-22',
    2099900,
    'Smartwatch con chip S9 y gesto de doble toque.',
    'El gesto de doble toque para responder llamadas o pausar música sin tocar la pantalla es la novedad más práctica de esta generación, especialmente útil mientras se cocina o se hace ejercicio. La pantalla alcanza 2000 nits, muy visible bajo sol intenso. La autonomía sigue siendo el límite de la categoría: un día completo con uso normal, lo que obliga a una rutina de carga nocturna o durante duchas.',
    'watch-graphite'
);
SET @dispositivo_id = LAST_INSERT_ID();

INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES
    (@dispositivo_id, 'Pantalla', 'Retina LTPO OLED, 2000 nits', 0),
    (@dispositivo_id, 'Procesador', 'Apple S9 SiP', 1),
    (@dispositivo_id, 'Almacenamiento', '64 GB', 2),
    (@dispositivo_id, 'Sensores', 'Oxígeno en sangre, ECG, temperatura', 3),
    (@dispositivo_id, 'Batería', 'Hasta 18h, carga rápida', 4),
    (@dispositivo_id, 'Sistema operativo', 'watchOS 10', 5),
    (@dispositivo_id, 'Conectividad', 'Wi-Fi, Bluetooth 5.3, GPS', 6),
    (@dispositivo_id, 'Resistencia', 'WR50, IP6X', 7),
    (@dispositivo_id, 'Peso', '38.7 g (caja 45mm)', 8);

INSERT INTO comentario (dispositivo_id, nombre_autor, calificacion, contenido, creado_en) VALUES
    (@dispositivo_id, 'Camila V.', 4, 'El doble toque es más útil de lo que esperaba. Mi única queja es la batería: toca cargarlo todos los días sin excepción.', '2024-01-22 12:00:00');


-- Galaxy Watch 6
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, descripcion_corta, resena, tono_imagen) VALUES (
    'Galaxy Watch 6',
    (SELECT id FROM marca WHERE nombre = 'Samsung'),
    (SELECT id FROM tipo_dispositivo WHERE slug = 'smartwatch'),
    '2023-08-11',
    1499900,
    'Smartwatch Android con seguimiento de sueño avanzado.',
    'El Galaxy Watch 6 vuelve al bisel físico rotatorio en la versión Classic, una mejora de usabilidad muy pedida por los usuarios de la generación anterior. El seguimiento de sueño con puntuación detallada es de los más completos en Wear OS. Su integración es más fluida con teléfonos Samsung que con otras marcas Android, lo que conviene tener en cuenta antes de comprarlo fuera del ecosistema Galaxy.',
    'watch-teal'
);
SET @dispositivo_id = LAST_INSERT_ID();

INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES
    (@dispositivo_id, 'Pantalla', 'Super AMOLED, 1000 nits', 0),
    (@dispositivo_id, 'Procesador', 'Exynos W930', 1),
    (@dispositivo_id, 'Almacenamiento', '16 GB', 2),
    (@dispositivo_id, 'Sensores', 'BioActive (FC, oxígeno, bioimpedancia)', 3),
    (@dispositivo_id, 'Batería', '300 mAh, hasta 40h', 4),
    (@dispositivo_id, 'Sistema operativo', 'Wear OS 4 con One UI Watch', 5),
    (@dispositivo_id, 'Conectividad', 'Wi-Fi, Bluetooth 5.3, NFC', 6),
    (@dispositivo_id, 'Resistencia', '5ATM, IP68', 7),
    (@dispositivo_id, 'Peso', '28.7 g (caja 40mm)', 8);

