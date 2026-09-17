# Evidencia de ejecución — base de datos

Resultado real de ejecutar [database/schema.sql](../database/schema.sql) y
[database/seed.sql](../database/seed.sql) contra una instancia MySQL 8.4 local
(`mysql -u root -p < schema.sql`, luego `< seed.sql`, ambos con salida sin errores).

## Conteo de registros por tabla

```
tabla                   n
usuarios                9
clientes                10
vehiculos                14
servicios                9
repuestos                15
ordenes                  12
orden_servicio            15
orden_repuesto            14
historial                32
proximo_mantenimiento     7
```

## `costo_total` calculado automáticamente por los triggers

Cada valor lo calculó `sp_recalcular_costo_orden`, disparado por `trg_orden_servicio_*` y
`trg_orden_repuesto_*` al insertar cada línea de servicio/repuesto — no se escribió a mano.

```
numero_orden    id_estado   costo_total
OT-2026-0001    5 (Entregada)    433000.00
OT-2026-0002    5 (Entregada)    398000.00
OT-2026-0003    5 (Entregada)    361000.00
OT-2026-0004    5 (Entregada)    279000.00
OT-2026-0005    4 (Finalizada)    80000.00
OT-2026-0006    4 (Finalizada)   695000.00
OT-2026-0007    3 (En proceso)   235000.00
OT-2026-0008    3 (En proceso)   167000.00
OT-2026-0009    2 (Asignada)      45000.00
OT-2026-0010    2 (Asignada)      80000.00
OT-2026-0011    1 (Pendiente)    280000.00
OT-2026-0012    6 (Cancelada)    150000.00
```

## Stock de repuestos descontado automáticamente

`trg_orden_repuesto_after_insert` descontó el stock real al usar cada repuesto en una orden
(comparar contra los valores iniciales de `seed.sql`, ej. `FLT-ACE-001` partió en 40 y bajó a 38
tras usarse en las órdenes OT-2026-0001 y OT-2026-0002):

```
codigo_referencia   stock_actual  stock_minimo
FLT-ACE-001          38            10
ACE-15W40-001        52            15
FLT-AIR-001          30             8
PAST-FRE-DEL         19             5
PAST-FRE-TRA         19             5
LIQ-FRE-001          23             6
BAT-12V-001          10             3
BUJ-IRID-001         49            12
CORR-DIST-001         7             3
LLAN-185-65          16             4
FLT-COMB-001         22             6
AMORT-DEL-001        10             3
CORR-ACC-001         14             4
ACE-20W50-001        28             8
FLT-ACE-MOTO         23             8
```

## Kilometraje del vehículo actualizado al entregar la orden

`trg_orden_trabajo_after_update` actualizó `vehiculo.kilometraje_actual` al valor de
`kilometraje_ingreso` en cuanto la orden pasó a estado Entregada:

```
placa     kilometraje_actual
AFG123    41800
CER567    22100
MCR456    17900
TED001    95200
```

## `vista_alertas_mantenimiento` — próximo mantenimiento calculado

Generado por el mismo trigger a partir del `intervalo_km` / `intervalo_meses` de cada servicio
realizado (fecha de referencia: 15 sep 2026 — por eso las fechas sugeridas de 2027/2028 muestran
estado "Al día"):

```
placa     servicio                        fecha_sugerida  km_sugerido  estado
AFG123    Cambio de aceite y filtro       2027-03-15      46800        Al dia
AFG123    Rotación de llantas             2027-03-15      51800        Al dia
CER567    Cambio de aceite y filtro       2027-03-15      27100        Al dia
CER567    Cambio de bujías                2028-09-15      52100        Al dia
MCR456    Cambio de aceite y filtro       2027-03-15      22900        Al dia
TED001    Cambio de pastillas de freno    2027-09-15      115200       Al dia
TED001    Cambio de líquido de frenos     2028-09-15      115200       Al dia
```
