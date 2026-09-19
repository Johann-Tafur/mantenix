-- ============================================================================
-- Mantenix — Datos de carga inicial (realistas, contexto Colombia)
-- Ejecutar despues de schema.sql
-- ============================================================================

USE mantenix_db;

-- ----------------------------------------------------------------------------
-- Catalogos
-- ----------------------------------------------------------------------------

INSERT INTO rol (nombre_rol) VALUES
  ('Administrador'), ('Recepcionista'), ('Tecnico'), ('Cliente');

INSERT INTO estado_orden (nombre_estado, orden_flujo) VALUES
  ('Pendiente', 1),
  ('Asignada', 2),
  ('En proceso', 3),
  ('Finalizada', 4),
  ('Entregada', 5),
  ('Cancelada', 6);

-- ----------------------------------------------------------------------------
-- Usuarios internos (staff)
-- Password de prueba para todos: Mantenix2026*  (hash real SHA2-256, solo para pruebas)
-- ----------------------------------------------------------------------------

INSERT INTO usuario (id_rol, nombre, correo, telefono, contrasena_hash, estado) VALUES
  ((SELECT id_rol FROM rol WHERE nombre_rol = 'Administrador'), 'Johann Tafur Farfán', 'johanntafurfarfan@gmail.com', '3001234567', SHA2('Mantenix2026*', 256), 'Activo'),
  ((SELECT id_rol FROM rol WHERE nombre_rol = 'Administrador'), 'Carlos Mario Cardona Valderrama', 'carlos.cardona@mantenix.com', '3007654321', SHA2('Mantenix2026*', 256), 'Activo'),
  ((SELECT id_rol FROM rol WHERE nombre_rol = 'Recepcionista'), 'Valentina Rojas Medina', 'valentina.rojas@mantenix.com', '3112345678', SHA2('Mantenix2026*', 256), 'Activo'),
  ((SELECT id_rol FROM rol WHERE nombre_rol = 'Recepcionista'), 'Sebastián Quintero Ávila', 'sebastian.quintero@mantenix.com', '3123456789', SHA2('Mantenix2026*', 256), 'Activo'),
  ((SELECT id_rol FROM rol WHERE nombre_rol = 'Tecnico'), 'Andrés Felipe Muñoz Castaño', 'andres.munoz@mantenix.com', '3134567890', SHA2('Mantenix2026*', 256), 'Activo'),
  ((SELECT id_rol FROM rol WHERE nombre_rol = 'Tecnico'), 'Kevin Santiago Bermúdez Ospina', 'kevin.bermudez@mantenix.com', '3145678901', SHA2('Mantenix2026*', 256), 'Activo'),
  ((SELECT id_rol FROM rol WHERE nombre_rol = 'Tecnico'), 'Fabián Alexander Pineda Gil', 'fabian.pineda@mantenix.com', '3156789012', SHA2('Mantenix2026*', 256), 'Activo');

-- Dos clientes con acceso al portal (HU-011)
INSERT INTO usuario (id_rol, nombre, correo, telefono, contrasena_hash, estado) VALUES
  ((SELECT id_rol FROM rol WHERE nombre_rol = 'Cliente'), 'Andrés Felipe Gómez Restrepo', 'andres.gomez.cliente@gmail.com', '3201112233', SHA2('Mantenix2026*', 256), 'Activo'),
  ((SELECT id_rol FROM rol WHERE nombre_rol = 'Cliente'), 'María Camila Rodríguez Pérez', 'camila.rodriguez.cliente@gmail.com', '3202223344', SHA2('Mantenix2026*', 256), 'Activo');

-- ----------------------------------------------------------------------------
-- Clientes
-- ----------------------------------------------------------------------------

INSERT INTO cliente (id_usuario, tipo_documento, numero_documento, nombre, telefono, correo, direccion) VALUES
  ((SELECT id_usuario FROM usuario WHERE correo = 'andres.gomez.cliente@gmail.com'), 'CC', '1035467890', 'Andrés Felipe Gómez Restrepo', '3201112233', 'andres.gomez.cliente@gmail.com', 'Cra 45 # 26-10, Bogotá'),
  ((SELECT id_usuario FROM usuario WHERE correo = 'camila.rodriguez.cliente@gmail.com'), 'CC', '1098234567', 'María Camila Rodríguez Pérez', '3202223344', 'camila.rodriguez.cliente@gmail.com', 'Cl 33 # 70-15, Medellín'),
  (NULL, 'NIT', '900123456-1', 'Transportes El Dorado S.A.S.', '3157894561', 'contacto@transporteseldorado.com', 'Av. Boyacá # 12-45, Bogotá'),
  (NULL, 'CC', '79876543', 'Jorge Iván Salazar Muñoz', '3178965412', 'jorge.salazar@hotmail.com', 'Cl 5 # 38-20, Cali'),
  (NULL, 'CC', '43567890', 'Luisa Fernanda Ortiz Vélez', '3189632587', 'luisa.ortiz@gmail.com', 'Cra 15 # 100-30, Bogotá'),
  (NULL, 'CC', '15678234', 'Carlos Eduardo Ramírez Toro', '3196547823', 'carlos.ramirez@yahoo.com', 'Cl 50 # 45-12, Medellín'),
  (NULL, 'CC', '52789456', 'Diana Patricia López Cárdenas', '3167894523', 'diana.lopez@gmail.com', 'Cra 7 # 60-25, Bogotá'),
  (NULL, 'NIT', '800456789-2', 'Distribuidora La Sabana Ltda.', '3125896347', 'compras@lasabanadistribuidora.com', 'Autopista Norte Km 3, Chía'),
  (NULL, 'CC', '1020345678', 'Juan Pablo Herrera Duque', '3134216598', 'juanpablo.herrera@gmail.com', 'Cl 80 # 20-55, Bogotá'),
  (NULL, 'CC', '1128456789', 'Sandra Milena Zapata Ríos', '3145897236', 'sandra.zapata@hotmail.com', 'Cra 65 # 30-40, Medellín');

-- ----------------------------------------------------------------------------
-- Vehiculos
-- ----------------------------------------------------------------------------

INSERT INTO vehiculo (id_cliente, placa, marca, modelo, anio, tipo_vehiculo, kilometraje_actual) VALUES
  ((SELECT id_cliente FROM cliente WHERE numero_documento = '1035467890'), 'AFG123', 'Chevrolet', 'Spark GT', 2019, 'Automovil', 41500),
  ((SELECT id_cliente FROM cliente WHERE numero_documento = '1098234567'), 'MCR456', 'Renault', 'Sandero', 2021, 'Automovil', 17600),
  ((SELECT id_cliente FROM cliente WHERE numero_documento = '900123456-1'), 'TED001', 'Chevrolet', 'NPR', 2018, 'Camion', 94500),
  ((SELECT id_cliente FROM cliente WHERE numero_documento = '900123456-1'), 'TED002', 'Nissan', 'NP300', 2020, 'Camioneta', 54000),
  ((SELECT id_cliente FROM cliente WHERE numero_documento = '900123456-1'), 'TED003', 'Chevrolet', 'NPR', 2020, 'Camion', 68200),
  ((SELECT id_cliente FROM cliente WHERE numero_documento = '79876543'), 'JIS789', 'Mazda', '3', 2017, 'Automovil', 76000),
  ((SELECT id_cliente FROM cliente WHERE numero_documento = '43567890'), 'LFO234', 'Kia', 'Picanto', 2022, 'Automovil', 14800),
  ((SELECT id_cliente FROM cliente WHERE numero_documento = '15678234'), 'CER567', 'Yamaha', 'FZ 2.0', 2020, 'Motocicleta', 21800),
  ((SELECT id_cliente FROM cliente WHERE numero_documento = '52789456'), 'DPL890', 'Toyota', 'Corolla', 2016, 'Automovil', 87500),
  ((SELECT id_cliente FROM cliente WHERE numero_documento = '800456789-2'), 'DLS010', 'Chevrolet', 'NHR', 2019, 'Camion', 60500),
  ((SELECT id_cliente FROM cliente WHERE numero_documento = '800456789-2'), 'DLS011', 'Renault', 'Duster', 2021, 'Camioneta', 33200),
  ((SELECT id_cliente FROM cliente WHERE numero_documento = '1020345678'), 'JPH345', 'AKT', 'NKD 125', 2023, 'Motocicleta', 7800),
  ((SELECT id_cliente FROM cliente WHERE numero_documento = '1128456789'), 'SMZ678', 'Ford', 'Explorer', 2015, 'Camioneta', 112000),
  ((SELECT id_cliente FROM cliente WHERE numero_documento = '1128456789'), 'SMZ679', 'Hyundai', 'Tucson', 2019, 'Camioneta', 46700);

-- ----------------------------------------------------------------------------
-- Catalogo de servicios de mantenimiento preventivo
-- ----------------------------------------------------------------------------

INSERT INTO servicio (nombre, descripcion, precio_base, duracion_estimada_min, intervalo_km, intervalo_meses, activo) VALUES
  ('Cambio de aceite y filtro', 'Cambio de aceite de motor y filtro de aceite', 120000, 45, 5000, 6, 1),
  ('Cambio de filtro de aire', 'Reemplazo del filtro de aire del motor', 45000, 20, 10000, 12, 1),
  ('Alineación y balanceo', 'Alineación de dirección y balanceo de llantas', 80000, 60, 10000, 6, 1),
  ('Cambio de pastillas de freno', 'Reemplazo de pastillas de freno delanteras o traseras', 150000, 90, 20000, 12, 1),
  ('Cambio de líquido de frenos', 'Purga y reemplazo de líquido de frenos DOT4', 60000, 40, 20000, 24, 1),
  ('Revisión y cambio de correa de distribución', 'Inspección y reemplazo preventivo de la correa de distribución', 450000, 180, 60000, 48, 1),
  ('Cambio de batería', 'Reemplazo de batería del vehículo', 280000, 30, NULL, 24, 1),
  ('Cambio de bujías', 'Reemplazo del juego de bujías', 90000, 50, 30000, 24, 1),
  ('Rotación de llantas', 'Rotación de llantas para desgaste uniforme', 35000, 30, 10000, 6, 1);

-- ----------------------------------------------------------------------------
-- Repuestos
-- ----------------------------------------------------------------------------

INSERT INTO repuesto (codigo_referencia, nombre, precio_unitario, stock_actual, stock_minimo) VALUES
  ('FLT-ACE-001', 'Filtro de aceite', 18000, 40, 10),
  ('ACE-15W40-001', 'Aceite motor 15W40 (galón)', 65000, 60, 15),
  ('FLT-AIR-001', 'Filtro de aire', 32000, 30, 8),
  ('PAST-FRE-DEL', 'Pastillas de freno delanteras (juego)', 95000, 20, 5),
  ('PAST-FRE-TRA', 'Pastillas de freno traseras (juego)', 85000, 20, 5),
  ('LIQ-FRE-001', 'Líquido de frenos DOT4 (litro)', 28000, 25, 6),
  ('BAT-12V-001', 'Batería 12V 45Ah', 320000, 10, 3),
  ('BUJ-IRID-001', 'Bujía de iridio (unidad)', 22000, 50, 12),
  ('CORR-DIST-001', 'Correa de distribución', 180000, 8, 3),
  ('LLAN-185-65', 'Llanta 185/65 R15', 310000, 16, 4),
  ('FLT-COMB-001', 'Filtro de combustible', 38000, 22, 6),
  ('AMORT-DEL-001', 'Amortiguador delantero (unidad)', 210000, 10, 3),
  ('CORR-ACC-001', 'Correa de accesorios', 65000, 15, 4),
  ('ACE-20W50-001', 'Aceite motor 20W50 moto (litro)', 32000, 30, 8),
  ('FLT-ACE-MOTO', 'Filtro de aceite moto', 15000, 25, 8);

-- ============================================================================
-- Ordenes de trabajo
--
-- Se insertan como 'Pendiente' y avanzan mediante UPDATE, para que los
-- triggers de costo_total, stock y calculo de proximo mantenimiento se
-- ejecuten igual que en el uso real del sistema.
--
-- Nota tecnica: el id de cada orden se guarda en la variable de sesion
-- @id_orden justo despues de crearla, y se reutiliza en los INSERT de
-- orden_servicio/orden_repuesto. Esto evita el error 1442 de MySQL
-- ("Can't update table ... because it is already used by statement which
-- invoked this trigger"), que ocurre si esos INSERT vuelven a leer
-- orden_trabajo en la misma sentencia que dispara un trigger que la escribe.
-- ============================================================================

-- ---- OT-2026-0001: Spark GT — aceite + rotación de llantas — Entregada ----
INSERT INTO orden_trabajo (numero_orden, id_vehiculo, id_recepcionista, id_estado, fecha_ingreso, kilometraje_ingreso)
VALUES ('OT-2026-0001',
  (SELECT id_vehiculo FROM vehiculo WHERE placa = 'AFG123'),
  (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'),
  (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'),
  '2026-06-10 08:15:00', 41800);
SET @id_orden := (SELECT id_orden FROM orden_trabajo WHERE numero_orden = 'OT-2026-0001');

INSERT INTO historial_estado_orden (id_orden, id_estado, id_usuario, fecha_cambio)
VALUES (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'),
  (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-06-10 08:15:00');

INSERT INTO orden_servicio (id_orden, id_servicio, precio_aplicado)
SELECT @id_orden, id_servicio, precio_base
FROM servicio WHERE nombre IN ('Cambio de aceite y filtro', 'Rotación de llantas');

SET @rep1_id := (SELECT id_repuesto FROM repuesto WHERE codigo_referencia = 'FLT-ACE-001');
SET @rep1_precio := (SELECT precio_unitario FROM repuesto WHERE codigo_referencia = 'FLT-ACE-001');
SET @rep2_id := (SELECT id_repuesto FROM repuesto WHERE codigo_referencia = 'ACE-15W40-001');
SET @rep2_precio := (SELECT precio_unitario FROM repuesto WHERE codigo_referencia = 'ACE-15W40-001');
INSERT INTO orden_repuesto (id_orden, id_repuesto, cantidad, precio_unitario_aplicado) VALUES
  (@id_orden, @rep1_id, 1, @rep1_precio),
  (@id_orden, @rep2_id, 4, @rep2_precio);

UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'),
  id_tecnico = (SELECT id_usuario FROM usuario WHERE correo = 'andres.munoz@mantenix.com')
  WHERE id_orden = @id_orden;
INSERT INTO historial_estado_orden (id_orden, id_estado, id_usuario, fecha_cambio)
VALUES (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'),
  (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-06-10 08:30:00');

UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'En proceso')
  WHERE id_orden = @id_orden;
INSERT INTO historial_estado_orden (id_orden, id_estado, id_usuario, fecha_cambio)
VALUES (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'En proceso'),
  (SELECT id_usuario FROM usuario WHERE correo = 'andres.munoz@mantenix.com'), '2026-06-10 09:00:00');

UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Finalizada'),
  fecha_finalizacion = '2026-06-10 10:10:00'
  WHERE id_orden = @id_orden;
INSERT INTO historial_estado_orden (id_orden, id_estado, id_usuario, fecha_cambio)
VALUES (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Finalizada'),
  (SELECT id_usuario FROM usuario WHERE correo = 'andres.munoz@mantenix.com'), '2026-06-10 10:10:00');

UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Entregada'),
  fecha_entrega = '2026-06-10 17:30:00'
  WHERE id_orden = @id_orden;
INSERT INTO historial_estado_orden (id_orden, id_estado, id_usuario, fecha_cambio)
VALUES (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Entregada'),
  (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-06-10 17:30:00');

-- ---- OT-2026-0002: Sandero — aceite — Entregada ----
INSERT INTO orden_trabajo (numero_orden, id_vehiculo, id_recepcionista, id_estado, fecha_ingreso, kilometraje_ingreso)
VALUES ('OT-2026-0002',
  (SELECT id_vehiculo FROM vehiculo WHERE placa = 'MCR456'),
  (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'),
  (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'),
  '2026-06-15 09:00:00', 17900);
SET @id_orden := (SELECT id_orden FROM orden_trabajo WHERE numero_orden = 'OT-2026-0002');

INSERT INTO orden_servicio (id_orden, id_servicio, precio_aplicado)
SELECT @id_orden, id_servicio, precio_base FROM servicio WHERE nombre = 'Cambio de aceite y filtro';

SET @rep1_id := (SELECT id_repuesto FROM repuesto WHERE codigo_referencia = 'FLT-ACE-001');
SET @rep1_precio := (SELECT precio_unitario FROM repuesto WHERE codigo_referencia = 'FLT-ACE-001');
SET @rep2_id := (SELECT id_repuesto FROM repuesto WHERE codigo_referencia = 'ACE-15W40-001');
SET @rep2_precio := (SELECT precio_unitario FROM repuesto WHERE codigo_referencia = 'ACE-15W40-001');
INSERT INTO orden_repuesto (id_orden, id_repuesto, cantidad, precio_unitario_aplicado) VALUES
  (@id_orden, @rep1_id, 1, @rep1_precio),
  (@id_orden, @rep2_id, 4, @rep2_precio);

UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'),
  id_tecnico = (SELECT id_usuario FROM usuario WHERE correo = 'kevin.bermudez@mantenix.com') WHERE id_orden = @id_orden;
UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'En proceso') WHERE id_orden = @id_orden;
UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Finalizada'),
  fecha_finalizacion = '2026-06-15 10:00:00' WHERE id_orden = @id_orden;
UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Entregada'),
  fecha_entrega = '2026-06-15 12:00:00' WHERE id_orden = @id_orden;

INSERT INTO historial_estado_orden (id_orden, id_estado, id_usuario, fecha_cambio) VALUES
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'), (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-06-15 09:00:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'), (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-06-15 09:10:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'En proceso'), (SELECT id_usuario FROM usuario WHERE correo = 'kevin.bermudez@mantenix.com'), '2026-06-15 09:20:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Finalizada'), (SELECT id_usuario FROM usuario WHERE correo = 'kevin.bermudez@mantenix.com'), '2026-06-15 10:00:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Entregada'), (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-06-15 12:00:00');

-- ---- OT-2026-0003: Camión NPR (flota) — frenos + liquido — Entregada ----
INSERT INTO orden_trabajo (numero_orden, id_vehiculo, id_recepcionista, id_estado, fecha_ingreso, kilometraje_ingreso)
VALUES ('OT-2026-0003',
  (SELECT id_vehiculo FROM vehiculo WHERE placa = 'TED001'),
  (SELECT id_usuario FROM usuario WHERE correo = 'sebastian.quintero@mantenix.com'),
  (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'),
  '2026-07-02 07:30:00', 95200);
SET @id_orden := (SELECT id_orden FROM orden_trabajo WHERE numero_orden = 'OT-2026-0003');

INSERT INTO orden_servicio (id_orden, id_servicio, precio_aplicado)
SELECT @id_orden, id_servicio, precio_base FROM servicio WHERE nombre IN ('Cambio de pastillas de freno', 'Cambio de líquido de frenos');

SET @rep1_id := (SELECT id_repuesto FROM repuesto WHERE codigo_referencia = 'PAST-FRE-DEL');
SET @rep1_precio := (SELECT precio_unitario FROM repuesto WHERE codigo_referencia = 'PAST-FRE-DEL');
SET @rep2_id := (SELECT id_repuesto FROM repuesto WHERE codigo_referencia = 'LIQ-FRE-001');
SET @rep2_precio := (SELECT precio_unitario FROM repuesto WHERE codigo_referencia = 'LIQ-FRE-001');
INSERT INTO orden_repuesto (id_orden, id_repuesto, cantidad, precio_unitario_aplicado) VALUES
  (@id_orden, @rep1_id, 1, @rep1_precio),
  (@id_orden, @rep2_id, 2, @rep2_precio);

UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'),
  id_tecnico = (SELECT id_usuario FROM usuario WHERE correo = 'fabian.pineda@mantenix.com') WHERE id_orden = @id_orden;
UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'En proceso') WHERE id_orden = @id_orden;
UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Finalizada'),
  fecha_finalizacion = '2026-07-02 11:00:00' WHERE id_orden = @id_orden;
UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Entregada'),
  fecha_entrega = '2026-07-02 15:00:00' WHERE id_orden = @id_orden;

INSERT INTO historial_estado_orden (id_orden, id_estado, id_usuario, fecha_cambio) VALUES
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'), (SELECT id_usuario FROM usuario WHERE correo = 'sebastian.quintero@mantenix.com'), '2026-07-02 07:30:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'), (SELECT id_usuario FROM usuario WHERE correo = 'sebastian.quintero@mantenix.com'), '2026-07-02 07:40:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'En proceso'), (SELECT id_usuario FROM usuario WHERE correo = 'fabian.pineda@mantenix.com'), '2026-07-02 08:00:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Finalizada'), (SELECT id_usuario FROM usuario WHERE correo = 'fabian.pineda@mantenix.com'), '2026-07-02 11:00:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Entregada'), (SELECT id_usuario FROM usuario WHERE correo = 'sebastian.quintero@mantenix.com'), '2026-07-02 15:00:00');

-- ---- OT-2026-0004: Moto Yamaha FZ — aceite + bujías — Entregada ----
INSERT INTO orden_trabajo (numero_orden, id_vehiculo, id_recepcionista, id_estado, fecha_ingreso, kilometraje_ingreso)
VALUES ('OT-2026-0004',
  (SELECT id_vehiculo FROM vehiculo WHERE placa = 'CER567'),
  (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'),
  (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'),
  '2026-07-20 14:00:00', 22100);
SET @id_orden := (SELECT id_orden FROM orden_trabajo WHERE numero_orden = 'OT-2026-0004');

INSERT INTO orden_servicio (id_orden, id_servicio, precio_aplicado)
SELECT @id_orden, id_servicio, precio_base FROM servicio WHERE nombre IN ('Cambio de aceite y filtro', 'Cambio de bujías');

SET @rep1_id := (SELECT id_repuesto FROM repuesto WHERE codigo_referencia = 'ACE-20W50-001');
SET @rep1_precio := (SELECT precio_unitario FROM repuesto WHERE codigo_referencia = 'ACE-20W50-001');
SET @rep2_id := (SELECT id_repuesto FROM repuesto WHERE codigo_referencia = 'FLT-ACE-MOTO');
SET @rep2_precio := (SELECT precio_unitario FROM repuesto WHERE codigo_referencia = 'FLT-ACE-MOTO');
SET @rep3_id := (SELECT id_repuesto FROM repuesto WHERE codigo_referencia = 'BUJ-IRID-001');
SET @rep3_precio := (SELECT precio_unitario FROM repuesto WHERE codigo_referencia = 'BUJ-IRID-001');
INSERT INTO orden_repuesto (id_orden, id_repuesto, cantidad, precio_unitario_aplicado) VALUES
  (@id_orden, @rep1_id, 1, @rep1_precio),
  (@id_orden, @rep2_id, 1, @rep2_precio),
  (@id_orden, @rep3_id, 1, @rep3_precio);

UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'),
  id_tecnico = (SELECT id_usuario FROM usuario WHERE correo = 'andres.munoz@mantenix.com') WHERE id_orden = @id_orden;
UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'En proceso') WHERE id_orden = @id_orden;
UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Finalizada'),
  fecha_finalizacion = '2026-07-20 15:30:00' WHERE id_orden = @id_orden;
UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Entregada'),
  fecha_entrega = '2026-07-20 16:00:00' WHERE id_orden = @id_orden;

INSERT INTO historial_estado_orden (id_orden, id_estado, id_usuario, fecha_cambio) VALUES
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'), (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-07-20 14:00:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'), (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-07-20 14:10:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'En proceso'), (SELECT id_usuario FROM usuario WHERE correo = 'andres.munoz@mantenix.com'), '2026-07-20 14:30:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Finalizada'), (SELECT id_usuario FROM usuario WHERE correo = 'andres.munoz@mantenix.com'), '2026-07-20 15:30:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Entregada'), (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-07-20 16:00:00');

-- ---- OT-2026-0005: Kia Picanto — alineación y balanceo — Finalizada (sin entregar) ----
INSERT INTO orden_trabajo (numero_orden, id_vehiculo, id_recepcionista, id_estado, fecha_ingreso, kilometraje_ingreso)
VALUES ('OT-2026-0005',
  (SELECT id_vehiculo FROM vehiculo WHERE placa = 'LFO234'),
  (SELECT id_usuario FROM usuario WHERE correo = 'sebastian.quintero@mantenix.com'),
  (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'),
  '2026-09-05 10:00:00', 14800);
SET @id_orden := (SELECT id_orden FROM orden_trabajo WHERE numero_orden = 'OT-2026-0005');

INSERT INTO orden_servicio (id_orden, id_servicio, precio_aplicado)
SELECT @id_orden, id_servicio, precio_base FROM servicio WHERE nombre = 'Alineación y balanceo';

UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'),
  id_tecnico = (SELECT id_usuario FROM usuario WHERE correo = 'kevin.bermudez@mantenix.com') WHERE id_orden = @id_orden;
UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'En proceso') WHERE id_orden = @id_orden;
UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Finalizada'),
  fecha_finalizacion = '2026-09-05 11:15:00' WHERE id_orden = @id_orden;

INSERT INTO historial_estado_orden (id_orden, id_estado, id_usuario, fecha_cambio) VALUES
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'), (SELECT id_usuario FROM usuario WHERE correo = 'sebastian.quintero@mantenix.com'), '2026-09-05 10:00:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'), (SELECT id_usuario FROM usuario WHERE correo = 'sebastian.quintero@mantenix.com'), '2026-09-05 10:10:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'En proceso'), (SELECT id_usuario FROM usuario WHERE correo = 'kevin.bermudez@mantenix.com'), '2026-09-05 10:20:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Finalizada'), (SELECT id_usuario FROM usuario WHERE correo = 'kevin.bermudez@mantenix.com'), '2026-09-05 11:15:00');

-- ---- OT-2026-0006: Corolla — correa de distribución — Finalizada (sin entregar) ----
INSERT INTO orden_trabajo (numero_orden, id_vehiculo, id_recepcionista, id_estado, fecha_ingreso, kilometraje_ingreso)
VALUES ('OT-2026-0006',
  (SELECT id_vehiculo FROM vehiculo WHERE placa = 'DPL890'),
  (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'),
  (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'),
  '2026-09-08 08:00:00', 87700);
SET @id_orden := (SELECT id_orden FROM orden_trabajo WHERE numero_orden = 'OT-2026-0006');

INSERT INTO orden_servicio (id_orden, id_servicio, precio_aplicado)
SELECT @id_orden, id_servicio, precio_base FROM servicio WHERE nombre = 'Revisión y cambio de correa de distribución';

SET @rep1_id := (SELECT id_repuesto FROM repuesto WHERE codigo_referencia = 'CORR-DIST-001');
SET @rep1_precio := (SELECT precio_unitario FROM repuesto WHERE codigo_referencia = 'CORR-DIST-001');
SET @rep2_id := (SELECT id_repuesto FROM repuesto WHERE codigo_referencia = 'CORR-ACC-001');
SET @rep2_precio := (SELECT precio_unitario FROM repuesto WHERE codigo_referencia = 'CORR-ACC-001');
INSERT INTO orden_repuesto (id_orden, id_repuesto, cantidad, precio_unitario_aplicado) VALUES
  (@id_orden, @rep1_id, 1, @rep1_precio),
  (@id_orden, @rep2_id, 1, @rep2_precio);

UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'),
  id_tecnico = (SELECT id_usuario FROM usuario WHERE correo = 'fabian.pineda@mantenix.com') WHERE id_orden = @id_orden;
UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'En proceso') WHERE id_orden = @id_orden;
UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Finalizada'),
  fecha_finalizacion = '2026-09-08 12:30:00' WHERE id_orden = @id_orden;

INSERT INTO historial_estado_orden (id_orden, id_estado, id_usuario, fecha_cambio) VALUES
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'), (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-09-08 08:00:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'), (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-09-08 08:15:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'En proceso'), (SELECT id_usuario FROM usuario WHERE correo = 'fabian.pineda@mantenix.com'), '2026-09-08 08:30:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Finalizada'), (SELECT id_usuario FROM usuario WHERE correo = 'fabian.pineda@mantenix.com'), '2026-09-08 12:30:00');

-- ---- OT-2026-0007: Camión NHR (flota) — pastillas traseras — En proceso ----
INSERT INTO orden_trabajo (numero_orden, id_vehiculo, id_recepcionista, id_estado, fecha_ingreso, kilometraje_ingreso)
VALUES ('OT-2026-0007',
  (SELECT id_vehiculo FROM vehiculo WHERE placa = 'DLS010'),
  (SELECT id_usuario FROM usuario WHERE correo = 'sebastian.quintero@mantenix.com'),
  (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'),
  '2026-09-10 07:45:00', 60700);
SET @id_orden := (SELECT id_orden FROM orden_trabajo WHERE numero_orden = 'OT-2026-0007');

INSERT INTO orden_servicio (id_orden, id_servicio, precio_aplicado)
SELECT @id_orden, id_servicio, precio_base FROM servicio WHERE nombre = 'Cambio de pastillas de freno';

SET @rep1_id := (SELECT id_repuesto FROM repuesto WHERE codigo_referencia = 'PAST-FRE-TRA');
SET @rep1_precio := (SELECT precio_unitario FROM repuesto WHERE codigo_referencia = 'PAST-FRE-TRA');
INSERT INTO orden_repuesto (id_orden, id_repuesto, cantidad, precio_unitario_aplicado) VALUES
  (@id_orden, @rep1_id, 1, @rep1_precio);

UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'),
  id_tecnico = (SELECT id_usuario FROM usuario WHERE correo = 'andres.munoz@mantenix.com') WHERE id_orden = @id_orden;
UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'En proceso') WHERE id_orden = @id_orden;

INSERT INTO historial_estado_orden (id_orden, id_estado, id_usuario, fecha_cambio) VALUES
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'), (SELECT id_usuario FROM usuario WHERE correo = 'sebastian.quintero@mantenix.com'), '2026-09-10 07:45:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'), (SELECT id_usuario FROM usuario WHERE correo = 'sebastian.quintero@mantenix.com'), '2026-09-10 07:55:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'En proceso'), (SELECT id_usuario FROM usuario WHERE correo = 'andres.munoz@mantenix.com'), '2026-09-10 08:15:00');

-- ---- OT-2026-0008: Moto AKT — aceite — En proceso ----
INSERT INTO orden_trabajo (numero_orden, id_vehiculo, id_recepcionista, id_estado, fecha_ingreso, kilometraje_ingreso)
VALUES ('OT-2026-0008',
  (SELECT id_vehiculo FROM vehiculo WHERE placa = 'JPH345'),
  (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'),
  (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'),
  '2026-09-12 09:30:00', 7950);
SET @id_orden := (SELECT id_orden FROM orden_trabajo WHERE numero_orden = 'OT-2026-0008');

INSERT INTO orden_servicio (id_orden, id_servicio, precio_aplicado)
SELECT @id_orden, id_servicio, precio_base FROM servicio WHERE nombre = 'Cambio de aceite y filtro';

SET @rep1_id := (SELECT id_repuesto FROM repuesto WHERE codigo_referencia = 'ACE-20W50-001');
SET @rep1_precio := (SELECT precio_unitario FROM repuesto WHERE codigo_referencia = 'ACE-20W50-001');
SET @rep2_id := (SELECT id_repuesto FROM repuesto WHERE codigo_referencia = 'FLT-ACE-MOTO');
SET @rep2_precio := (SELECT precio_unitario FROM repuesto WHERE codigo_referencia = 'FLT-ACE-MOTO');
INSERT INTO orden_repuesto (id_orden, id_repuesto, cantidad, precio_unitario_aplicado) VALUES
  (@id_orden, @rep1_id, 1, @rep1_precio),
  (@id_orden, @rep2_id, 1, @rep2_precio);

UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'),
  id_tecnico = (SELECT id_usuario FROM usuario WHERE correo = 'kevin.bermudez@mantenix.com') WHERE id_orden = @id_orden;
UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'En proceso') WHERE id_orden = @id_orden;

INSERT INTO historial_estado_orden (id_orden, id_estado, id_usuario, fecha_cambio) VALUES
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'), (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-09-12 09:30:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'), (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-09-12 09:40:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'En proceso'), (SELECT id_usuario FROM usuario WHERE correo = 'kevin.bermudez@mantenix.com'), '2026-09-12 09:50:00');

-- ---- OT-2026-0009: Camioneta NP300 (flota) — filtro de aire — Asignada ----
INSERT INTO orden_trabajo (numero_orden, id_vehiculo, id_recepcionista, id_estado, fecha_ingreso, kilometraje_ingreso)
VALUES ('OT-2026-0009',
  (SELECT id_vehiculo FROM vehiculo WHERE placa = 'TED002'),
  (SELECT id_usuario FROM usuario WHERE correo = 'sebastian.quintero@mantenix.com'),
  (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'),
  '2026-09-13 08:00:00', 54000);
SET @id_orden := (SELECT id_orden FROM orden_trabajo WHERE numero_orden = 'OT-2026-0009');

INSERT INTO orden_servicio (id_orden, id_servicio, precio_aplicado)
SELECT @id_orden, id_servicio, precio_base FROM servicio WHERE nombre = 'Cambio de filtro de aire';

UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'),
  id_tecnico = (SELECT id_usuario FROM usuario WHERE correo = 'fabian.pineda@mantenix.com') WHERE id_orden = @id_orden;

INSERT INTO historial_estado_orden (id_orden, id_estado, id_usuario, fecha_cambio) VALUES
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'), (SELECT id_usuario FROM usuario WHERE correo = 'sebastian.quintero@mantenix.com'), '2026-09-13 08:00:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'), (SELECT id_usuario FROM usuario WHERE correo = 'sebastian.quintero@mantenix.com'), '2026-09-13 08:20:00');

-- ---- OT-2026-0010: Tucson — alineación y balanceo — Asignada ----
INSERT INTO orden_trabajo (numero_orden, id_vehiculo, id_recepcionista, id_estado, fecha_ingreso, kilometraje_ingreso)
VALUES ('OT-2026-0010',
  (SELECT id_vehiculo FROM vehiculo WHERE placa = 'SMZ679'),
  (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'),
  (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'),
  '2026-09-13 11:00:00', 46700);
SET @id_orden := (SELECT id_orden FROM orden_trabajo WHERE numero_orden = 'OT-2026-0010');

INSERT INTO orden_servicio (id_orden, id_servicio, precio_aplicado)
SELECT @id_orden, id_servicio, precio_base FROM servicio WHERE nombre = 'Alineación y balanceo';

UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'),
  id_tecnico = (SELECT id_usuario FROM usuario WHERE correo = 'andres.munoz@mantenix.com') WHERE id_orden = @id_orden;

INSERT INTO historial_estado_orden (id_orden, id_estado, id_usuario, fecha_cambio) VALUES
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'), (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-09-13 11:00:00'),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Asignada'), (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-09-13 11:15:00');

-- ---- OT-2026-0011: Mazda 3 — cambio de batería — Pendiente (sin tecnico) ----
INSERT INTO orden_trabajo (numero_orden, id_vehiculo, id_recepcionista, id_estado, fecha_ingreso, kilometraje_ingreso)
VALUES ('OT-2026-0011',
  (SELECT id_vehiculo FROM vehiculo WHERE placa = 'JIS789'),
  (SELECT id_usuario FROM usuario WHERE correo = 'sebastian.quintero@mantenix.com'),
  (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'),
  '2026-09-14 10:30:00', 76000);
SET @id_orden := (SELECT id_orden FROM orden_trabajo WHERE numero_orden = 'OT-2026-0011');

INSERT INTO orden_servicio (id_orden, id_servicio, precio_aplicado)
SELECT @id_orden, id_servicio, precio_base FROM servicio WHERE nombre = 'Cambio de batería';

INSERT INTO historial_estado_orden (id_orden, id_estado, id_usuario, fecha_cambio) VALUES
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'), (SELECT id_usuario FROM usuario WHERE correo = 'sebastian.quintero@mantenix.com'), '2026-09-14 10:30:00');

-- ---- OT-2026-0012: Ford Explorer — pastillas delanteras — Cancelada ----
INSERT INTO orden_trabajo (numero_orden, id_vehiculo, id_recepcionista, id_estado, fecha_ingreso, kilometraje_ingreso)
VALUES ('OT-2026-0012',
  (SELECT id_vehiculo FROM vehiculo WHERE placa = 'SMZ678'),
  (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'),
  (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'),
  '2026-09-01 09:00:00', 112000);
SET @id_orden := (SELECT id_orden FROM orden_trabajo WHERE numero_orden = 'OT-2026-0012');

INSERT INTO orden_servicio (id_orden, id_servicio, precio_aplicado)
SELECT @id_orden, id_servicio, precio_base FROM servicio WHERE nombre = 'Cambio de pastillas de freno';

UPDATE orden_trabajo SET id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Cancelada'),
  motivo_cancelacion = 'Cliente decidió realizar el mantenimiento en otro taller por disponibilidad de fecha.'
  WHERE id_orden = @id_orden;

INSERT INTO historial_estado_orden (id_orden, id_estado, id_usuario, fecha_cambio, motivo) VALUES
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Pendiente'), (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-09-01 09:00:00', NULL),
  (@id_orden, (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Cancelada'), (SELECT id_usuario FROM usuario WHERE correo = 'valentina.rojas@mantenix.com'), '2026-09-02 16:00:00', 'Cliente decidió realizar el mantenimiento en otro taller por disponibilidad de fecha.');
