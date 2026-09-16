# Modelo entidad-relación — Mantenix

Motor: MySQL 8.4. Ver el script completo en [database/schema.sql](../../database/schema.sql).

```mermaid
erDiagram
    ROL {
        int id_rol PK
        varchar nombre_rol
    }
    USUARIO {
        int id_usuario PK
        int id_rol FK
        varchar nombre
        varchar correo UK
        varchar telefono
        varchar contrasena_hash
        enum estado
    }
    CLIENTE {
        int id_cliente PK
        int id_usuario FK "nullable, portal opcional"
        enum tipo_documento
        varchar numero_documento UK
        varchar nombre
        varchar telefono
        varchar correo
        varchar direccion
    }
    VEHICULO {
        int id_vehiculo PK
        int id_cliente FK
        varchar placa UK
        varchar marca
        varchar modelo
        smallint anio
        enum tipo_vehiculo
        int kilometraje_actual
    }
    SERVICIO {
        int id_servicio PK
        varchar nombre UK
        varchar descripcion
        decimal precio_base
        smallint duracion_estimada_min
        int intervalo_km "nullable"
        smallint intervalo_meses "nullable"
        tinyint activo
    }
    REPUESTO {
        int id_repuesto PK
        varchar codigo_referencia UK
        varchar nombre
        decimal precio_unitario
        int stock_actual
        int stock_minimo
    }
    ESTADO_ORDEN {
        int id_estado PK
        varchar nombre_estado UK
        tinyint orden_flujo
    }
    ORDEN_TRABAJO {
        int id_orden PK
        varchar numero_orden UK
        int id_vehiculo FK
        int id_tecnico FK "nullable"
        int id_recepcionista FK
        int id_estado FK
        datetime fecha_ingreso
        int kilometraje_ingreso
        decimal costo_total "calculado por trigger"
    }
    ORDEN_SERVICIO {
        int id_orden_servicio PK
        int id_orden FK
        int id_servicio FK
        decimal precio_aplicado
    }
    ORDEN_REPUESTO {
        int id_orden_repuesto PK
        int id_orden FK
        int id_repuesto FK
        int cantidad
        decimal precio_unitario_aplicado
    }
    HISTORIAL_ESTADO_ORDEN {
        int id_historial PK
        int id_orden FK
        int id_estado FK
        int id_usuario FK
        datetime fecha_cambio
        varchar motivo "nullable"
    }
    PROXIMO_MANTENIMIENTO {
        int id_vehiculo PK,FK
        int id_servicio PK,FK
        date fecha_sugerida "nullable"
        int kilometraje_sugerido "nullable"
        int id_orden_origen FK
    }

    ROL ||--o{ USUARIO : clasifica
    USUARIO |o--o| CLIENTE : "acceso portal (opcional)"
    CLIENTE ||--o{ VEHICULO : posee
    VEHICULO ||--o{ ORDEN_TRABAJO : genera
    USUARIO ||--o{ ORDEN_TRABAJO : "atiende (tecnico)"
    USUARIO ||--o{ ORDEN_TRABAJO : "crea (recepcionista)"
    ESTADO_ORDEN ||--o{ ORDEN_TRABAJO : define
    ORDEN_TRABAJO ||--o{ ORDEN_SERVICIO : incluye
    SERVICIO ||--o{ ORDEN_SERVICIO : "aplicado en"
    ORDEN_TRABAJO ||--o{ ORDEN_REPUESTO : incluye
    REPUESTO ||--o{ ORDEN_REPUESTO : "usado en"
    ORDEN_TRABAJO ||--o{ HISTORIAL_ESTADO_ORDEN : registra
    ESTADO_ORDEN ||--o{ HISTORIAL_ESTADO_ORDEN : marca
    USUARIO ||--o{ HISTORIAL_ESTADO_ORDEN : realiza
    VEHICULO ||--o{ PROXIMO_MANTENIMIENTO : tiene
    SERVICIO ||--o{ PROXIMO_MANTENIMIENTO : proyecta
    ORDEN_TRABAJO ||--o{ PROXIMO_MANTENIMIENTO : origina
```

## Decisiones de diseño relevantes

- **`usuario` centraliza el login** de los cuatro roles (Administrador, Recepcionista, Técnico, Cliente).
  `cliente` es la entidad de negocio (documento, dirección) y solo se conecta a `usuario` cuando ese
  cliente tiene acceso al portal (HU-011); la mayoría de clientes no lo necesitan, por eso el FK es
  nullable y único (relación 1:1 opcional).
- **`estado_orden` es un catálogo**, no un ENUM embebido, para poder auditar transiciones válidas
  (columna `orden_flujo`) sin alterar la estructura de `orden_trabajo`.
- **`orden_servicio` y `orden_repuesto`** son tablas de detalle (N:M resueltas) que fijan el precio
  aplicado al momento de la orden — el catálogo (`servicio`/`repuesto`) puede cambiar de precio después
  sin alterar órdenes históricas.
- **`costo_total` se mantiene con triggers**, no se calcula en cada consulta: se recalcula
  automáticamente al agregar/quitar un servicio o repuesto (ver `sp_recalcular_costo_orden` y los
  triggers `trg_orden_servicio_*` / `trg_orden_repuesto_*` en `schema.sql`).
- **`stock_actual` de `repuesto`** se descuenta/restituye automáticamente vía trigger cuando se
  agrega o quita un repuesto de una orden (HU-021, HU-029) — nunca se edita a mano desde la aplicación.
- **`proximo_mantenimiento`** guarda el resultado calculado (HU-032), no se recalcula en cada
  consulta; se recalcula solo cuando una orden pasa a estado "Entregada" (trigger
  `trg_orden_trabajo_after_update`). La vista `vista_alertas_mantenimiento` combina ese valor
  con la fecha/kilometraje actual para clasificar el estado en Al día / Próximo / Vencido (HU-033, HU-034).
- **`historial_estado_orden` la alimenta la aplicación**, no un trigger: cada cambio de estado lo hace
  un usuario identificado (HU-025), y ese `id_usuario` no está disponible de forma confiable dentro de
  un trigger de base de datos.
