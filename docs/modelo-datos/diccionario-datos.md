# Diccionario de datos — Mantenix

Base de datos: `mantenix_db` (MySQL 8.4, `utf8mb4_unicode_ci`). Script fuente: [database/schema.sql](../../database/schema.sql).

## rol

| Columna | Tipo | Nulo | Clave | Descripción |
|---|---|---|---|---|
| id_rol | TINYINT UNSIGNED | No | PK | Identificador del rol |
| nombre_rol | VARCHAR(20) | No | UK | Administrador, Recepcionista, Tecnico o Cliente |

## usuario

| Columna | Tipo | Nulo | Clave | Descripción |
|---|---|---|---|---|
| id_usuario | INT UNSIGNED | No | PK | Identificador del usuario |
| id_rol | TINYINT UNSIGNED | No | FK → rol | Rol del usuario |
| nombre | VARCHAR(100) | No | | Nombre completo |
| correo | VARCHAR(150) | No | UK | Correo, usado para iniciar sesión |
| telefono | VARCHAR(20) | Sí | | Teléfono de contacto |
| contrasena_hash | VARCHAR(255) | No | | Hash de la contraseña (nunca texto plano) |
| estado | ENUM('Activo','Inactivo') | No | | Habilita o revoca el acceso (HU-005) |
| fecha_creacion | DATETIME | No | | Fecha de alta del usuario |

## cliente

| Columna | Tipo | Nulo | Clave | Descripción |
|---|---|---|---|---|
| id_cliente | INT UNSIGNED | No | PK | Identificador del cliente |
| id_usuario | INT UNSIGNED | Sí | FK → usuario, UK | Cuenta de portal asociada (solo si el cliente tiene acceso, HU-011) |
| tipo_documento | ENUM('CC','CE','NIT','TI','PA') | No | | Tipo de documento de identidad/tributario |
| numero_documento | VARCHAR(20) | No | UK (con tipo_documento) | Número de documento |
| nombre | VARCHAR(100) | No | | Nombre o razón social |
| telefono | VARCHAR(20) | No | | Teléfono de contacto |
| correo | VARCHAR(150) | Sí | | Correo de contacto |
| direccion | VARCHAR(200) | Sí | | Dirección de residencia o de la empresa |
| fecha_registro | DATETIME | No | | Fecha de registro del cliente |

## vehiculo

| Columna | Tipo | Nulo | Clave | Descripción |
|---|---|---|---|---|
| id_vehiculo | INT UNSIGNED | No | PK | Identificador del vehículo |
| id_cliente | INT UNSIGNED | No | FK → cliente | Dueño actual del vehículo |
| placa | VARCHAR(10) | No | UK | Placa del vehículo |
| marca | VARCHAR(50) | No | | Marca |
| modelo | VARCHAR(50) | No | | Modelo/línea |
| anio | SMALLINT UNSIGNED | No | | Año del vehículo |
| tipo_vehiculo | ENUM('Automovil','Camioneta','Motocicleta','Camion','Otro') | No | | Clasificación del vehículo |
| kilometraje_actual | INT UNSIGNED | No | | Última lectura de kilometraje conocida; la actualiza el trigger al entregar una orden |
| fecha_registro | DATETIME | No | | Fecha de registro del vehículo |

## servicio

| Columna | Tipo | Nulo | Clave | Descripción |
|---|---|---|---|---|
| id_servicio | INT UNSIGNED | No | PK | Identificador del servicio |
| nombre | VARCHAR(100) | No | UK | Nombre del servicio de mantenimiento |
| descripcion | VARCHAR(255) | Sí | | Detalle del servicio |
| precio_base | DECIMAL(10,2) | No | | Precio de referencia (COP) |
| duracion_estimada_min | SMALLINT UNSIGNED | No | | Duración estimada en minutos |
| intervalo_km | INT UNSIGNED | Sí | | Cada cuántos km se recomienda repetirlo (al menos uno de los dos intervalos debe existir) |
| intervalo_meses | SMALLINT UNSIGNED | Sí | | Cada cuántos meses se recomienda repetirlo |
| activo | TINYINT(1) | No | | Si aparece disponible para nuevas órdenes (HU-017) |

## repuesto

| Columna | Tipo | Nulo | Clave | Descripción |
|---|---|---|---|---|
| id_repuesto | INT UNSIGNED | No | PK | Identificador del repuesto |
| codigo_referencia | VARCHAR(30) | No | UK | Código/referencia interna |
| nombre | VARCHAR(100) | No | | Nombre del repuesto |
| precio_unitario | DECIMAL(10,2) | No | | Precio unitario (COP) |
| stock_actual | INT UNSIGNED | No | | Unidades disponibles; el trigger lo descuenta/restituye automáticamente |
| stock_minimo | INT UNSIGNED | No | | Umbral para la alerta de reabastecimiento (HU-022) |

## estado_orden

| Columna | Tipo | Nulo | Clave | Descripción |
|---|---|---|---|---|
| id_estado | TINYINT UNSIGNED | No | PK | Identificador del estado |
| nombre_estado | VARCHAR(20) | No | UK | Pendiente, Asignada, En proceso, Finalizada, Entregada, Cancelada |
| orden_flujo | TINYINT UNSIGNED | No | | Orden lógico del flujo, para validar transiciones desde la aplicación |

## orden_trabajo

| Columna | Tipo | Nulo | Clave | Descripción |
|---|---|---|---|---|
| id_orden | INT UNSIGNED | No | PK | Identificador interno de la orden |
| numero_orden | VARCHAR(20) | No | UK | Consecutivo visible para el cliente (ej. OT-2026-0001) |
| id_vehiculo | INT UNSIGNED | No | FK → vehiculo | Vehículo atendido |
| id_tecnico | INT UNSIGNED | Sí | FK → usuario | Técnico asignado (nulo hasta HU-024) |
| id_recepcionista | INT UNSIGNED | No | FK → usuario | Quién creó la orden |
| id_estado | TINYINT UNSIGNED | No | FK → estado_orden | Estado actual |
| fecha_ingreso | DATETIME | No | | Fecha/hora en que el vehículo ingresó |
| kilometraje_ingreso | INT UNSIGNED | No | | Kilometraje registrado al crear la orden |
| observaciones | TEXT | Sí | | Diagnóstico y notas técnicas (HU-027) |
| motivo_cancelacion | VARCHAR(255) | Sí | | Motivo si la orden se cancela (HU-029) |
| fecha_finalizacion | DATETIME | Sí | | Cuándo pasó a Finalizada |
| fecha_entrega | DATETIME | Sí | | Cuándo pasó a Entregada |
| costo_total | DECIMAL(10,2) | No | | Suma de servicios + repuestos; mantenido por trigger |

## orden_servicio

| Columna | Tipo | Nulo | Clave | Descripción |
|---|---|---|---|---|
| id_orden_servicio | INT UNSIGNED | No | PK | Identificador de la línea |
| id_orden | INT UNSIGNED | No | FK → orden_trabajo | Orden a la que pertenece |
| id_servicio | INT UNSIGNED | No | FK → servicio | Servicio realizado |
| precio_aplicado | DECIMAL(10,2) | No | | Precio cobrado (copiado del catálogo al momento de agregarlo) |

Restricción: `UNIQUE (id_orden, id_servicio)` — un mismo servicio no se repite en una orden.

## orden_repuesto

| Columna | Tipo | Nulo | Clave | Descripción |
|---|---|---|---|---|
| id_orden_repuesto | INT UNSIGNED | No | PK | Identificador de la línea |
| id_orden | INT UNSIGNED | No | FK → orden_trabajo | Orden a la que pertenece |
| id_repuesto | INT UNSIGNED | No | FK → repuesto | Repuesto utilizado |
| cantidad | INT UNSIGNED | No | | Unidades usadas (> 0) |
| precio_unitario_aplicado | DECIMAL(10,2) | No | | Precio unitario cobrado (copiado del catálogo) |

Restricción: `UNIQUE (id_orden, id_repuesto)`. Al insertar/eliminar una fila, un trigger ajusta
`repuesto.stock_actual` y recalcula `orden_trabajo.costo_total`.

## historial_estado_orden

| Columna | Tipo | Nulo | Clave | Descripción |
|---|---|---|---|---|
| id_historial | INT UNSIGNED | No | PK | Identificador del registro |
| id_orden | INT UNSIGNED | No | FK → orden_trabajo | Orden afectada |
| id_estado | TINYINT UNSIGNED | No | FK → estado_orden | Estado al que cambió |
| id_usuario | INT UNSIGNED | No | FK → usuario | Quién hizo el cambio |
| fecha_cambio | DATETIME | No | | Cuándo se hizo el cambio |
| motivo | VARCHAR(255) | Sí | | Motivo (obligatorio en la práctica solo para cancelaciones) |

## proximo_mantenimiento

| Columna | Tipo | Nulo | Clave | Descripción |
|---|---|---|---|---|
| id_vehiculo | INT UNSIGNED | No | PK, FK → vehiculo | Vehículo |
| id_servicio | INT UNSIGNED | No | PK, FK → servicio | Servicio proyectado |
| fecha_sugerida | DATE | Sí | | Fecha sugerida del próximo mantenimiento (según intervalo_meses) |
| kilometraje_sugerido | INT UNSIGNED | Sí | | Kilometraje sugerido (según intervalo_km) |
| id_orden_origen | INT UNSIGNED | No | FK → orden_trabajo | Orden que generó este cálculo |
| fecha_calculo | DATETIME | No | | Cuándo se calculó/actualizó |

Clave primaria compuesta: un vehículo tiene a lo sumo una proyección vigente por tipo de servicio;
al entregarse una nueva orden con ese servicio, el trigger la reemplaza (`ON DUPLICATE KEY UPDATE`).

## Objetos derivados

| Objeto | Tipo | Propósito |
|---|---|---|
| `vista_alertas_mantenimiento` | VIEW | Combina `proximo_mantenimiento` con el kilometraje/fecha actuales y clasifica cada vehículo en Al día / Próximo / Vencido (HU-033, HU-034) |
| `sp_recalcular_costo_orden` | PROCEDURE | Recalcula `orden_trabajo.costo_total` sumando servicios y repuestos de la orden |
| `trg_orden_servicio_after_insert` / `_after_delete` | TRIGGER | Recalculan `costo_total` al agregar/quitar un servicio |
| `trg_orden_repuesto_after_insert` / `_after_delete` | TRIGGER | Ajustan `repuesto.stock_actual` y recalculan `costo_total` al agregar/quitar un repuesto |
| `trg_orden_trabajo_after_update` | TRIGGER | Al pasar una orden a "Entregada": actualiza `vehiculo.kilometraje_actual` y calcula `proximo_mantenimiento` para cada servicio de la orden |
