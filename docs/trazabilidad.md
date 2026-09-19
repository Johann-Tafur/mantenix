# Matriz de trazabilidad — Mantenix

Conecta cada historia de usuario con las tablas/columnas de la base de datos que la implementan y
con la pantalla de Figma donde se ve reflejada. Sirve para verificar que documentación, base de
datos y diseño están alineados entre sí — y para ver de un vistazo qué falta por diseñar.

Pantallas (16): **01** Login · **02** Dashboard · **03** Clientes · **04** Ficha de vehículo ·
**05** Crear orden · **06** Detalle de orden · **07** Catálogo e inventario · **08** Listado de órdenes ·
**09** Reportes · **10** Usuarios · **11** Portal del cliente · **12** Ficha de cliente ·
**13** Modal nuevo cliente · **14** Modal registrar vehículo · **15** Mi perfil · **16** Recuperar contraseña.
Las pantallas 01 a 03 existen en Figma; las 02 a 16 también como mockups SVG con datos reales de
`seed.sql` en [figma/mockups/](figma/mockups/README.md) (ver [figma/README.md](figma/README.md)).

## Épica 1 — Autenticación y usuarios

| HU | Tablas / columnas de BD | Pantalla Figma |
|---|---|---|
| HU-001 Inicio de sesión | `usuario` (correo, contrasena_hash, estado) | 01 — Login ✅ |
| HU-002 Cierre de sesión | `usuario` | Presente en el topbar de toda pantalla interna ✅ |
| HU-003 Recuperación de contraseña | `usuario` | 16 — Recuperar contraseña (mockup SVG ✅) |
| HU-004 Crear usuarios internos | `usuario`, `rol` | 10 — Usuarios (mockup SVG ✅) |
| HU-005 Desactivar usuario interno | `usuario.estado` | 10 — Usuarios (mockup SVG ✅) |
| HU-006 Gestión de mi perfil | `usuario` | 15 — Mi perfil (mockup SVG ✅) |

## Épica 2 — Clientes

| HU | Tablas / columnas de BD | Pantalla Figma |
|---|---|---|
| HU-007 Registrar cliente | `cliente` | 13 — Modal nuevo cliente (mockup SVG ✅) |
| HU-008 Buscar cliente | `cliente` | 03 — Clientes (Figma y mockup SVG ✅) |
| HU-009 Editar cliente | `cliente` | 12 — Ficha de cliente (mockup SVG ✅) |
| HU-010 Historial de un cliente | `cliente`, `vehiculo`, `orden_trabajo` | 12 — Ficha de cliente (mockup SVG ✅) |
| HU-011 Portal del cliente | `usuario`, `cliente` | 11 — Portal del cliente (mockup SVG ✅) |

## Épica 3 — Vehículos

| HU | Tablas / columnas de BD | Pantalla Figma |
|---|---|---|
| HU-012 Registrar vehículo | `vehiculo` | 14 — Modal registrar vehículo (mockup SVG ✅) |
| HU-013 Editar vehículo / kilometraje | `vehiculo.kilometraje_actual` | 04 — Vehículo, ficha técnica (mockup SVG ✅) |
| HU-014 Buscar vehículo por placa | `vehiculo.placa` | 04 — Vehículo, ficha técnica (mockup SVG ✅) |
| HU-015 Ficha técnica y bitácora | `vehiculo`, `orden_trabajo`, `proximo_mantenimiento` | 04 — Vehículo, ficha técnica (mockup SVG ✅) |

## Épica 4 — Catálogo de servicios

| HU | Tablas / columnas de BD | Pantalla Figma |
|---|---|---|
| HU-016 Crear tipo de servicio | `servicio` | 07 — Catálogo/Inventario, tab Servicios (mockup SVG ✅) |
| HU-017 Editar/desactivar servicio | `servicio.activo` | 07 — Catálogo/Inventario, tab Servicios (mockup SVG ✅) |
| HU-018 Consultar catálogo | `servicio` | 07 — Catálogo/Inventario, tab Servicios (mockup SVG ✅) |

## Épica 5 — Repuestos e inventario

| HU | Tablas / columnas de BD | Pantalla Figma |
|---|---|---|
| HU-019 Registrar repuesto | `repuesto` | 07 — Catálogo/Inventario, tab Repuestos (mockup SVG ✅) |
| HU-020 Consultar stock | `repuesto.stock_actual` | 07 — Catálogo/Inventario, tab Repuestos (mockup SVG ✅) |
| HU-021 Descontar repuestos usados | `orden_repuesto` + trigger `trg_orden_repuesto_after_insert/_delete` | 06 — Detalle de orden (mockup SVG ✅) |
| HU-022 Alerta de stock bajo | `repuesto.stock_minimo` | 07 — Catálogo/Inventario, tab Repuestos (mockup SVG ✅) |

## Épica 6 — Órdenes de trabajo

| HU | Tablas / columnas de BD | Pantalla Figma |
|---|---|---|
| HU-023 Crear orden de trabajo | `orden_trabajo`, `orden_servicio` | 05 — Crear orden de trabajo (mockup SVG ✅) |
| HU-024 Asignar técnico | `orden_trabajo.id_tecnico` | 06 — Detalle de orden (mockup SVG ✅) |
| HU-025 Actualizar estado | `estado_orden`, `historial_estado_orden` | 06 — Detalle de orden (mockup SVG ✅) |
| HU-026 Agregar servicios/repuestos | `orden_servicio`, `orden_repuesto` + `sp_recalcular_costo_orden` | 06 — Detalle de orden (mockup SVG ✅) |
| HU-027 Diagnóstico y observaciones | `orden_trabajo.observaciones` | 06 — Detalle de orden (mockup SVG ✅) |
| HU-028 Finalizar y entregar | `orden_trabajo`, trigger `trg_orden_trabajo_after_update` | 06 — Detalle de orden (mockup SVG ✅) |
| HU-029 Cancelar orden | `orden_trabajo.motivo_cancelacion` | 06 — Detalle de orden (mockup SVG ✅) |
| HU-030 Listado de órdenes por estado | `orden_trabajo`, `estado_orden` | 08 — Listado de órdenes (mockup SVG ✅) |

## Épica 7 — Historial y alertas preventivas

| HU | Tablas / columnas de BD | Pantalla Figma |
|---|---|---|
| HU-031 Historial de mantenimientos | `orden_trabajo`, `orden_servicio` | 04 — Vehículo, ficha técnica (mockup SVG ✅) |
| HU-032 Calcular próximo mantenimiento | `proximo_mantenimiento` + trigger `trg_orden_trabajo_after_update` | Automático — visible en 04 y en el portal del cliente |
| HU-033 Alertar al cliente | `vista_alertas_mantenimiento` | 11 — Portal del cliente (mockup SVG ✅) |
| HU-034 Panel de alertas del taller | `vista_alertas_mantenimiento` | 02 — Dashboard Administrador (mockup SVG ✅) |

## Épica 8 — Reportes

| HU | Tablas / columnas de BD | Pantalla Figma |
|---|---|---|
| HU-035 Panel general | Agregados de `orden_trabajo`, `repuesto` | 02 — Dashboard Administrador (Figma y mockup SVG ✅) |
| HU-036 Reporte de servicios más realizados | `orden_servicio` | 09 — Reportes (mockup SVG ✅) |
| HU-037 Reporte de desempeño por técnico | `orden_trabajo` | 09 — Reportes (mockup SVG ✅) |

## Resumen de cobertura

- **37/37** historias de usuario tienen su contraparte modelada en la base de datos.
- **37/37** historias de usuario tienen pantalla diseñada (Login, Dashboard y Clientes en Figma; el
  resto como mockups SVG). HU-002 (cerrar sesión) se cubre con el enlace del topbar/portal.
- Pendiente de fondo: llevar las pantallas 04 a 16 al archivo de Figma (importando los SVG) y corregir
  los componentes y datos de las pantallas 02 y 03 ya existentes allí.
