--Arteaga Lona Víctor Enrique
--Vasquez Martinez Mario Alejandro

--Script para la eliminacion de tablas a la base de datos revisiones_drupal.

--Cambio de base de datos:--

\c revisiones_drupal

--Creación de tablas:--


--tipo_organizacion
DROP TABLE tipo_organizacion;

--organizacion
DROP TABLE organizacion;

--tipo_contacto
DROP TABLE tipo_contacto;

--contacto
DROP TABLE contacto;

--sistema_manejador
DROP TABLE sistema_manejador;

--manejador_db
DROP TABLE manejador_db;

--protos_acceso
DROP TABLE protos_acceso;

--servidor_so
DROP TABLE servidor_so;

--soft_servidor
DROP TABLE soft_servidor;

--servidor_web
DROP TABLE servidor_web;

--sitio_web
DROP TABLE sitio_web;

--url_web
DROP TABLE url_web;

--puertos_web
DROP TABLE puertos_web;

--solicitud
DROP TABLE solicitud;

--solicitud_contacto
DROP TABLE solicitud_contacto;

--revision
DROP TABLE revision;
