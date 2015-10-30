--Arteaga Lona Víctor Enrique
--Vasquez Martinez Mario Alejandro

--Script para la generacion de tablas a la base de datos revisiones_drupal.

--Cambio de base de datos:--

\c revisiones_drupal

--Creación de tablas:--


--tipo_organizacion
CREATE TABLE IF NOT EXISTS tipo_organizacion(
	id_tiporg serial primary key,
	tipo_nombre varchar(30) NOT NULL
);

--organizacion
CREATE TABLE IF NOT EXISTS organizacion(
	id_organizacion serial primary key,
	org_nombre varchar(80) NOT NULL,
	id_tiporg integer,
	FOREIGN KEY (id_tiporg) REFERENCES tipo_organizacion(id_tiporg)
);

--tipo_contacto
CREATE TABLE IF NOT EXISTS tipo_contacto(
	id_tipo_contacto serial primary key,
	tipo_contacto varchar(30) NOT NULL
);

--contacto
CREATE TABLE IF NOT EXISTS contacto(
	id_contacto serial primary key,
	cont_nombre varchar(60) NOT NULL,
	cont_correo varchar(60) NOT NULL,
	cont_tel varchar(20) NOT NULL,
	id_tipo_contacto integer,
	FOREIGN KEY (id_tipo_contacto) REFERENCES tipo_contacto(id_tipo_contacto)
);

--sistema_manejador
CREATE TABLE IF NOT EXISTS sistema_manejador(
	id_sistema serial primary key,
	nombre_rdbms varchar(50)
);

--manejador_db
CREATE TABLE IF NOT EXISTS manejador_db(
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
CREATE TABLE IF NOT EXISTS protos_acceso(
	id_proto serial primary key,
	protocolo varchar(50) NOT NULL
);

--servidor_so
CREATE TABLE IF NOT EXISTS servidor_so(
	id_so serial primary key,
	nombre_so varchar(30) NOT NULL
);

--soft_servidor
CREATE TABLE IF NOT EXISTS soft_servidor(
	id_soft serial primary key,
	software_nombre varchar(30) NOT NULL
);

--servidor_web
CREATE TABLE IF NOT EXISTS servidor_web(
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
CREATE TABLE IF NOT EXISTS sitio_web(
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
CREATE TABLE IF NOT EXISTS url_web(
	id_url serial primary key,
	url_link varchar(150) NOT NULL,
	id_sitweb integer,
	FOREIGN KEY (id_sitweb) REFERENCES sitio_web(id_sitweb)
);

--puertos_web
CREATE TABLE IF NOT EXISTS puertos_web(
	id_puerto_web serial primary key,
	puerto_web integer,
	id_sitweb integer,
	FOREIGN KEY (id_sitweb) REFERENCES sitio_web(id_sitweb),
	CHECK (puerto_web > 0 AND puerto_web < 65535)
);

--solicitud
CREATE TABLE IF NOT EXISTS solicitud(
	id_solicitud serial primary key,
	id_organizacion integer,
	fecha_sol date,
	fecha_disp date,
	fecha_ini date,
	fecha_fin date,
	id_sitweb integer,
	sitio_nombre varchar(50),
	FOREIGN KEY (id_organizacion) REFERENCES organizacion(id_organizacion),
	FOREIGN KEY (id_sitweb) REFERENCES sitio_web(id_sitweb),
	CHECK (fecha_sol <= fecha_disp AND fecha_sol <= fecha_ini AND fecha_sol < fecha_fin),
	CHECK (fecha_disp <= fecha_ini AND fecha_disp < fecha_fin),
	CHECK (fecha_ini < fecha_fin)
);

--solicitud_contacto
CREATE TABLE IF NOT EXISTS solicitud_contacto(
	id_solicitud integer,
	id_contacto integer,
	FOREIGN KEY (id_solicitud) REFERENCES solicitud(id_solicitud),
	FOREIGN KEY (id_contacto) REFERENCES contacto(id_contacto)
);

--revision
CREATE TABLE IF NOT EXISTS revision(
	id_revision serial primary key,
	id_solicitud integer,
	nid_auditor integer,
	estado_rev smallint DEFAULT 1,
	FOREIGN KEY (id_solicitud) REFERENCES solicitud(id_solicitud),
	FOREIGN KEY (nid_auditor) REFERENCES node(nid)
);

--hall_rev
CREATE TABLE IF NOT EXISTS hall_rev(
	id_revision serial,
	nid_hallazgo serial,
	payload varchar(255),
	FOREIGN KEY (id_revision) REFERENCES revision(id_revision),
	FOREIGN KEY (nid_hallazgo) REFERENCES node(nid)
);

--rev_herr
CREATE TABLE IF NOT EXISTS rev_herr(
	id_revision serial,
	nid_herramienta serial,
	FOREIGN KEY (id_revision) REFERENCES revision(id_revision),
	FOREIGN KEY (nid_herramienta) REFERENCES node(nid)
);

--Cambio de permisos

GRANT ALL ON tipo_organizacion, organizacion, tipo_contacto, contacto, sistema_manejador, manejador_db, protos_acceso, servidor_so, soft_servidor, servidor_web, solicitud, solicitud_contacto, revision, hall_rev, rev_herr TO adm_revbd;
