--Conectarse a la base de datos
\c revisiones_drupal

--Borrar informacion de la base de datos
delete from hall_rev;
delete from rev_herr;
delete from revision;
delete from url_web;
delete from puertos_web;
delete from solicitud_contacto;
delete from contacto;
delete from solicitud;
delete from sitio_web;
delete from manejador_db;
delete from servidor_web;

--Reiniciar los contadores para las secuencias de los inserts
ALTER SEQUENCE revision_id_revision_seq RESTART WITH 1;
ALTER SEQUENCE url_web_id_url_seq RESTART WITH 1;
ALTER SEQUENCE puertos_web_id_puerto_web_seq RESTART WITH 1;
ALTER SEQUENCE contacto_id_contacto_seq	 RESTART WITH 1;
ALTER SEQUENCE solicitud_id_solicitud_seq RESTART WITH 1;
ALTER SEQUENCE sitio_web_id_sitweb_seq RESTART WITH 1;
ALTER SEQUENCE manejador_db_id_rdbms_seq RESTART WITH 1;
ALTER SEQUENCE servidor_web_id_serweb_seq RESTART WITH 1;
