--Arteaga Lona Víctor Enrique
--Vasquez Martinez Mario Alejandro

--Script para la generacion de tablas a la base de datos revisiones_drupal.

--Cambio de base de datos:--

\c drupal_revisiones

--Creación de tablas:--


--tipo_organizacion
CREATE TABLE tipo_organizacion(
	id_tiporg serial primary key,
	tipo_nombre varchar(30) NOT NULL,
);

--organizacion
CREATE TABLE organizacion(
	id_organizacion serial primary key,
	org_nombre varchar(80),
	id_tiporg integer,
	FOREIGN KEY(id_tiporg) REFERENCES tipo_organizacion(ip_tiporg)
);

--tipo_contacto
CREATE TABLE tipo_contacto(
	id_tipo_contacto serial primary key,
	tipo_contacto varchar(30)
);

--contacto
CREATE TABLE contacto(
	id_contacto serial primary key,
	cont_nombre varchar(60),
	cont_correo varchar(30),
	cont_tel varchar(20),
	id_tipo_contacto integer,
	FOREIGN KEY(id_tipo_contacto) REFERENCES tipo_contacto(id_tipo_contacto)
);

--sistema_manejador
CREATE TABLE sistema_manejador(
	id_sistema serial primary key,
	nombre_rdbms varchar(50)
);

--manejador_db
CREATE TABLE manejador_db(
	id_rdbms serial primary key,
	id_rdbms integer,
	rdbms_ver varchar(30),
	rdbms_ip varchar(30),
	rdbms_puerto varchar(10),
	rdbms_nom varchar(50),
	FOREIGN KEY(id_sistema) REFERENCES sistema_manejador(id_sistema)
);

--protos_acceso
CREATE TABLE protos_acceso(
	id_proto serial primary key,
	protocolo varchar(50)
);

--servidor_so
CREATE TABLE servidor_so(
	id_so serial primary key,
	nombre_so varchar(30)
);

--soft_servidor
CREATE TABLE soft_servidor(
	id_soft serial primary key,
	software_nombre varchar(30)
);

--servidor_web
CREATE TABLE servidor_web(
	id_serweb serial primary key,
	id_so integer,
	serweb_ver varchar(100),
	id_proto integer,
	acceso_puerto varchar(5),
	ip_serweb varchar(20)
	FOREIGN KEY id_so REFERENCES servidor_so(id_so),
	FOREIGN KEY id_proto REFERENCES protos_acceso(id_proto)
);

--sitio_web
CREATE TABLE sitio_web(
	id_sitweb serial primary key,
	id_soft integer,
	sitweb_vers varchar(30),
	id_serweb integer,
	doc_root varchar(100),
	id_rdbms integer,
	FOREIGN KEY id_soft REFERENCES soft_servidor(id_soft),
	FOREIGN KEY id_serweb REFERENCES servidor_web(id_serweb),
	FOREIGN KEY id_rdbms REFERENCES manejador_db(id_rdbms)
);

--url_web
CREATE TABLE url_web(
	id_url serial primary key,
	url_link varchar(150),
	id_sitweb integer,
	FOREIGN KEY id_sitweb REFERENCES sitio_web(id_sitweb)
);

--puertos_web
CREATE TABLE puertos_web(
	id_puerto_web serial primary key,
	puerto_web varchar(10),
	id_sitweb integer,
	FOREIGN KEY id_serweb REFERENCES sitio_web(id_sitweb)
);

--solicitud
CREATE TABLE solicitud(
	id_solicitud serial primary key,
	id_organizacion integer,
	fecha_sol date,
	fecha_disp date,
	fecha_ini date,
	fecha_fin date,
	id_serweb integer,
	FOREIGN KEY id_organizacion REFERENCES organizacion(id_organizacion),
	FOREIGN KEY id_serweb REFERENCES servidor_web(id_serweb)
);

--solicitud_contacto
CREATE TABLE solicitud_contacto(
	id_solicitud integer,
	id_contacto integer,
	FOREIGN KEY id_solicitud REFERENCES solicitud(id_solicitud),
	FOREIGN KEY id_contacto REFERENCES contacto(id_contacto)
);

--revision
CREATE TABLE revision(
id_revision serial primary key,
id_solicitud integer,
id_auditor integer,
FOREIGN KEY(id_solicitud) REFERENCES distribuidores(id_solicitud),
FOREIGN KEY(id_auditor) REFERENCES empleados(id_auditor)
);