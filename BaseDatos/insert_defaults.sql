\c revisiones_drupal

INSERT INTO tipo_organizacion (tipo_nombre) VALUES 
	('Área de la DGTIC'),
	('Dependencia de la UNAM'),
	('Entidad externa');

INSERT INTO servidor_so (nombre_so) VALUES
	('GNU/Linux'),
	('Solaris'),
	('FreeBSD'),
	('OpenBSD'),
	('Windows');

INSERT INTO protos_acceso (protocolo) VALUES
	('SSH'),
	('VNC'),
	('NX'),
	('RDP');

INSERT INTO soft_servidor (software_nombre) VALUES
	('Apache httpd'),
	('Tomcat'),
	('Cherokee'),
	('nginx'),
	('IIS');

INSERT INTO sistema_manejador (nombre_rdbms) VALUES
	('MySQL'),
	('PostgreSQL'),
	('SQLite'),
	('Sybase'),
	('Oracle'),
	('DB2'),
	('MS SQL Server'),
	('MariaDB'),
	(MS Access);

INSERT INTO tipo_contacto (tipo_contacto) VALUES
	('Contacto Administrativo'),
	('Contacto Técnico');
