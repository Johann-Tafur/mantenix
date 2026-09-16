# Épica 5 — Repuestos e inventario

### HU-019 — Registrar repuesto en el inventario

**Como** administrador
**Quiero** registrar los repuestos disponibles con su stock y precio
**Para** poder usarlos al atender órdenes de trabajo y controlar el inventario

**Criterios de aceptación:**
- El formulario exige nombre, código/referencia, precio unitario y cantidad en stock.
- El código de referencia debe ser único.
- Se define una cantidad mínima de stock para alertas de reabastecimiento.

Prioridad: Media

---

### HU-020 — Consultar stock disponible

**Como** técnico o recepcionista
**Quiero** consultar el stock disponible de un repuesto
**Para** saber si puedo usarlo en una orden de trabajo antes de comprometerlo con el cliente

**Criterios de aceptación:**
- La búsqueda es por nombre o código de referencia.
- Se muestra la cantidad disponible en tiempo real.
- Se resaltan los repuestos con stock por debajo del mínimo definido.

Prioridad: Media

---

### HU-021 — Descontar repuestos usados en una orden

**Como** técnico
**Quiero** que al registrar un repuesto usado en una orden se descuente automáticamente del inventario
**Para** mantener el stock siempre actualizado sin trabajo manual duplicado

**Criterios de aceptación:**
- Al agregar un repuesto a una orden de trabajo, el stock disponible se reduce en la cantidad usada.
- El sistema no permite usar más unidades de las que hay en stock.
- Si se elimina un repuesto de una orden aún no cerrada, el stock se restituye.

Prioridad: Alta

---

### HU-022 — Alerta de repuesto con stock bajo

**Como** administrador
**Quiero** ver una alerta cuando un repuesto llega a su cantidad mínima
**Para** reordenar compras a tiempo y no detener el trabajo del taller

**Criterios de aceptación:**
- El panel de administrador muestra un listado de repuestos bajo el mínimo.
- La alerta se actualiza automáticamente al bajar el stock por uso en órdenes.

Prioridad: Baja
