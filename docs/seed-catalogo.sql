-- =============================================================
-- SpecHub · Datos de catálogo migrados desde los seeds del
-- frontend (frontend/src/data/*.js) hacia MySQL.
-- Requiere que ya existan las tablas y los datos base de
-- marca/tipo_dispositivo insertados por schema.sql (mismo orden).
-- =============================================================

-- --- Dispositivos ---
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, moneda, descripcion_corta, resena, tono_imagen) VALUES (
    'Galaxy S24 Ultra', 1, 1, '2024-01-17', 5799900, 'COP',
    'Buque insignia con S Pen integrado y cámara de 200 MP.',
    'El Galaxy S24 Ultra mantiene el marco de titanio de su antecesor y suma un procesador más eficiente, lo que se nota en sesiones largas de cámara y juegos sin recalentarse. La pantalla es una de las más brillantes del mercado bajo sol directo, y las funciones de IA para edición de fotos son las más completas que hemos probado en un Android. El S Pen sigue siendo un diferencial real para tomar notas o firmar documentos, aunque su uso cotidiano depende mucho del perfil del usuario.',
    'phone-blue'
);
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, moneda, descripcion_corta, resena, tono_imagen) VALUES (
    'iPhone 15 Pro', 2, 1, '2023-09-22', 5399900, 'COP',
    'Chasis de titanio, botón de Acción y chip A17 Pro.',
    'El cambio a titanio hace que el iPhone 15 Pro se sienta notablemente más liviano que el modelo anterior sin perder rigidez. El botón de Acción es cómodo una vez se personaliza, y el puerto USB-C simplifica el ecosistema de cables. El rendimiento del A17 Pro sobresale en edición de video 4K directamente en el teléfono, aunque el salto de cámara frente a la generación anterior es más incremental que revolucionario.',
    'phone-graphite'
);
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, moneda, descripcion_corta, resena, tono_imagen) VALUES (
    'Xiaomi 14', 3, 1, '2024-02-25', 3299900, 'COP',
    'Óptica Leica y carga ultrarrápida de 90W.',
    'Xiaomi apostó por un cuerpo compacto poco común en la gama alta actual, lo que se agradece para uso a una mano. La colaboración con Leica se nota en el procesamiento de color, con tonos más naturales que otros teléfonos con tendencia a sobresaturar. La carga de 90W llena la batería en menos de 30 minutos, un punto fuerte frente a la competencia directa.',
    'phone-amber'
);
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, moneda, descripcion_corta, resena, tono_imagen) VALUES (
    'Motorola Edge 50 Pro', 4, 1, '2024-04-11', 2199900, 'COP',
    'Pantalla curva con certificación de brillo y carga 125W.',
    'El Edge 50 Pro ofrece una relación precio-características muy competitiva, con carga cableada de 125W que en la práctica llena el equipo en poco más de 20 minutos. La curvatura de la pantalla en los bordes es pronunciada y puede generar toques accidentales a quienes vienen de pantallas planas. El software cercano a Android puro es un acierto para quienes prefieren pocas capas de personalización.',
    'phone-teal'
);
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, moneda, descripcion_corta, resena, tono_imagen) VALUES (
    'MacBook Air 15" M3', 2, 2, '2024-03-08', 8999900, 'COP',
    'Portátil sin ventilador con chip M3 y pantalla de 15".',
    'La versión de 15 pulgadas del Air resuelve el principal reclamo del modelo anterior: espacio de pantalla para trabajo multitarea. El chip M3 mantiene el diseño sin ventilador, por lo que es completamente silencioso incluso en cargas de trabajo de edición de fotos o desarrollo. La autonomía real ronda las 15 horas de uso mixto, y el único punto débil sigue siendo el puerto único de expansión Thunderbolt para conectar periféricos simultáneos.',
    'laptop-graphite'
);
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, moneda, descripcion_corta, resena, tono_imagen) VALUES (
    'ThinkPad X1 Carbon Gen 12', 5, 2, '2024-01-05', 9899900, 'COP',
    'Ultraliviano empresarial con teclado insignia de Lenovo.',
    'El X1 Carbon sigue siendo la referencia de portátiles empresariales por su combinación de peso, robustez y uno de los mejores teclados del mercado para escritura prolongada. La certificación militar MIL-STD-810H da tranquilidad en viajes frecuentes. Su punto débil frente a alternativas de consumo es el precio, justificado por soporte, garantías extendidas y componentes reemplazables.',
    'laptop-blue'
);
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, moneda, descripcion_corta, resena, tono_imagen) VALUES (
    'ROG Zephyrus G14', 6, 2, '2024-02-15', 10499900, 'COP',
    'Portátil gamer compacto con GPU RTX 4070.',
    'Asus logra meter una RTX 4070 en un chasis de 14 pulgadas sin que el equipo se dispare de peso, aunque bajo carga sostenida el chasis de aluminio se calienta de forma perceptible. El panel Nebula con 165Hz responde muy bien tanto para juegos competitivos como para edición de color gracias a su cobertura de 100% DCI-P3. La autonomía fuera de juegos es sorprendentemente decente para un equipo de este segmento.',
    'laptop-purple'
);
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, moneda, descripcion_corta, resena, tono_imagen) VALUES (
    'HP Pavilion 15', 7, 2, '2023-11-20', 3599900, 'COP',
    'Portátil versátil para estudio y oficina en casa.',
    'El Pavilion 15 cumple bien las tareas cotidianas de ofimática, videollamadas y navegación con múltiples pestañas, aunque el almacenamiento de fábrica se siente justo para quienes trabajan con archivos pesados. La bisagra de 180 grados es útil para presentaciones compartidas. El chasis plástico resta algo de sensación premium frente a la competencia con cuerpos metálicos en un rango de precio similar.',
    'laptop-teal'
);
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, moneda, descripcion_corta, resena, tono_imagen) VALUES (
    'iPad Air M2', 2, 3, '2024-05-15', 3199900, 'COP',
    'Tablet delgada con chip M2 y soporte para Apple Pencil Pro.',
    'El salto al chip M2 le da al iPad Air un margen de rendimiento que en el uso diario resulta más que suficiente y que además prepara el equipo para varios años de actualizaciones de software. El soporte del nuevo Apple Pencil Pro con funciones de presión y giro es un plus real para ilustración digital. Su mayor limitante sigue siendo iPadOS, que no aprovecha del todo el potencial multitarea del hardware.',
    'tablet-graphite'
);
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, moneda, descripcion_corta, resena, tono_imagen) VALUES (
    'Galaxy Tab S9', 1, 3, '2023-08-11', 3799900, 'COP',
    'Tablet insignia de Samsung con resistencia IP68 y S Pen incluido.',
    'Samsung incluye el S Pen en la caja, algo que la competencia suele cobrar aparte, y eso mejora bastante la propuesta de valor. La pantalla AMOLED con 120Hz es de las mejores del segmento para consumo de video y lectura. DeX permite un modo escritorio funcional al conectar un monitor externo, aunque las apps de Android siguen sin optimizarse tan bien como en iPadOS para pantallas grandes.',
    'tablet-blue'
);
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, moneda, descripcion_corta, resena, tono_imagen) VALUES (
    'Apple Watch Series 9', 2, 4, '2023-09-22', 2099900, 'COP',
    'Smartwatch con chip S9 y gesto de doble toque.',
    'El gesto de doble toque para responder llamadas o pausar música sin tocar la pantalla es la novedad más práctica de esta generación, especialmente útil mientras se cocina o se hace ejercicio. La pantalla alcanza 2000 nits, muy visible bajo sol intenso. La autonomía sigue siendo el límite de la categoría: un día completo con uso normal, lo que obliga a una rutina de carga nocturna o durante duchas.',
    'watch-graphite'
);
INSERT INTO dispositivo (nombre, marca_id, tipo_id, fecha_lanzamiento, precio, moneda, descripcion_corta, resena, tono_imagen) VALUES (
    'Galaxy Watch 6', 1, 4, '2023-08-11', 1499900, 'COP',
    'Smartwatch Android con seguimiento de sueño avanzado.',
    'El Galaxy Watch 6 vuelve al bisel físico rotatorio en la versión Classic, una mejora de usabilidad muy pedida por los usuarios de la generación anterior. El seguimiento de sueño con puntuación detallada es de los más completos en Wear OS. Su integración es más fluida con teléfonos Samsung que con otras marcas Android, lo que conviene tener en cuenta antes de comprarlo fuera del ecosistema Galaxy.',
    'watch-teal'
);

-- --- Especificaciones (ficha técnica clave/valor) ---
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (1, 'Pantalla', '6.8" QHD+ Dynamic AMOLED 2X, 120Hz', 0);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (1, 'Procesador', 'Snapdragon 8 Gen 3 for Galaxy', 1);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (1, 'RAM', '12 GB', 2);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (1, 'Almacenamiento', '256 GB', 3);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (1, 'Cámara principal', '200 MP + 12 MP UGA + 50 MP tele + 10 MP tele', 4);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (1, 'Batería', '5000 mAh, carga 45W', 5);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (1, 'Sistema operativo', 'Android 14 con One UI 6.1', 6);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (1, 'Conectividad', '5G, Wi-Fi 7, Bluetooth 5.3', 7);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (1, 'Resistencia', 'IP68', 8);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (1, 'Peso', '232 g', 9);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (2, 'Pantalla', '6.1" Super Retina XDR OLED, 120Hz', 0);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (2, 'Procesador', 'Apple A17 Pro', 1);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (2, 'RAM', '8 GB', 2);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (2, 'Almacenamiento', '256 GB', 3);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (2, 'Cámara principal', '48 MP + 12 MP ultra gran angular + 12 MP tele', 4);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (2, 'Batería', 'Hasta 23h de video, carga rápida 20W', 5);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (2, 'Sistema operativo', 'iOS 17', 6);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (2, 'Conectividad', '5G, Wi-Fi 6E, Bluetooth 5.3, USB-C', 7);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (2, 'Resistencia', 'IP68', 8);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (2, 'Peso', '187 g', 9);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (3, 'Pantalla', '6.36" LTPO AMOLED, 120Hz', 0);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (3, 'Procesador', 'Snapdragon 8 Gen 3', 1);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (3, 'RAM', '12 GB', 2);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (3, 'Almacenamiento', '256 GB', 3);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (3, 'Cámara principal', '50 MP Leica + 50 MP ultra gran angular + 50 MP tele', 4);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (3, 'Batería', '4610 mAh, carga 90W', 5);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (3, 'Sistema operativo', 'Android 14 con HyperOS', 6);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (3, 'Conectividad', '5G, Wi-Fi 7, Bluetooth 5.4', 7);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (3, 'Resistencia', 'IP68', 8);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (3, 'Peso', '193 g', 9);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (4, 'Pantalla', '6.7" P-OLED curva, 144Hz', 0);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (4, 'Procesador', 'Snapdragon 7 Gen 3', 1);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (4, 'RAM', '12 GB', 2);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (4, 'Almacenamiento', '512 GB', 3);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (4, 'Cámara principal', '50 MP + 13 MP ultra gran angular + 10 MP tele', 4);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (4, 'Batería', '4500 mAh, carga 125W', 5);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (4, 'Sistema operativo', 'Android 14', 6);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (4, 'Conectividad', '5G, Wi-Fi 6, Bluetooth 5.3', 7);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (4, 'Resistencia', 'IP68', 8);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (4, 'Peso', '186 g', 9);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (5, 'Pantalla', '15.3" Liquid Retina, 500 nits', 0);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (5, 'Procesador', 'Apple M3 (8 núcleos CPU)', 1);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (5, 'RAM', '16 GB unificada', 2);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (5, 'Almacenamiento', '512 GB SSD', 3);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (5, 'Gráficos', 'GPU de 10 núcleos integrada', 4);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (5, 'Batería', 'Hasta 18h, carga rápida 70W', 5);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (5, 'Sistema operativo', 'macOS Sonoma', 6);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (5, 'Conectividad', 'Wi-Fi 6E, Bluetooth 5.3, 2x Thunderbolt', 7);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (5, 'Peso', '1.51 kg', 8);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (6, 'Pantalla', '14" WUXGA IPS, 400 nits', 0);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (6, 'Procesador', 'Intel Core Ultra 7 155U', 1);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (6, 'RAM', '32 GB LPDDR5x', 2);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (6, 'Almacenamiento', '1 TB SSD NVMe', 3);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (6, 'Gráficos', 'Intel Graphics integrada', 4);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (6, 'Batería', 'Hasta 15h, carga rápida 65W', 5);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (6, 'Sistema operativo', 'Windows 11 Pro', 6);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (6, 'Conectividad', 'Wi-Fi 6E, Bluetooth 5.3, 2x Thunderbolt 4', 7);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (6, 'Peso', '1.12 kg', 8);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (7, 'Pantalla', '14" QHD+ Nebula Display, 165Hz', 0);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (7, 'Procesador', 'AMD Ryzen 9 8945HS', 1);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (7, 'RAM', '32 GB DDR5', 2);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (7, 'Almacenamiento', '1 TB SSD NVMe', 3);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (7, 'Gráficos', 'NVIDIA GeForce RTX 4070 8GB', 4);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (7, 'Batería', '76 Wh, carga rápida 100W', 5);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (7, 'Sistema operativo', 'Windows 11 Home', 6);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (7, 'Conectividad', 'Wi-Fi 6E, Bluetooth 5.3, USB-C con DisplayPort', 7);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (7, 'Peso', '1.65 kg', 8);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (8, 'Pantalla', '15.6" FHD IPS, 250 nits', 0);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (8, 'Procesador', 'Intel Core i5-1335U', 1);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (8, 'RAM', '16 GB DDR4', 2);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (8, 'Almacenamiento', '512 GB SSD', 3);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (8, 'Gráficos', 'Intel Iris Xe integrada', 4);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (8, 'Batería', 'Hasta 10h, carga rápida 45W', 5);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (8, 'Sistema operativo', 'Windows 11 Home', 6);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (8, 'Conectividad', 'Wi-Fi 6, Bluetooth 5.3, USB-C', 7);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (8, 'Peso', '1.75 kg', 8);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (9, 'Pantalla', '11" Liquid Retina IPS, 500 nits', 0);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (9, 'Procesador', 'Apple M2', 1);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (9, 'RAM', '8 GB', 2);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (9, 'Almacenamiento', '128 GB', 3);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (9, 'Cámara', '12 MP trasera, 12 MP frontal ultra gran angular', 4);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (9, 'Batería', 'Hasta 10h de uso mixto', 5);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (9, 'Sistema operativo', 'iPadOS 17', 6);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (9, 'Conectividad', 'Wi-Fi 6E, Bluetooth 5.3, USB-C', 7);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (9, 'Peso', '462 g', 8);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (10, 'Pantalla', '11" Dynamic AMOLED 2X, 120Hz', 0);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (10, 'Procesador', 'Snapdragon 8 Gen 2 for Galaxy', 1);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (10, 'RAM', '8 GB', 2);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (10, 'Almacenamiento', '128 GB', 3);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (10, 'Cámara', '13 MP trasera, 12 MP frontal', 4);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (10, 'Batería', '8400 mAh, carga 45W', 5);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (10, 'Sistema operativo', 'Android 13 con One UI 5.1', 6);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (10, 'Conectividad', 'Wi-Fi 6E, Bluetooth 5.3, USB-C', 7);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (10, 'Resistencia', 'IP68', 8);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (10, 'Peso', '498 g', 9);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (11, 'Pantalla', 'Retina LTPO OLED, 2000 nits', 0);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (11, 'Procesador', 'Apple S9 SiP', 1);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (11, 'Almacenamiento', '64 GB', 2);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (11, 'Sensores', 'Oxígeno en sangre, ECG, temperatura', 3);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (11, 'Batería', 'Hasta 18h, carga rápida', 4);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (11, 'Sistema operativo', 'watchOS 10', 5);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (11, 'Conectividad', 'Wi-Fi, Bluetooth 5.3, GPS', 6);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (11, 'Resistencia', 'WR50, IP6X', 7);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (11, 'Peso', '38.7 g (caja 45mm)', 8);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (12, 'Pantalla', 'Super AMOLED, 1000 nits', 0);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (12, 'Procesador', 'Exynos W930', 1);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (12, 'Almacenamiento', '16 GB', 2);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (12, 'Sensores', 'BioActive (FC, oxígeno, bioimpedancia)', 3);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (12, 'Batería', '300 mAh, hasta 40h', 4);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (12, 'Sistema operativo', 'Wear OS 4 con One UI Watch', 5);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (12, 'Conectividad', 'Wi-Fi, Bluetooth 5.3, NFC', 6);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (12, 'Resistencia', '5ATM, IP68', 7);
INSERT INTO especificacion_dispositivo (dispositivo_id, clave, valor, orden) VALUES (12, 'Peso', '28.7 g (caja 40mm)', 8);

-- --- Comentarios de ejemplo ---
INSERT INTO comentario (dispositivo_id, nombre_autor, calificacion, contenido, creado_en) VALUES (1, 'Laura M.', 5, 'Lo compré para uso profesional de fotografía y el zoom de 5x es sorprendentemente nítido. La batería me rinde el día completo con uso intenso.', '2024-03-02 12:00:00');
INSERT INTO comentario (dispositivo_id, nombre_autor, calificacion, contenido, creado_en) VALUES (1, 'Carlos R.', 4, 'Excelente pantalla, pero se siente pesado en la mano después de un rato de uso continuo. Aun así, muy recomendado si vienes de un S22 Ultra.', '2024-03-18 12:00:00');
INSERT INTO comentario (dispositivo_id, nombre_autor, calificacion, contenido, creado_en) VALUES (2, 'Daniela P.', 5, 'El cambio a USB-C simplificó mi vida, ya no cargo dos cables distintos. El chip A17 Pro se nota fluido incluso editando video en 4K.', '2024-01-10 12:00:00');
INSERT INTO comentario (dispositivo_id, nombre_autor, calificacion, contenido, creado_en) VALUES (5, 'Andrés G.', 5, 'Trabajo con diseño gráfico y el M3 mueve Figma y Photoshop sin esfuerzo, todo en completo silencio. La pantalla de 15" fue el cambio que necesitaba.', '2024-04-02 12:00:00');
INSERT INTO comentario (dispositivo_id, nombre_autor, calificacion, contenido, creado_en) VALUES (6, 'María J.', 5, 'El mejor teclado que he usado en un portátil. Lo llevo a todas partes por el peso y aguanta bien una jornada completa de reuniones por Teams.', '2024-02-01 12:00:00');
INSERT INTO comentario (dispositivo_id, nombre_autor, calificacion, contenido, creado_en) VALUES (7, 'Julián S.', 4, 'Muy potente para su tamaño, pero en juegos exigentes se calienta y los ventiladores se escuchan bastante. Aun así, imbatible en portabilidad para gaming.', '2024-03-11 12:00:00');
INSERT INTO comentario (dispositivo_id, nombre_autor, calificacion, contenido, creado_en) VALUES (11, 'Camila V.', 4, 'El doble toque es más útil de lo que esperaba. Mi única queja es la batería: toca cargarlo todos los días sin excepción.', '2024-01-22 12:00:00');
