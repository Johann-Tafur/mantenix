# Base de datos — Mantenix

Motor: **MySQL 8.4**. Base de datos: `mantenix_db`.

## Puesta en marcha local

```sql
-- 1. Crear un usuario de aplicación (ajusta la contraseña)
CREATE USER 'mantenix_app'@'localhost' IDENTIFIED BY 'tu_password_local';
GRANT ALL PRIVILEGES ON mantenix_db.* TO 'mantenix_app'@'localhost';
FLUSH PRIVILEGES;
```

```bash
# 2. Crear el esquema (tablas, vista, procedimiento y triggers)
mysql -u root -p < schema.sql

# 3. Cargar los datos de prueba (clientes, vehículos, órdenes, historial...)
mysql -u root -p < seed.sql
```

Las contraseñas de la base de datos **no se versionan** en este repositorio (ver `.gitignore`).
Cada integrante del equipo debe crear su propio usuario/contraseña local.

## Contenido

- [schema.sql](schema.sql) — DDL completo: tablas, claves foráneas, vista `vista_alertas_mantenimiento`,
  el procedimiento `sp_recalcular_costo_orden` y los triggers que mantienen `costo_total`, el stock de
  repuestos y el cálculo del próximo mantenimiento preventivo.
- [seed.sql](seed.sql) — Datos realistas de carga inicial: 9 usuarios, 10 clientes, 14 vehículos,
  9 servicios, 15 repuestos y 12 órdenes de trabajo en distintos estados (pendiente, asignada, en
  proceso, finalizada, entregada y cancelada), con su historial de estados.

## Usuarios de prueba (seed.sql)

Contraseña de prueba para todos: `Mantenix2026*`

| Correo | Rol |
|---|---|
| johanntafurfarfan@gmail.com | Administrador |
| carlos.cardona@mantenix.com | Administrador |
| valentina.rojas@mantenix.com | Recepcionista |
| sebastian.quintero@mantenix.com | Recepcionista |
| andres.munoz@mantenix.com | Técnico |
| kevin.bermudez@mantenix.com | Técnico |
| fabian.pineda@mantenix.com | Técnico |
| andres.gomez.cliente@gmail.com | Cliente (con acceso al portal) |
| camila.rodriguez.cliente@gmail.com | Cliente (con acceso al portal) |

## Ver también

- [Diccionario de datos](../docs/modelo-datos/diccionario-datos.md)
- [Modelo entidad-relación](../docs/modelo-datos/modelo-er.md)
- [Evidencia de ejecución](../docs/evidencia-base-de-datos.md) — resultado real de correr estos scripts
