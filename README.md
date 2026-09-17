# Mantenix

Sistema de gestión de mantenimiento preventivo de vehículos para talleres multi-cliente.

Proyecto formativo del programa **Análisis y Desarrollo de Software (ADSO)** — SENA, ficha 3239137.

## Autores

- Johann Tafur Farfán
- Carlos Mario Cardona Valderrama

## Alcance

Mantenix permite a un taller de mantenimiento gestionar sus clientes, los vehículos de cada cliente,
las órdenes de trabajo, los técnicos que las atienden, los repuestos utilizados y el historial de
mantenimientos preventivos (por kilometraje y por fecha).

## Estructura del repositorio

```
docs/
  historias-usuario/         Historias de usuario por épica (37 HU en 8 épicas)
  modelo-datos/               Modelo entidad-relación y diccionario de datos
  figma/                       Enlace, estado y especificación del diseño en Figma
  trazabilidad.md              HU ↔ tablas de BD ↔ pantalla de Figma
  evidencia-base-de-datos.md   Resultado real de ejecutar los scripts de BD
database/
  schema.sql                   Script DDL (MySQL 8.4): tablas, vista, triggers
  seed.sql                     Datos reales/realistas de carga inicial
  README.md                    Cómo levantar la base de datos localmente
```

## Base de datos

- Motor: MySQL 8.4
- Nombre de la base de datos: `mantenix_db`
- Ver [database/schema.sql](database/schema.sql) y [database/seed.sql](database/seed.sql)
- Ver el diccionario de datos en [docs/modelo-datos/](docs/modelo-datos/)

## Diseño

El diseño de interfaz se encuentra en Figma — ver [docs/figma/README.md](docs/figma/README.md) para el enlace.

## Trazabilidad

Ver [docs/trazabilidad.md](docs/trazabilidad.md) para la matriz que conecta cada historia de
usuario con las tablas de la base de datos y la pantalla de Figma correspondiente.

## Estado del proyecto

En construcción. Ver [docs/historias-usuario/](docs/historias-usuario/) para el alcance funcional detallado.
