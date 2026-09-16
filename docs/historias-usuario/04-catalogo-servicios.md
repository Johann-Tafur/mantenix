# Épica 4 — Catálogo de servicios de mantenimiento

### HU-016 — Crear tipo de servicio de mantenimiento

**Como** administrador
**Quiero** definir los tipos de servicio de mantenimiento preventivo que ofrece el taller
**Para** que se puedan seleccionar al crear una orden de trabajo

**Criterios de aceptación:**
- Cada servicio tiene nombre, descripción, precio base y duración estimada.
- Cada servicio define un intervalo recomendado (por kilometraje, por meses, o ambos) — ej. "Cambio de aceite: cada 5.000 km o 6 meses".
- El nombre del servicio debe ser único.

Prioridad: Alta

---

### HU-017 — Editar o desactivar un servicio del catálogo

**Como** administrador
**Quiero** editar el precio o desactivar un servicio que ya no se ofrece
**Para** mantener el catálogo actualizado sin borrar el historial de órdenes que ya lo usaron

**Criterios de aceptación:**
- Un servicio desactivado no aparece como opción al crear nuevas órdenes.
- Las órdenes históricas que usaron ese servicio no se ven afectadas.
- Se puede reactivar un servicio previamente desactivado.

Prioridad: Baja

---

### HU-018 — Consultar catálogo de servicios

**Como** recepcionista o técnico
**Quiero** ver el listado de servicios disponibles con su precio
**Para** informar al cliente y seleccionarlos al crear una orden de trabajo

**Criterios de aceptación:**
- El listado es filtrable por nombre.
- Se muestra precio y duración estimada de cada servicio.
- Solo se listan servicios activos.

Prioridad: Media
