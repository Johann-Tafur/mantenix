# Diseño en Figma — Mantenix

Archivo: **https://www.figma.com/design/e2hyTjY8Xm5ZQGS9WnZtMx** (equipo de Johann Tafur, plan Starter)

## Estado actual

| Elemento | Estado |
|---|---|
| Sistema de diseño base (colores, tipografía) | ✅ Hecho |
| Componentes: Button, Badge de estado, Input, NavItem | ✅ Hecho |
| 01 — Login | ✅ Hecho |
| 02 — Dashboard Administrador (HU-035) | ✅ Hecho |
| 03 — Clientes (HU-008) | ⚠️ Contenido creado, pendiente corregir: el campo de búsqueda quedó angosto (no hereda el ancho del contenedor) y el botón "Nuevo cliente" se corta en el borde derecho de la pantalla |
| 04 — Vehículo, ficha técnica | ⏳ Pendiente (especificado abajo) |
| 05 — Crear orden de trabajo | ⏳ Pendiente (especificado abajo) |
| 06 — Detalle de orden de trabajo | ⏳ Pendiente (especificado abajo) |
| 07 — Catálogo de servicios e inventario de repuestos | ⏳ Pendiente (especificado abajo) |

La generación se pausó por el límite de llamadas del plan **Starter** de Figma para el MCP
(`mcp_rate_limit_paywall`). Se retoma cuando el límite se restablece, o si se amplía el plan.
Este documento sirve de especificación para retomar sin perder contexto.

## Sistema de diseño (ya creado en el archivo)

**Colores** (colección de variables `Mantenix/Color`):

| Variable | Uso |
|---|---|
| `primary/900`, `primary/600`, `primary/50` | Marca, botones primarios, panel de login |
| `neutral/900` … `neutral/0` | Texto y superficies en escala de grises |
| `surface/bg` | Fondo general de las pantallas |
| `status/pendiente`, `status/asignada`, `status/enproceso`, `status/finalizada`, `status/entregada`, `status/cancelada` | Colores de estado de la orden de trabajo (mismo set que `estado_orden` en la base de datos) |

**Tipografía** (Inter): `Heading/H1`, `Heading/H2`, `Heading/H3`, `Body/Regular`, `Body/Medium`, `Caption`, `Label`.

**Componentes**:
- `Button` (variantes: Primary, Secondary, Ghost)
- `Badge` (variantes: una por cada estado de `estado_orden`)
- `Input` (label + campo)
- `NavItem` (variantes: Default, Active) — ítem de la barra lateral

**Navegación lateral (IA) común a todas las pantallas internas**: Dashboard · Órdenes de trabajo ·
Clientes · Vehículos · Catálogo y repuestos · Reportes.

## Corrección pendiente — pantalla Clientes

Causa raíz (confirmada leyendo la estructura del archivo): cada componente (`Button`, `Badge`,
`Input`, `NavItem`) se construyó como un `COMPONENT` de tamaño fijo que envuelve un frame
auto-layout. El componente exterior no se ajusta al contenido, así que:
- el botón "Nuevo cliente" mide 86px (el ancho de "Guardar") y su texto queda cortado;
- el `Field` del `Input` tiene ancho fijo de 260px y no se estira al redimensionar la instancia.

Arreglo (ya escrito, pendiente de ejecutar cuando Figma responda): en `Button`, `Badge` y `NavItem`
poner el componente exterior en auto-layout con tamaño `AUTO` (hug) en ambos ejes, sin relleno ni
fondo; en `Input`, componente en auto-layout vertical con ancho fijo 260 y el frame interior y el
`Field` con `layoutSizingHorizontal = 'FILL'`. Nota: el `Toolbar` de la pantalla Clientes mide
1116px correctamente; el corte del botón no venía del contenedor.

## Especificación de pantallas pendientes

### 04 — Vehículo, ficha técnica
HU: HU-013, HU-014, HU-015, HU-031, HU-033

- Cabecera: placa, marca/modelo/año, badge de tipo de vehículo, botón "Editar".
- Datos del cliente dueño (nombre, documento, teléfono) con enlace a su ficha.
- Tarjeta de kilometraje actual + fecha de la última actualización.
- Alerta de mantenimiento próximo/vencido si existe (usa `vista_alertas_mantenimiento`): servicio,
  fecha/km sugerido, badge de estado (Al día / Próximo / Vencido).
- Historial de mantenimientos: tabla con número de orden, fecha, servicios realizados, kilometraje,
  técnico, costo total — una fila por orden entregada (`orden_trabajo` + `orden_servicio`).
- Botón "Crear nueva orden" que enlaza a la pantalla 05 con el vehículo preseleccionado.

### 05 — Crear orden de trabajo
HU: HU-023, HU-024

- Formulario en dos columnas: izquierda datos de la orden, derecha resumen.
- Selector de vehículo (buscar por placa) — al elegir, autocompletar cliente y kilometraje actual.
- Campo de kilometraje de ingreso (prellenado, editable).
- Selector múltiple de servicios del catálogo (chips o checklist), mostrando precio de cada uno.
- Selector de técnico asignado (opcional al crear; puede quedar "Sin asignar").
- Resumen lateral: vehículo, cliente, servicios elegidos, costo estimado total.
- Botones: "Cancelar" (Secondary) y "Crear orden" (Primary).

### 06 — Detalle de orden de trabajo
HU: HU-025, HU-026, HU-027, HU-028, HU-029

- Cabecera: número de orden, badge de estado grande, vehículo y cliente, costo total.
- Línea de tiempo horizontal o vertical de estados (Pendiente → Asignada → En proceso → Finalizada →
  Entregada), cada paso con fecha/hora y usuario responsable (`historial_estado_orden`); si está
  Cancelada, mostrar el motivo.
- Sección "Servicios" — tabla de `orden_servicio` (nombre, precio aplicado) con botón "+ Agregar servicio".
- Sección "Repuestos" — tabla de `orden_repuesto` (nombre, cantidad, precio unitario, subtotal) con
  botón "+ Agregar repuesto"; mostrar advertencia si algún repuesto quedó bajo el stock mínimo.
- Campo de observaciones/diagnóstico técnico (texto libre).
- Barra de acciones inferior: botones de transición de estado según el estado actual (ej. "Asignar
  técnico", "Iniciar trabajo", "Marcar como finalizada", "Entregar al cliente", "Cancelar orden").

### 07 — Catálogo de servicios e inventario de repuestos
HU: HU-016, HU-017, HU-018, HU-019, HU-020, HU-021, HU-022

Pantalla con dos pestañas (tabs):

**Tab "Servicios"**: tabla con nombre, descripción, precio base, duración estimada, intervalo
(km / meses), estado (Activo/Inactivo), botón "+ Nuevo servicio" y acción editar por fila.

**Tab "Repuestos"**: tabla con código de referencia, nombre, precio unitario, stock actual, stock
mínimo — resaltar en rojo/badge "Bajo stock" las filas donde `stock_actual < stock_minimo`
(HU-022), botón "+ Nuevo repuesto".

## Ver también

- [Historias de usuario](../historias-usuario/README.md)
- [Modelo de datos](../modelo-datos/modelo-er.md)
