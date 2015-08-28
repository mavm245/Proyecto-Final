## Proyecto-Final
### Nombre del proyecto.
Aplicacion Web para seguimiento de revisiones de seguridad.
### Objetivo del proyecto.
Contar con una herramienta que permita dar seguimiento en tiempo real de las revisiones de seguridad realizadas, contar con una base de conocimientos, obtener estadisticas sobre los problemas mas comunes en sitios web de la UNAM.

### FRONT END
- Drupal 7: Mostrat contenido desde el back end y presentarlo.
- Sencillo e intuitivo (visualmente minimalista).
- Responsivo (visible desde smartphones, tablets o cualquier equipo de computo).
- Usabilidad (a cuantos clicks), capacidades diferentes.
- Temas,vistas,css,js.
- 

### BACK END
- Gestor de conteidos Drupal 7.
  - Instalación mediante el uso de Drush.
  - Autenticacion de usuarios mediante LDAP.
  - Gestion de usuarios (altas, bajas) asisgnación de privilegios.
  - Gestion de información e interación con la bd.
  - Comunicación cifrada entre el Back End y la base de datos
  - Generacion automática de respaldos.

### Manedor de BD.
- Esquema de BD y diccionario de base de datos.
- Tablas adicionales (sql)

### MODULOS A IMPLEMENTAR
- Alta de una nueva revisió de seguridad (guardad información de la solicitud,estatus actualde la revisión).
- Ingreso de hallazgos nuevos y uso de recomendaciones previamente almacenadas (o almacenamiento de nuevas).
- Generación de estadísticas.
- Generación de documento final en Word y PDF.

** Facilidad para actualizaciones y mantenimiento.
** Requerida la documentacion de cada modulo.
** Seguridad (validaciones, permisos).
** Funcionalidad adecuada al planteamiento del proyecto.
** Configuraciones, adecuaciones y hardening realizado a los servicios empleados.

#### Todos los puntos deben estar en el repositorio git.

### Requerimientos
- S.O Debian 7.
- Drush.
- PHP5.
- Manejador de base de datos: Postgresql version 8.4 o Superior.

### Servidores Pruebas
- RevSeg
  - IP Address: 192.168.13.2
- RevSegDB
  - IP Address: 192.168.13.3
- Probable LDAP
  - IP Address: 192.168.13.4

### Servidores Produccion
- RevSeg
  - IP Address: 45.55.28.187
- RevSegDB
  - IP Address: 104.236.170.92
