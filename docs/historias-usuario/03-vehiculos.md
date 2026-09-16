# Épica 3 — Gestión de vehículos

### HU-012 — Registrar vehículo de un cliente

**Como** recepcionista
**Quiero** registrar un vehículo asociado a un cliente
**Para** poder crear órdenes de trabajo y llevar su historial de mantenimiento

**Criterios de aceptación:**
- El formulario exige placa, marca, modelo, año, tipo de vehículo y kilometraje actual.
- La placa debe ser única en el sistema.
- El vehículo queda asociado obligatoriamente a un cliente ya registrado.
- Se puede registrar más de un vehículo por cliente.

Prioridad: Alta

---

### HU-013 — Editar datos de un vehículo

**Como** recepcionista
**Quiero** actualizar los datos de un vehículo, incluido su kilometraje
**Para** mantener la información precisa de cara a los mantenimientos preventivos

**Criterios de aceptación:**
- Se puede actualizar el kilometraje cada vez que el vehículo entra al taller.
- El nuevo kilometraje no puede ser menor al último registrado (validación de consistencia).
- Se puede reasignar el vehículo a otro cliente (ej. venta del vehículo).

Prioridad: Media

---

### HU-014 — Buscar vehículo por placa

**Como** recepcionista o técnico
**Quiero** buscar un vehículo por su placa
**Para** acceder rápido a su historial antes de crear una nueva orden

**Criterios de aceptación:**
- La búsqueda por placa exacta o parcial retorna el vehículo y su cliente dueño.
- Se muestra el kilometraje actual y la fecha del último mantenimiento.
- Se muestra si tiene una orden de trabajo abierta en este momento.

Prioridad: Alta

---

### HU-015 — Ver ficha técnica y bitácora del vehículo

**Como** técnico
**Quiero** ver la ficha completa del vehículo antes de trabajar en él
**Para** conocer su historial de mantenimientos y evitar repetir diagnósticos ya hechos

**Criterios de aceptación:**
- La ficha muestra marca, modelo, año, motor y kilometraje actual.
- Se lista cada mantenimiento anterior con fecha, tipo de servicio y kilometraje al momento.
- Se destacan alertas activas de mantenimiento preventivo pendiente.

Prioridad: Media
