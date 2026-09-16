# Épica 7 — Historial y alertas de mantenimiento preventivo

### HU-031 — Ver historial de mantenimientos de un vehículo

**Como** recepcionista, técnico o cliente
**Quiero** ver el historial completo de mantenimientos realizados a un vehículo
**Para** conocer qué se le ha hecho y cuándo corresponde el próximo servicio

**Criterios de aceptación:**
- El historial lista cada orden entregada con fecha, kilometraje, servicios realizados y técnico responsable.
- El historial se ordena del más reciente al más antiguo.
- El cliente solo puede ver el historial de sus propios vehículos.

Prioridad: Alta

---

### HU-032 — Calcular próximo mantenimiento preventivo

**Como** sistema
**Quiero** calcular automáticamente la fecha y/o kilometraje del próximo mantenimiento preventivo
**Para** poder generar alertas oportunas a clientes y al taller

**Criterios de aceptación:**
- El cálculo usa el intervalo definido en el servicio realizado (ej. cada 5.000 km o 6 meses, lo que ocurra primero).
- El cálculo se dispara automáticamente al entregar una orden de trabajo (ver HU-028).
- El resultado queda asociado al vehículo como su "próximo mantenimiento sugerido".

Prioridad: Alta

---

### HU-033 — Alertar al cliente de mantenimiento próximo o vencido

**Como** cliente
**Quiero** recibir una alerta cuando mi vehículo esté por cumplir o haya cumplido el kilometraje/fecha de su próximo mantenimiento
**Para** llevarlo al taller a tiempo y prevenir daños mayores

**Criterios de aceptación:**
- La alerta aparece en el portal del cliente cuando falten 15 días o 500 km para el próximo mantenimiento.
- La alerta cambia a estado "Vencido" si se supera la fecha/kilometraje sin haber agendado.
- El cliente puede ver qué servicio específico corresponde (ej. "Cambio de aceite").

Prioridad: Media

---

### HU-034 — Panel de alertas para el taller

**Como** recepcionista
**Quiero** ver el listado de todos los vehículos con mantenimiento próximo o vencido
**Para** contactar proactivamente a los clientes y agendar su visita

**Criterios de aceptación:**
- El listado es filtrable por estado de alerta (Próximo / Vencido).
- Cada fila muestra cliente, vehículo, servicio pendiente y días/km restantes o de exceso.
- Se puede iniciar la creación de una orden de trabajo directamente desde una alerta.

Prioridad: Media
