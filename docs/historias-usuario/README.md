# Historias de usuario — Mantenix

## Actores del sistema

| Rol | Descripción |
|---|---|
| **Administrador** | Dueño/gerente del taller. Gestiona usuarios, catálogo de servicios, repuestos y ve reportes generales. |
| **Recepcionista** | Asesor de servicio. Registra clientes, vehículos y crea/agenda órdenes de trabajo. |
| **Técnico** | Mecánico. Ejecuta las órdenes de trabajo asignadas, registra repuestos usados y avances. |
| **Cliente** | Dueño del vehículo. Consulta el estado de sus órdenes, historial de mantenimientos y recibe alertas preventivas. |

## Épicas

| # | Épica | Archivo |
|---|---|---|
| 1 | Autenticación y gestión de usuarios | [01-autenticacion-usuarios.md](01-autenticacion-usuarios.md) |
| 2 | Gestión de clientes | [02-clientes.md](02-clientes.md) |
| 3 | Gestión de vehículos | [03-vehiculos.md](03-vehiculos.md) |
| 4 | Catálogo de servicios de mantenimiento | [04-catalogo-servicios.md](04-catalogo-servicios.md) |
| 5 | Repuestos e inventario | [05-repuestos-inventario.md](05-repuestos-inventario.md) |
| 6 | Órdenes de trabajo | [06-ordenes-trabajo.md](06-ordenes-trabajo.md) |
| 7 | Historial y alertas de mantenimiento preventivo | [07-historial-alertas.md](07-historial-alertas.md) |
| 8 | Reportes y panel general | [08-reportes.md](08-reportes.md) |

## Convención

Cada historia tiene un ID único `HU-0XX` (correlativo global, no por épica), usado como referencia
cruzada desde el modelo de datos y los diseños de Figma.

Formato:

```
### HU-0XX — Título

**Como** <rol>
**Quiero** <acción>
**Para** <beneficio>

**Criterios de aceptación:**
- ...

Prioridad: Alta | Media | Baja
```

Prioridad asignada con criterio MoSCoW simplificado (Alta = Must have, Media = Should have, Baja = Could have).
