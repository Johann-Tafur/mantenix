-- ============================================================================
-- Mantenix — Esquema de base de datos (MySQL 8.4)
-- Sistema de gestion de mantenimiento preventivo de vehiculos
-- Proyecto SENA ADSO — ficha 3239137
-- ============================================================================

CREATE DATABASE IF NOT EXISTS mantenix_db
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE mantenix_db;

SET FOREIGN_KEY_CHECKS = 0;

DROP VIEW IF EXISTS vista_alertas_mantenimiento;
DROP PROCEDURE IF EXISTS sp_recalcular_costo_orden;
DROP TABLE IF EXISTS proximo_mantenimiento;
DROP TABLE IF EXISTS historial_estado_orden;
DROP TABLE IF EXISTS orden_repuesto;
DROP TABLE IF EXISTS orden_servicio;
DROP TABLE IF EXISTS orden_trabajo;
DROP TABLE IF EXISTS estado_orden;
DROP TABLE IF EXISTS repuesto;
DROP TABLE IF EXISTS servicio;
DROP TABLE IF EXISTS vehiculo;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS rol;

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------------------------------------
-- Catalogos
-- ----------------------------------------------------------------------------

CREATE TABLE rol (
  id_rol      TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre_rol  VARCHAR(20) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE estado_orden (
  id_estado      TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre_estado  VARCHAR(20) NOT NULL UNIQUE,
  orden_flujo    TINYINT UNSIGNED NOT NULL COMMENT 'Orden logico del flujo, para validar transiciones'
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- Usuarios y clientes
-- ----------------------------------------------------------------------------

CREATE TABLE usuario (
  id_usuario        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_rol            TINYINT UNSIGNED NOT NULL,
  nombre            VARCHAR(100) NOT NULL,
  correo            VARCHAR(150) NOT NULL UNIQUE,
  telefono          VARCHAR(20),
  contrasena_hash   VARCHAR(255) NOT NULL,
  estado            ENUM('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  fecha_creacion    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE cliente (
  id_cliente        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_usuario        INT UNSIGNED NULL UNIQUE COMMENT 'Solo si el cliente tiene acceso al portal',
  tipo_documento    ENUM('CC','CE','NIT','TI','PA') NOT NULL,
  numero_documento  VARCHAR(20) NOT NULL,
  nombre            VARCHAR(100) NOT NULL,
  telefono          VARCHAR(20) NOT NULL,
  correo            VARCHAR(150),
  direccion         VARCHAR(200),
  fecha_registro    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_cliente_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT uq_cliente_documento UNIQUE (tipo_documento, numero_documento)
) ENGINE=InnoDB;

CREATE TABLE vehiculo (
  id_vehiculo         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_cliente          INT UNSIGNED NOT NULL,
  placa               VARCHAR(10) NOT NULL UNIQUE,
  marca               VARCHAR(50) NOT NULL,
  modelo              VARCHAR(50) NOT NULL,
  anio                SMALLINT UNSIGNED NOT NULL,
  tipo_vehiculo        ENUM('Automovil','Camioneta','Motocicleta','Camion','Otro') NOT NULL,
  kilometraje_actual  INT UNSIGNED NOT NULL DEFAULT 0,
  fecha_registro      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_vehiculo_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- Catalogo de servicios y repuestos
-- ----------------------------------------------------------------------------

CREATE TABLE servicio (
  id_servicio             INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre                  VARCHAR(100) NOT NULL UNIQUE,
  descripcion             VARCHAR(255),
  precio_base             DECIMAL(10,2) NOT NULL,
  duracion_estimada_min   SMALLINT UNSIGNED NOT NULL,
  intervalo_km            INT UNSIGNED NULL,
  intervalo_meses         SMALLINT UNSIGNED NULL,
  activo                  TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT chk_servicio_intervalo CHECK (intervalo_km IS NOT NULL OR intervalo_meses IS NOT NULL)
) ENGINE=InnoDB;

CREATE TABLE repuesto (
  id_repuesto        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  codigo_referencia  VARCHAR(30) NOT NULL UNIQUE,
  nombre             VARCHAR(100) NOT NULL,
  precio_unitario    DECIMAL(10,2) NOT NULL,
  stock_actual       INT UNSIGNED NOT NULL DEFAULT 0,
  stock_minimo       INT UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- Ordenes de trabajo
-- ----------------------------------------------------------------------------

CREATE TABLE orden_trabajo (
  id_orden              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  numero_orden          VARCHAR(20) NOT NULL UNIQUE,
  id_vehiculo           INT UNSIGNED NOT NULL,
  id_tecnico            INT UNSIGNED NULL,
  id_recepcionista      INT UNSIGNED NOT NULL,
  id_estado             TINYINT UNSIGNED NOT NULL,
  fecha_ingreso         DATETIME NOT NULL,
  kilometraje_ingreso   INT UNSIGNED NOT NULL,
  observaciones         TEXT,
  motivo_cancelacion    VARCHAR(255),
  fecha_finalizacion    DATETIME NULL,
  fecha_entrega         DATETIME NULL,
  costo_total           DECIMAL(10,2) NOT NULL DEFAULT 0,
  CONSTRAINT fk_orden_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_orden_tecnico FOREIGN KEY (id_tecnico) REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_orden_recepcionista FOREIGN KEY (id_recepcionista) REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_orden_estado FOREIGN KEY (id_estado) REFERENCES estado_orden(id_estado)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  INDEX idx_orden_estado (id_estado),
  INDEX idx_orden_fecha_ingreso (fecha_ingreso)
) ENGINE=InnoDB;

CREATE TABLE orden_servicio (
  id_orden_servicio  INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_orden           INT UNSIGNED NOT NULL,
  id_servicio        INT UNSIGNED NOT NULL,
  precio_aplicado    DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_ordserv_orden FOREIGN KEY (id_orden) REFERENCES orden_trabajo(id_orden)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ordserv_servicio FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT uq_orden_servicio UNIQUE (id_orden, id_servicio)
) ENGINE=InnoDB;

CREATE TABLE orden_repuesto (
  id_orden_repuesto         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_orden                  INT UNSIGNED NOT NULL,
  id_repuesto                INT UNSIGNED NOT NULL,
  cantidad                  INT UNSIGNED NOT NULL,
  precio_unitario_aplicado  DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_ordrep_orden FOREIGN KEY (id_orden) REFERENCES orden_trabajo(id_orden)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ordrep_repuesto FOREIGN KEY (id_repuesto) REFERENCES repuesto(id_repuesto)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT uq_orden_repuesto UNIQUE (id_orden, id_repuesto),
  CONSTRAINT chk_ordrep_cantidad CHECK (cantidad > 0)
) ENGINE=InnoDB;

CREATE TABLE historial_estado_orden (
  id_historial   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_orden       INT UNSIGNED NOT NULL,
  id_estado      TINYINT UNSIGNED NOT NULL,
  id_usuario     INT UNSIGNED NOT NULL,
  fecha_cambio   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  motivo         VARCHAR(255),
  CONSTRAINT fk_hist_orden FOREIGN KEY (id_orden) REFERENCES orden_trabajo(id_orden)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_hist_estado FOREIGN KEY (id_estado) REFERENCES estado_orden(id_estado)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_hist_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- Mantenimiento preventivo (calculado)
-- ----------------------------------------------------------------------------

CREATE TABLE proximo_mantenimiento (
  id_vehiculo           INT UNSIGNED NOT NULL,
  id_servicio           INT UNSIGNED NOT NULL,
  fecha_sugerida        DATE NULL,
  kilometraje_sugerido  INT UNSIGNED NULL,
  id_orden_origen       INT UNSIGNED NOT NULL,
  fecha_calculo         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_vehiculo, id_servicio),
  CONSTRAINT fk_prox_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_prox_servicio FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_prox_orden FOREIGN KEY (id_orden_origen) REFERENCES orden_trabajo(id_orden)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ============================================================================
-- Vista: alertas de mantenimiento (HU-033 / HU-034)
-- ============================================================================

CREATE OR REPLACE VIEW vista_alertas_mantenimiento AS
SELECT
  pm.id_vehiculo,
  v.placa,
  v.kilometraje_actual,
  c.id_cliente,
  c.nombre AS nombre_cliente,
  pm.id_servicio,
  s.nombre AS nombre_servicio,
  pm.fecha_sugerida,
  pm.kilometraje_sugerido,
  DATEDIFF(pm.fecha_sugerida, CURDATE()) AS dias_restantes,
  (pm.kilometraje_sugerido - v.kilometraje_actual) AS km_restantes,
  CASE
    WHEN (pm.fecha_sugerida IS NOT NULL AND pm.fecha_sugerida < CURDATE())
      OR (pm.kilometraje_sugerido IS NOT NULL AND pm.kilometraje_sugerido < v.kilometraje_actual)
      THEN 'Vencido'
    WHEN (pm.fecha_sugerida IS NOT NULL AND DATEDIFF(pm.fecha_sugerida, CURDATE()) <= 15)
      OR (pm.kilometraje_sugerido IS NOT NULL AND (pm.kilometraje_sugerido - v.kilometraje_actual) <= 500)
      THEN 'Proximo'
    ELSE 'Al dia'
  END AS estado_alerta
FROM proximo_mantenimiento pm
JOIN vehiculo v ON v.id_vehiculo = pm.id_vehiculo
JOIN cliente c ON c.id_cliente = v.id_cliente
JOIN servicio s ON s.id_servicio = pm.id_servicio;

-- ============================================================================
-- Procedimiento: recalcular costo total de una orden (HU-026)
-- ============================================================================

DELIMITER $$

CREATE PROCEDURE sp_recalcular_costo_orden(IN p_id_orden INT UNSIGNED)
BEGIN
  UPDATE orden_trabajo o
  SET o.costo_total =
      COALESCE((SELECT SUM(precio_aplicado) FROM orden_servicio WHERE id_orden = p_id_orden), 0)
    + COALESCE((SELECT SUM(cantidad * precio_unitario_aplicado) FROM orden_repuesto WHERE id_orden = p_id_orden), 0)
  WHERE o.id_orden = p_id_orden;
END$$

DELIMITER ;

-- ============================================================================
-- Triggers
-- ============================================================================

DELIMITER $$

-- Recalcula costo_total al agregar/quitar un servicio de la orden
CREATE TRIGGER trg_orden_servicio_after_insert
AFTER INSERT ON orden_servicio
FOR EACH ROW
BEGIN
  CALL sp_recalcular_costo_orden(NEW.id_orden);
END$$

CREATE TRIGGER trg_orden_servicio_after_delete
AFTER DELETE ON orden_servicio
FOR EACH ROW
BEGIN
  CALL sp_recalcular_costo_orden(OLD.id_orden);
END$$

-- Descuenta stock y recalcula costo_total al agregar un repuesto a la orden (HU-021, HU-026)
CREATE TRIGGER trg_orden_repuesto_after_insert
AFTER INSERT ON orden_repuesto
FOR EACH ROW
BEGIN
  UPDATE repuesto
  SET stock_actual = stock_actual - NEW.cantidad
  WHERE id_repuesto = NEW.id_repuesto;

  CALL sp_recalcular_costo_orden(NEW.id_orden);
END$$

-- Restituye stock y recalcula costo_total al quitar un repuesto de la orden (HU-021, HU-029)
CREATE TRIGGER trg_orden_repuesto_after_delete
AFTER DELETE ON orden_repuesto
FOR EACH ROW
BEGIN
  UPDATE repuesto
  SET stock_actual = stock_actual + OLD.cantidad
  WHERE id_repuesto = OLD.id_repuesto;

  CALL sp_recalcular_costo_orden(OLD.id_orden);
END$$

-- Al entregar una orden: actualiza kilometraje del vehiculo y calcula el proximo
-- mantenimiento por cada servicio realizado (HU-028, HU-032)
CREATE TRIGGER trg_orden_trabajo_after_update
AFTER UPDATE ON orden_trabajo
FOR EACH ROW
BEGIN
  IF NEW.id_estado <> OLD.id_estado
     AND NEW.id_estado = (SELECT id_estado FROM estado_orden WHERE nombre_estado = 'Entregada')
  THEN
    UPDATE vehiculo
    SET kilometraje_actual = NEW.kilometraje_ingreso
    WHERE id_vehiculo = NEW.id_vehiculo
      AND kilometraje_actual < NEW.kilometraje_ingreso;

    INSERT INTO proximo_mantenimiento (id_vehiculo, id_servicio, fecha_sugerida, kilometraje_sugerido, id_orden_origen, fecha_calculo)
    SELECT
      NEW.id_vehiculo,
      os.id_servicio,
      CASE WHEN s.intervalo_meses IS NOT NULL THEN DATE_ADD(CURDATE(), INTERVAL s.intervalo_meses MONTH) ELSE NULL END,
      CASE WHEN s.intervalo_km IS NOT NULL THEN NEW.kilometraje_ingreso + s.intervalo_km ELSE NULL END,
      NEW.id_orden,
      NOW()
    FROM orden_servicio os
    JOIN servicio s ON s.id_servicio = os.id_servicio
    WHERE os.id_orden = NEW.id_orden
    ON DUPLICATE KEY UPDATE
      fecha_sugerida = VALUES(fecha_sugerida),
      kilometraje_sugerido = VALUES(kilometraje_sugerido),
      id_orden_origen = VALUES(id_orden_origen),
      fecha_calculo = VALUES(fecha_calculo);
  END IF;
END$$

DELIMITER ;
