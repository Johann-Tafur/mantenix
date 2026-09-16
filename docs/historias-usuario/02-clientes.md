# Épica 2 — Gestión de clientes

### HU-007 — Registrar cliente nuevo

**Como** recepcionista
**Quiero** registrar los datos de un cliente nuevo
**Para** poder asociarle vehículos y órdenes de trabajo

**Criterios de aceptación:**
- El formulario exige nombre completo, tipo y número de documento, teléfono y correo.
- El número de documento debe ser único en el sistema.
- El correo es opcional, pero si se ingresa debe tener formato válido.
- Al guardar, el cliente queda disponible para asociarle vehículos.

Prioridad: Alta

---

### HU-008 — Buscar cliente existente

**Como** recepcionista
**Quiero** buscar un cliente por nombre, documento o teléfono
**Para** no duplicar registros y agilizar la atención

**Criterios de aceptación:**
- La búsqueda funciona con coincidencias parciales (ej. parte del nombre).
- Los resultados muestran nombre, documento, teléfono y cantidad de vehículos asociados.
- Si no hay resultados, se ofrece la opción de crear un cliente nuevo.

Prioridad: Alta

---

### HU-009 — Editar datos de un cliente

**Como** recepcionista
**Quiero** actualizar los datos de contacto de un cliente
**Para** mantener la información correcta para notificaciones y alertas

**Criterios de aceptación:**
- Se pueden editar teléfono, correo y dirección.
- El número de documento no se puede modificar una vez creado (evita romper la trazabilidad histórica).
- Los cambios quedan reflejados inmediatamente en el perfil del cliente.

Prioridad: Media

---

### HU-010 — Ver historial de un cliente

**Como** recepcionista o administrador
**Quiero** ver el historial completo de vehículos y órdenes de un cliente
**Para** dar contexto al atenderlo y detectar clientes frecuentes

**Criterios de aceptación:**
- La ficha del cliente lista todos sus vehículos registrados.
- Por cada vehículo se puede acceder a su historial de órdenes de trabajo.
- Se muestra la fecha de la última visita al taller.

Prioridad: Media

---

### HU-011 — Portal del cliente: ver mis datos y vehículos

**Como** cliente
**Quiero** iniciar sesión y ver mis vehículos registrados
**Para** consultar el estado de mi mantenimiento sin llamar al taller

**Criterios de aceptación:**
- El cliente solo ve sus propios vehículos y órdenes (no los de otros clientes).
- Se muestra el estado actual de cualquier orden de trabajo en curso.
- Se muestra el historial de mantenimientos completados por vehículo.

Prioridad: Media
