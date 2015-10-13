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
	cont_correo varchar(30) NOT NULL,
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
	rdbms_puerto varchar(10) NOT NULL,
	rdbms_nom varchar(50) NOT NULL,
	FOREIGN KEY (id_sistema) REFERENCES sistema_manejador(id_sistema)
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
	acceso_puerto varchar(5) NOT NULL,
	ip_serweb varchar(20) NOT NULL,
	FOREIGN KEY (id_so) REFERENCES servidor_so(id_so),
	FOREIGN KEY (id_proto) REFERENCES protos_acceso(id_proto)
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
	puerto_web varchar(10),
	id_sitweb integer,
	FOREIGN KEY (id_sitweb) REFERENCES sitio_web(id_sitweb)
);

--solicitud
CREATE TABLE IF NOT EXISTS solicitud(
	id_solicitud serial primary key,
	id_organizacion integer,
	fecha_sol date,
	fecha_disp date,
	fecha_ini date,
	fecha_fin date,
	id_serweb integer,
	FOREIGN KEY (id_organizacion) REFERENCES organizacion(id_organizacion),
	FOREIGN KEY (id_serweb) REFERENCES servidor_web(id_serweb)
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
--	id_auditor integer,
	entity_type varchar(128),
	entity_id bigint,
	deleted smallint,
	delta bigint,
	language varchar(32),
--	FOREIGN KEY
	FOREIGN KEY (id_solicitud) REFERENCES solicitud(id_solicitud),
	FOREIGN KEY(entity_type, entity_id, deleted, delta, language) REFERENCES field_data_field_id_auditor(entity_type, entity_id, deleted, delta, language)
);
