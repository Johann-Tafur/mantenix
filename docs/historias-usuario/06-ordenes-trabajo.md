# Épica 6 — Órdenes de trabajo

### HU-023 — Crear orden de trabajo

**Como** recepcionista
**Quiero** crear una orden de trabajo para un vehículo
**Para** iniciar formalmente un mantenimiento y asignarlo a un técnico

**Criterios de aceptación:**
- La orden requiere un vehículo existente, al menos un servicio del catálogo y una fecha de ingreso.
- Al crearse, la orden queda en estado "Pendiente" y sin técnico asignado.
- Se registra automáticamente el kilometraje actual del vehículo al momento de crear la orden.
- Se genera un número de orden consecutivo único.

Prioridad: Alta

---

### HU-024 — Asignar técnico a una orden

**Como** administrador o recepcionista
**Quiero** asignar un técnico disponible a una orden de trabajo
**Para** que quede claro quién es responsable de ejecutarla

**Criterios de aceptación:**
- Solo se pueden asignar usuarios con rol Técnico y estado Activo.
- Al asignar el técnico, la orden pasa a estado "Asignada".
- El técnico asignado puede ver la orden en su lista de trabajo pendiente.

Prioridad: Alta

---

### HU-025 — Actualizar estado de una orden de trabajo

**Como** técnico
**Quiero** actualizar el estado de la orden a medida que avanzo
**Para** que el recepcionista y el cliente sepan en qué va su vehículo

**Criterios de aceptación:**
- Estados posibles: Pendiente → Asignada → En proceso → Finalizada → Entregada (y Cancelada en cualquier punto antes de Finalizada).
- No se puede saltar de "Asignada" a "Finalizada" sin pasar por "En proceso".
- Cada cambio de estado queda registrado con fecha, hora y usuario que lo realizó.

Prioridad: Alta

---

### HU-026 — Agregar servicios y repuestos a una orden

**Como** técnico
**Quiero** agregar a la orden los servicios realizados y los repuestos utilizados
**Para** que el costo total y el historial del vehículo queden completos

**Criterios de aceptación:**
- Se pueden agregar uno o más servicios del catálogo a la orden.
- Se pueden agregar uno o más repuestos con su cantidad usada.
- El sistema calcula el costo total sumando mano de obra (servicios) y repuestos.
- Solo se puede editar mientras la orden no esté en estado "Finalizada" o "Entregada".

Prioridad: Alta

---

### HU-027 — Registrar diagnóstico y observaciones técnicas

**Como** técnico
**Quiero** registrar observaciones y el diagnóstico encontrado en el vehículo
**Para** dejar constancia técnica del trabajo realizado y de hallazgos adicionales

**Criterios de aceptación:**
- El campo de observaciones acepta texto libre.
- Las observaciones quedan visibles en el historial del vehículo y en el reporte para el cliente.

Prioridad: Media

---

### HU-028 — Finalizar y entregar una orden de trabajo

**Como** recepcionista
**Quiero** marcar una orden como entregada al cliente
**Para** cerrar el ciclo del servicio y actualizar el historial de mantenimiento del vehículo

**Criterios de aceptación:**
- Solo se puede marcar como "Entregada" una orden en estado "Finalizada".
- Al entregarse, se actualiza el kilometraje del vehículo con el valor registrado en la orden.
- Se calcula automáticamente la fecha/kilometraje del próximo mantenimiento preventivo según el servicio realizado.

Prioridad: Alta

---

### HU-029 — Cancelar una orden de trabajo

**Como** recepcionista o administrador
**Quiero** cancelar una orden de trabajo que no se va a realizar
**Para** mantener el listado de órdenes activas limpio y preciso

**Criterios de aceptación:**
- Solo se pueden cancelar órdenes que no estén en estado "Finalizada" o "Entregada".
- Se debe registrar un motivo de cancelación.
- Si la orden tenía repuestos asignados, el stock se restituye automáticamente.

Prioridad: Media

---

### HU-030 — Ver listado de órdenes por estado

**Como** administrador
**Quiero** ver todas las órdenes de trabajo filtradas por estado
**Para** tener visibilidad del flujo de trabajo del taller en tiempo real

**Criterios de aceptación:**
- El listado se puede filtrar por estado, técnico asignado y rango de fechas.
- Cada fila muestra número de orden, cliente, vehículo, técnico y estado actual.
- Se puede acceder al detalle completo de cada orden desde el listado.

Prioridad: Media
