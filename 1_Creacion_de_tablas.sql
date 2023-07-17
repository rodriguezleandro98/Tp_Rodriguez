CREATE DATABASE IF NOT EXISTS call_center_db;

/*LA TABLA ACTUAL PAISES TIENE QUE REEMPLAZARSE POR EMPRESAS_x_PAISES Y SE DEBE CREAR 
UNA TABLA FIJA DE PAISES PARA 
LOS CONTACTOS
EMPRESAS_X_PAISES ES MUCHOS A MUCHOS
VOY A TENER UNA FK DE PAISES Y UNA FK DE EMPRESAS.
-------- hecho --------
*/

USE call_center_db;

-- Creacion de tablas 

CREATE TABLE IF NOT EXISTS empresas (
	ID INT NOT NULL AUTO_INCREMENT,
    empresa VARCHAR(50) NOT NULL,
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID)
);

CREATE TABLE IF NOT EXISTS paises (
	ID INT NOT NULL AUTO_INCREMENT,
    pais VARCHAR(50) NOT NULL,
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID)
);

CREATE TABLE IF NOT EXISTS puestos (
	ID INT NOT NULL AUTO_INCREMENT,
    puesto VARCHAR(20) NOT NULL,
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID)
);

CREATE TABLE IF NOT EXISTS grupos_de_derivacion (
	ID INT NOT NULL AUTO_INCREMENT,
    mesa VARCHAR(30) NOT NULL,
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID)
);

CREATE TABLE IF NOT EXISTS estados (
	ID INT NOT NULL AUTO_INCREMENT,
    estado VARCHAR(20) NOT NULL,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID)
);

CREATE TABLE IF NOT EXISTS categorias (
	ID INT NOT NULL AUTO_INCREMENT,
    categoria VARCHAR(50) NOT NULL,
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID)
);


CREATE TABLE IF NOT EXISTS severidades (
	ID INT NOT NULL AUTO_INCREMENT,
    severidad VARCHAR(15) NOT NULL,
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID)
);

CREATE TABLE IF NOT EXISTS roles (
	ID INT NOT NULL AUTO_INCREMENT,
    rol VARCHAR(20) NOT NULL,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID)
);

-- RELACION MUCHOS A MUCHOS = "empresas_x_paises"
CREATE TABLE IF NOT EXISTS empresas_x_paises (
	ID INT NOT NULL AUTO_INCREMENT,
    id_empresa INT NOT NULL,
    id_pais INT NULL,
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID),
    FOREIGN KEY (id_pais) references paises(ID),
    FOREIGN KEY (id_empresa) references empresas(ID)
);

CREATE TABLE IF NOT EXISTS contactos (
	ID INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    DNI VARCHAR(15) NOT NULL,
    id_pais_contacto INT NOT NULL,
    id_empresa_contacto INT NOT NULL,
    id_puesto_contacto INT NOT NULL,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID),
    FOREIGN KEY (id_pais_contacto) references paises(ID),
    FOREIGN KEY (id_empresa_contacto) references empresas(ID),
    FOREIGN KEY (id_puesto_contacto) references puestos(ID)
);

CREATE TABLE IF NOT EXISTS telefonos (
	ID INT NOT NULL AUTO_INCREMENT,
    telefono VARCHAR(20) NOT NULL,
    id_telefono_contacto INT NULL,
    id_telefono_empresa INT NULL,
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID),
    FOREIGN KEY (id_telefono_contacto) references contactos(ID),
    FOREIGN KEY (id_telefono_empresa) references empresas(ID)
);

CREATE TABLE IF NOT EXISTS operadores (
	ID INT NOT NULL AUTO_INCREMENT,
    usuario VARCHAR(50) NOT NULL,
    clave VARCHAR(50) NOT NULL,
    id_rol_operador INT NOT NULL,
    estado TINYINT NOT NULL default 1,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID),
    UNIQUE KEY(usuario),
    FOREIGN KEY (id_rol_operador) references roles(ID)
);

CREATE TABLE IF NOT EXISTS llamados (
	ID INT NOT NULL AUTO_INCREMENT,
    id_operador INT NOT NULL,
    id_contacto INT NOT NULL,
    fecha DATETIME NOT NULL default NOW(),
    PRIMARY KEY(ID),
    UNIQUE KEY(ID),
    FOREIGN KEY (id_operador) references operadores(ID),
    FOREIGN KEY (id_contacto) references contactos(ID)
);

CREATE TABLE IF NOT EXISTS tickets (
	ID INT NOT NULL AUTO_INCREMENT,
    id_operador INT NOT NULL,
    id_contacto INT NOT NULL,
    id_empresa INT NOT NULL,
    id_severidad INT NOT NULL,
    id_categoria INT NOT NULL,
    id_estado INT NOT NULL,
    id_llamado INT NOT NULL,
    id_grupo_de_derivacion INT NOT NULL,
    titulo VARCHAR(30) NOT NULL,
    descripcion VARCHAR(300) NOT NULL,
    fecha_inicio DATETIME NOT NULL default NOW(),
    fecha_fin DATETIME NULL,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID),
    FOREIGN KEY (id_operador) references operadores(ID),
    FOREIGN KEY (id_contacto) references contactos(ID),
    FOREIGN KEY (id_empresa) references empresas(ID),
    FOREIGN KEY (id_empresa) references empresas(ID),
    FOREIGN KEY (id_severidad) references severidades(ID),
    FOREIGN KEY (id_categoria) references categorias(ID),
    FOREIGN KEY (id_estado) references estados(ID),
    FOREIGN KEY (id_llamado) references llamados(ID),
    FOREIGN KEY (id_grupo_de_derivacion) references grupos_de_derivacion(ID)
);

CREATE TABLE IF NOT EXISTS comentarios (
	ID INT NOT NULL AUTO_INCREMENT,
    id_operador INT NOT NULL,
    id_ticket INT NOT NULL,
    id_llamado INT NOT NULL,
    texto VARCHAR(200) NOT NULL,
    fecha DATETIME NOT NULL DEFAULT NOW(),
    solucion TINYINT NULL,
    PRIMARY KEY(ID),
    UNIQUE KEY(ID),
    FOREIGN KEY (id_operador) references operadores(ID),
    FOREIGN KEY (id_ticket) references tickets(ID),
    FOREIGN KEY (id_llamado) references llamados(ID)
);