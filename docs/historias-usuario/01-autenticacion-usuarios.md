# Épica 1 — Autenticación y gestión de usuarios

### HU-001 — Inicio de sesión

**Como** usuario registrado (administrador, recepcionista, técnico o cliente)
**Quiero** iniciar sesión con mi correo y contraseña
**Para** acceder a las funciones que corresponden a mi rol

**Criterios de aceptación:**
- El sistema valida correo y contraseña contra los registrados en la base de datos.
- Si las credenciales son incorrectas, se muestra un mensaje de error sin indicar cuál de los dos campos falló.
- Al autenticarse, el sistema redirige a la pantalla principal según el rol del usuario.
- La contraseña se almacena cifrada (hash), nunca en texto plano.
- Tras 5 intentos fallidos consecutivos, la cuenta queda bloqueada temporalmente 15 minutos.

Prioridad: Alta

---

### HU-002 — Cierre de sesión

**Como** usuario autenticado
**Quiero** cerrar mi sesión
**Para** proteger mi cuenta cuando termino de usar el sistema

**Criterios de aceptación:**
- Un botón de "Cerrar sesión" visible en toda pantalla autenticada.
- Al cerrar sesión se invalida el token/sesión activa.
- El usuario es redirigido a la pantalla de inicio de sesión.

Prioridad: Alta

---

### HU-003 — Recuperación de contraseña

**Como** usuario registrado
**Quiero** recuperar el acceso a mi cuenta si olvido mi contraseña
**Para** no perder el acceso permanentemente

**Criterios de aceptación:**
- El usuario solicita recuperación indicando su correo.
- El sistema envía un enlace de restablecimiento con expiración de 30 minutos.
- El enlace permite definir una nueva contraseña que cumple la política mínima (8+ caracteres, letras y números).

Prioridad: Media

---

### HU-004 — Creación de usuarios internos (staff)

**Como** administrador
**Quiero** crear cuentas para recepcionistas y técnicos
**Para** que el personal del taller pueda operar el sistema con el rol adecuado

**Criterios de aceptación:**
- El formulario exige nombre, correo, teléfono y rol (Recepcionista o Técnico).
- El correo debe ser único en el sistema.
- Se genera una contraseña temporal que el usuario debe cambiar en su primer inicio de sesión.
- El nuevo usuario aparece en el listado de usuarios internos con estado "Activo".

Prioridad: Alta

---

### HU-005 — Desactivación de usuarios internos

**Como** administrador
**Quiero** desactivar la cuenta de un empleado que ya no trabaja en el taller
**Para** revocar su acceso al sistema sin perder el historial de órdenes que atendió

**Criterios de aceptación:**
- Un usuario desactivado no puede iniciar sesión.
- Las órdenes de trabajo históricas asociadas a ese usuario conservan su nombre como referencia.
- El administrador puede reactivar la cuenta más adelante.

Prioridad: Media

---

### HU-006 — Gestión de mi perfil

**Como** usuario autenticado
**Quiero** editar mis datos de contacto y cambiar mi contraseña
**Para** mantener mi información actualizada y mi cuenta segura

**Criterios de aceptación:**
- Puedo editar nombre, teléfono y correo (con reconfirmación si cambia el correo).
- Para cambiar la contraseña debo ingresar la contraseña actual.
- Los cambios se reflejan de inmediato en el sistema.

Prioridad: Baja
