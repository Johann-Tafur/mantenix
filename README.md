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
  historias-usuario/   Historias de usuario por épica
  modelo-datos/         Modelo entidad-relación y diccionario de datos
  figma/                 Enlaces y exportes del diseño en Figma
database/
  schema.sql             Script DDL (MySQL 8.4)
  seed.sql                Datos reales/realistas de carga inicial
```

## Base de datos

- Motor: MySQL 8.4
- Nombre de la base de datos: `mantenix_db`
- Ver [database/schema.sql](database/schema.sql) y [database/seed.sql](database/seed.sql)
- Ver el diccionario de datos en [docs/modelo-datos/](docs/modelo-datos/)

## Diseño

El diseño de interfaz se encuentra en Figma — ver [docs/figma/README.md](docs/figma/README.md) para el enlace.

## Estado del proyecto

En construcción. Ver [docs/historias-usuario/](docs/historias-usuario/) para el alcance funcional detallado.
