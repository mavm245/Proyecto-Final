--Arteaga Lona Víctor Enrique
--Vasquez Martinez Mario Alejandro

--Script para la generacion de tablas a la base de datos revisiones_drupal.

--Cambio de base de datos:--

\c revisiones_drupal

--Creación de tablas:--


--tipo_organizacion
CREATE TABLE tipo_organizacion(
	id_tiporg serial primary key,
	tipo_nombre varchar(30) NOT NULL
);

--organizacion
CREATE TABLE organizacion(
	id_organizacion serial primary key,
	org_nombre varchar(100) NOT NULL,
	id_tiporg integer,
	FOREIGN KEY (id_tiporg) REFERENCES tipo_organizacion(id_tiporg)
);

--tipo_contacto
CREATE TABLE tipo_contacto(
	id_tipo_contacto serial primary key,
	tipo_contacto varchar(30) NOT NULL
);

--contacto
CREATE TABLE contacto(
	id_contacto serial primary key,
	cont_nombre varchar(60) NOT NULL,
	cont_correo varchar(60) NOT NULL,
	cont_tel varchar(20) NOT NULL,
	id_tipo_contacto integer,
	FOREIGN KEY (id_tipo_contacto) REFERENCES tipo_contacto(id_tipo_contacto)
);

--sistema_manejador
CREATE TABLE sistema_manejador(
	id_sistema serial primary key,
	nombre_rdbms varchar(50)
);

--manejador_db
CREATE TABLE manejador_db(
	id_rdbms serial primary key,
	id_sistema integer,
	rdbms_ver varchar(30) NOT NULL,
	rdbms_ip varchar(30) NOT NULL,
	rdbms_puerto integer NOT NULL,
	rdbms_nom varchar(50) NOT NULL,
	FOREIGN KEY (id_sistema) REFERENCES sistema_manejador(id_sistema),
	CHECK (rdbms_puerto > 0 AND rdbms_puerto < 65535)
);

--protos_acceso
CREATE TABLE protos_acceso(
	id_proto serial primary key,
	protocolo varchar(50) NOT NULL
);

--servidor_so
CREATE TABLE servidor_so(
	id_so serial primary key,
	nombre_so varchar(30) NOT NULL
);

--soft_servidor
CREATE TABLE soft_servidor(
	id_soft serial primary key,
	software_nombre varchar(30) NOT NULL
);

--servidor_web
CREATE TABLE servidor_web(
	id_serweb serial primary key,
	id_so integer,
	serweb_ver varchar(100) NOT NULL,
	id_proto integer,
	acceso_puerto integer NOT NULL,
	ip_serweb varchar(20) NOT NULL,
	FOREIGN KEY (id_so) REFERENCES servidor_so(id_so),
	FOREIGN KEY (id_proto) REFERENCES protos_acceso(id_proto),
	CHECK (acceso_puerto > 0 AND acceso_puerto < 65535)
);

--sitio_web
CREATE TABLE sitio_web(
	id_sitweb serial primary key,
	id_soft integer,
	sitweb_vers varchar(30) NOT NULL,
	id_serweb integer,
	doc_root varchar(100) NOT NULL,
	id_rdbms integer,
	FOREIGN KEY (id_soft) REFERENCES soft_servidor(id_soft),
	FOREIGN KEY (id_serweb) REFERENCES servidor_web(id_serweb),
	FOREIGN KEY (id_rdbms) REFERENCES manejador_db(id_rdbms)
);

--url_web
CREATE TABLE url_web(
	id_url serial primary key,
	url_link varchar(150) NOT NULL,
	id_sitweb integer,
	FOREIGN KEY (id_sitweb) REFERENCES sitio_web(id_sitweb)
);

--puertos_web
CREATE TABLE puertos_web(
	id_puerto_web serial primary key,
	puerto_web integer,
	id_sitweb integer,
	FOREIGN KEY (id_sitweb) REFERENCES sitio_web(id_sitweb),
	CHECK (puerto_web > 0 AND puerto_web < 65535)
);

--solicitud
CREATE TABLE solicitud(
	id_solicitud serial primary key,
	id_organizacion integer,
	fecha_sol date,
	fecha_disp date,
	fecha_ini date,
	fecha_fin date,
	id_sitweb integer,
	num_rev smallint default 1,
	sitio_nombre varchar(100),
	FOREIGN KEY (id_organizacion) REFERENCES organizacion(id_organizacion),
	FOREIGN KEY (id_sitweb) REFERENCES sitio_web(id_sitweb),
	CHECK (fecha_sol <= fecha_disp AND fecha_sol <= fecha_ini AND fecha_sol < fecha_fin),
	CHECK (fecha_disp <= fecha_ini AND fecha_disp < fecha_fin),
	CHECK (fecha_ini < fecha_fin)
);

--solicitud_contacto
CREATE TABLE solicitud_contacto(
	id_solicitud integer,
	id_contacto integer,
	FOREIGN KEY (id_solicitud) REFERENCES solicitud(id_solicitud),
	FOREIGN KEY (id_contacto) REFERENCES contacto(id_contacto)
);

--revision
CREATE TABLE revision(
	id_revision serial primary key,
	id_solicitud integer,
	nid_auditor integer,
	estado_rev smallint DEFAULT 1,
	FOREIGN KEY (id_solicitud) REFERENCES solicitud(id_solicitud),
	FOREIGN KEY (nid_auditor) REFERENCES node(nid)
);

--hall_rev
CREATE TABLE hall_rev(
	id_revision serial,
	nid_hallazgo serial,
	FOREIGN KEY (id_revision) REFERENCES revision(id_revision),
	FOREIGN KEY (nid_hallazgo) REFERENCES node(nid)
);

--rev_herr
CREATE TABLE rev_herr(
	id_revision serial,
	nid_herramienta serial,
	FOREIGN KEY (id_revision) REFERENCES revision(id_revision),
	FOREIGN KEY (nid_herramienta) REFERENCES node(nid)
);

--Cambio de permisos

GRANT ALL ON tipo_organizacion, organizacion, tipo_contacto, contacto, sistema_manejador, manejador_db, protos_acceso, servidor_so, soft_servidor, servidor_web, solicitud, solicitud_contacto, revision, hall_rev, rev_herr TO adm_revdb;

--Cambio de permisos para versiones de postgres menores a 8.4

 GRANT USAGE, SELECT ON SEQUENCE organizacion_id_organizacion_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE contacto_id_contacto_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE hall_rev_id_revision_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE hall_rev_nid_hallazgo_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE protos_acceso_id_proto_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE puertos_web_id_puerto_web_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE rev_herr_id_revision_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE rev_herr_nid_herramienta_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE revision_id_revision_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE servidor_so_id_so_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE servidor_web_id_serweb_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE sistema_manejador_id_sistema_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE sitio_web_id_sitweb_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE soft_servidor_id_soft_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE solicitud_id_solicitud_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE tipo_contacto_id_tipo_contacto_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE tipo_organizacion_id_tiporg_seq TO adm_revdb;
 GRANT USAGE, SELECT ON SEQUENCE url_web_id_url_seq TO adm_revdb;          
 GRANT USAGE, SELECT ON SEQUENCE manejador_db_id_rdbms_seq TO adm_revdb;
