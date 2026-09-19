# Matriz de trazabilidad — Mantenix

Conecta cada historia de usuario con las tablas/columnas de la base de datos que la implementan y
con la pantalla de Figma donde se ve reflejada. Sirve para verificar que documentación, base de
datos y diseño están alineados entre sí — y para ver de un vistazo qué falta por diseñar.

Pantallas: **01** Login · **02** Dashboard Administrador · **03** Clientes · **04** Vehículo (ficha) ·
**05** Crear orden de trabajo · **06** Detalle de orden de trabajo · **07** Catálogo/Inventario.
"—" significa que la pantalla específica para esa HU todavía no está en el alcance diseñado
(ver [docs/figma/README.md](figma/README.md)).

## Épica 1 — Autenticación y usuarios

| HU | Tablas / columnas de BD | Pantalla Figma |
|---|---|---|
| HU-001 Inicio de sesión | `usuario` (correo, contrasena_hash, estado) | 01 — Login ✅ |
| HU-002 Cierre de sesión | `usuario` | Presente en el topbar de toda pantalla interna ✅ |
| HU-003 Recuperación de contraseña | `usuario` | — (flujo secundario de 01, pendiente) |
| HU-004 Crear usuarios internos | `usuario`, `rol` | — (pantalla "Administración de usuarios", pendiente) |
| HU-005 Desactivar usuario interno | `usuario.estado` | — (pendiente) |
| HU-006 Gestión de mi perfil | `usuario` | — (pendiente) |

## Épica 2 — Clientes

| HU | Tablas / columnas de BD | Pantalla Figma |
|---|---|---|
| HU-007 Registrar cliente | `cliente` | 03 — Clientes (formulario, pendiente de maquetar como modal) ⚠️ |
| HU-008 Buscar cliente | `cliente` | 03 — Clientes ✅ |
| HU-009 Editar cliente | `cliente` | 03 — Clientes (ficha detalle, pendiente) |
| HU-010 Historial de un cliente | `cliente`, `vehiculo`, `orden_trabajo` | — (ficha de cliente, pendiente) |
| HU-011 Portal del cliente | `usuario`, `cliente` | — (portal del cliente, fuera del primer lote) |

## Épica 3 — Vehículos

| HU | Tablas / columnas de BD | Pantalla Figma |
|---|---|---|
| HU-012 Registrar vehículo | `vehiculo` | — (formulario, pendiente de maquetar) |
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
| HU-030 Listado de órdenes por estado | `orden_trabajo`, `estado_orden` | — (listado "Órdenes de trabajo" dedicado, pendiente; resumen parcial visible en 02) |

## Épica 7 — Historial y alertas preventivas

| HU | Tablas / columnas de BD | Pantalla Figma |
|---|---|---|
| HU-031 Historial de mantenimientos | `orden_trabajo`, `orden_servicio` | 04 — Vehículo, ficha técnica (mockup SVG ✅) |
| HU-032 Calcular próximo mantenimiento | `proximo_mantenimiento` + trigger `trg_orden_trabajo_after_update` | Automático — visible en 04 y en el portal del cliente |
| HU-033 Alertar al cliente | `vista_alertas_mantenimiento` | — (portal del cliente, fuera del primer lote) |
| HU-034 Panel de alertas del taller | `vista_alertas_mantenimiento` | 02 — Dashboard Administrador ✅ (resumen) / pantalla dedicada pendiente |

## Épica 8 — Reportes

| HU | Tablas / columnas de BD | Pantalla Figma |
|---|---|---|
| HU-035 Panel general | Agregados de `orden_trabajo`, `repuesto` | 02 — Dashboard Administrador ✅ |
| HU-036 Reporte de servicios más realizados | `orden_servicio` | — (pantalla Reportes, pendiente) |
| HU-037 Reporte de desempeño por técnico | `orden_trabajo` | — (pantalla Reportes, pendiente) |

## Resumen de cobertura

- **37/37** historias de usuario tienen su contraparte modelada en la base de datos.
- **23/37** historias ya tienen pantalla diseñada: Login, Dashboard y Clientes en Figma, y las
  pantallas 02 a 07 como mockups SVG en [figma/mockups/](figma/mockups/README.md) con datos reales de
  `seed.sql`.
- Las 14 restantes (usuarios, perfil, formularios de alta, portal del cliente, listado de órdenes y
  reportes) quedan como siguiente lote de pantallas; ver [figma/README.md](figma/README.md).
