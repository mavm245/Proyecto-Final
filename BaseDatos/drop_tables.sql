--Arteaga Lona Víctor Enrique
--Vasquez Martinez Mario Alejandro

--Script para la eliminacion de tablas a la base de datos revisiones_drupal.

--Cambio de base de datos:--

\c revisiones_drupal

--Eliminación de tablas:--

--rev_herr
DROP TABLE rev_herr;

--hall_rev
DROP TABLE hall_rev

--revision
DROP TABLE revision;

--solicitud_contacto
DROP TABLE solicitud_contacto;

--solicitud
DROP TABLE solicitud;

--puertos_web
DROP TABLE puertos_web;

--url_web
DROP TABLE url_web;

--sitio_web
DROP TABLE sitio_web;

--servidor_web
DROP TABLE servidor_web;

--soft_servidor
DROP TABLE soft_servidor;

--servidor_so
DROP TABLE servidor_so;

--protos_acceso
DROP TABLE protos_acceso;

--manejador_db
DROP TABLE manejador_db;

--sistema_manejador
DROP TABLE sistema_manejador;

--contacto
DROP TABLE contacto;

--tipo_contacto
DROP TABLE tipo_contacto;

--organizacion
DROP TABLE organizacion;

--tipo_organizacion
DROP TABLE tipo_organizacion;
