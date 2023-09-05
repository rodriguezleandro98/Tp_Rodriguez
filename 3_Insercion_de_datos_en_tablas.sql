USE call_center_db;

-- Inserts 

INSERT INTO empresas (empresa) VALUES ('Arcos Dorados');
INSERT INTO empresas (empresa) VALUES ('Siemmens');
INSERT INTO empresas (empresa) VALUES ('Cola Cola Company');
INSERT INTO empresas (empresa) VALUES ('Pepsi');
INSERT INTO empresas (empresa) VALUES ('Burgen King');
INSERT INTO empresas (empresa) VALUES ('Zhoe');
INSERT INTO empresas (empresa) VALUES ('Mimo');
INSERT INTO empresas (empresa) VALUES ('Dior');

INSERT INTO paises (pais) VALUES ( 'ARGENTINA' );
INSERT INTO paises (pais) VALUES ( 'CHILE' );
INSERT INTO paises (pais) VALUES ( 'URUGUAY' );
INSERT INTO paises (pais) VALUES ( 'BRASIL' );
INSERT INTO paises (pais) VALUES ( 'ECUADOR' );
INSERT INTO paises (pais) VALUES ( 'PERU' );
INSERT INTO paises (pais) VALUES ( 'BOLIVIA' );

INSERT INTO puestos (puesto) VALUES ( 'Presidente' );
INSERT INTO puestos (puesto) VALUES ( 'CEO' );
INSERT INTO puestos (puesto) VALUES ( 'Gerente' );
INSERT INTO puestos (puesto) VALUES ( 'Empleado' );

INSERT INTO grupos_de_derivacion (mesa) VALUES ( 'MDA' );
INSERT INTO grupos_de_derivacion (mesa) VALUES ( 'MDA N2' );
INSERT INTO grupos_de_derivacion (mesa) VALUES ( 'SLAD N2' );
INSERT INTO grupos_de_derivacion (mesa) VALUES ( 'SLAD N3' );
INSERT INTO grupos_de_derivacion (mesa) VALUES ( 'IT' );

INSERT INTO estados (estado) VALUES ( 'Abierto' );
INSERT INTO estados (estado) VALUES ( 'En analisis' );
INSERT INTO estados (estado) VALUES ( 'Solucionado' );
INSERT INTO estados (estado) VALUES ( 'Cerrado' );
INSERT INTO estados (estado) VALUES ( 'Rechazado' );

INSERT INTO categorias (categoria) VALUES ( 'Hardware' );
INSERT INTO categorias (categoria) VALUES ( 'Software' );
INSERT INTO categorias (categoria) VALUES ( 'Interno' );
INSERT INTO categorias (categoria) VALUES ( 'Externo' );
INSERT INTO categorias (categoria) VALUES ( 'RRHH' );
INSERT INTO categorias (categoria) VALUES ( 'IT' );

INSERT INTO severidades (severidad) VALUES ( 'Baja' );
INSERT INTO severidades (severidad) VALUES ( 'Media' );
INSERT INTO severidades (severidad) VALUES ( 'Alta' );
INSERT INTO severidades (severidad) VALUES ( 'Critica' );
INSERT INTO severidades (severidad) VALUES ( 'Urgente' );

INSERT INTO roles (rol) VALUES ( 'Administrador' );
INSERT INTO roles (rol) VALUES ( 'TeamLeader' );
INSERT INTO roles (rol) VALUES ( 'Operador' );

INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (1,1);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (1,2);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (2,1);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (2,3);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (3,3);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (4,4);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (4,1);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (5,2);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (6,5);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (7,2);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (8,6);
INSERT INTO empresas_x_paises (id_empresa,id_pais) VALUES (8,7);


INSERT INTO contactos (nombre_completo, DNI, id_pais_contacto, id_empresa_contacto, id_puesto_contacto) VALUES 
('Leandro Rodriguez', 41390062, 1, 1, 1 );
INSERT INTO contactos (nombre_completo, DNI, id_pais_contacto, id_empresa_contacto, id_puesto_contacto) VALUES 
('Ariel Rodriguez', 39009709, 1, 3, 2 );
INSERT INTO contactos (nombre_completo, DNI, id_pais_contacto, id_empresa_contacto, id_puesto_contacto) VALUES 
('Nancy Regner', 20875960, 3, 2, 3 );
INSERT INTO contactos (nombre_completo, DNI, id_pais_contacto, id_empresa_contacto, id_puesto_contacto) VALUES 
('Pepe Luis', 12345678, 5, 4, 3 );
INSERT INTO contactos (nombre_completo, DNI, id_pais_contacto, id_empresa_contacto, id_puesto_contacto) VALUES 
('Ruben Alcaraz', 98765432, 2, 2, 3 );
INSERT INTO contactos (nombre_completo, DNI, id_pais_contacto, id_empresa_contacto, id_puesto_contacto) VALUES 
('Javier Arbulu', 45645645, 4, 5, 3 );
INSERT INTO contactos (nombre_completo, DNI, id_pais_contacto, id_empresa_contacto, id_puesto_contacto) VALUES 
('Jose Rodriguez', 12378956, 6, 6, 1 );
INSERT INTO contactos (nombre_completo, DNI, id_pais_contacto, id_empresa_contacto, id_puesto_contacto) VALUES 
('Arnoldo Regner', 45896314, 7, 1, 1 );

INSERT INTO telefonos (telefono, id_telefono_contacto) VALUES ( 47954341, 1 );
INSERT INTO telefonos (telefono, id_telefono_contacto) VALUES ( 45612385, 2);
INSERT INTO telefonos (telefono, id_telefono_contacto) VALUES ( 55448899, 4 );
INSERT INTO telefonos (telefono, id_telefono_contacto) VALUES ( 1164707899, 1);
INSERT INTO telefonos (telefono, id_telefono_contacto) VALUES ( 45612315, 6);
INSERT INTO telefonos (telefono, id_telefono_contacto) VALUES ( 89413594, 5);
INSERT INTO telefonos (telefono, id_telefono_contacto) VALUES ( 78945164, 2);
INSERT INTO telefonos (telefono, id_telefono_empresa) VALUES ( 896532141, 1 );
INSERT INTO telefonos (telefono, id_telefono_empresa) VALUES ( 47354641, 2 );
INSERT INTO telefonos (telefono, id_telefono_empresa) VALUES ( 47354942, 3);
INSERT INTO telefonos (telefono, id_telefono_empresa) VALUES ( 47354643, 7 );
INSERT INTO telefonos (telefono, id_telefono_empresa) VALUES ( 47354344, 8 );
INSERT INTO telefonos (telefono, id_telefono_empresa) VALUES ( 47354945, 3 );
INSERT INTO telefonos (telefono, id_telefono_empresa) VALUES ( 47354946, 5 );

INSERT INTO operadores (usuario, clave, id_rol_operador) VALUES ( 'lrodriguez', 'password01', 1 );
INSERT INTO operadores (usuario, clave, id_rol_operador) VALUES ( 'nyamarte', 'Modelo.01', 2 );
INSERT INTO operadores (usuario, clave, id_rol_operador) VALUES ( 'jferrufino', 'Moldes3060', 2 );
INSERT INTO operadores (usuario, clave, id_rol_operador) VALUES ( 'jsordello', 'juanmecha', 3 );
INSERT INTO operadores (usuario, clave, id_rol_operador) VALUES ( 'camblorpepe', 'contraseña123', 3 );
/*
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 1, 1);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 1, 2);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 1, 3);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 2, 4);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 2, 1);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 3, 4);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 3, 2);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 5, 1);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 5, 3);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 4, 6);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 3, 5);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 2, 7);
INSERT INTO llamados (id_operador, id_contacto) VALUES ( 4, 7);
*/
-- 1
INSERT INTO tickets (id_operador
, id_contacto
, id_empresa
, id_severidad
, id_categoria
, id_estado
, id_grupo_de_derivacion
, titulo
, descripcion) 
VALUES ( 1, 1, 1, 1, 1, 1, 1, 'Prueba1', 'Descripcion prueba');

-- 2
INSERT INTO tickets (id_operador
, id_contacto
, id_empresa
, id_severidad
, id_categoria
, id_estado
, id_grupo_de_derivacion
, titulo
, descripcion) 
VALUES ( 1, 2, 3, 2, 3, 4, 2, 'Prueba2', 'Descripcion prueba2');

-- 3
INSERT INTO tickets (id_operador
, id_contacto
, id_empresa
, id_severidad
, id_categoria
, id_estado
, id_grupo_de_derivacion
, titulo
, descripcion) 
VALUES ( 1, 3, 2, 1, 1, 3, 3, 'Prueba lalalalal 3', 'Se comunica por falla de equipo, se logra resolver');

-- 4
INSERT INTO tickets (id_operador
, id_contacto
, id_empresa
, id_severidad
, id_categoria
, id_estado
, id_grupo_de_derivacion
, titulo
, descripcion) 
VALUES ( 2, 4, 4, 2, 5, 2, 4, 'CCC - Cambio en RRHH', 'Gerente pide cambiar cargo en sistema RRHH');

-- 5
INSERT INTO tickets (id_operador
, id_contacto
, id_empresa
, id_severidad
, id_categoria
, id_estado
, id_grupo_de_derivacion
, titulo
, descripcion) 
VALUES ( 3, 5, 2, 4, 5, 1, 5, 'Prueba5', 'Descripcion pruebaaaaaaa5');

-- 6
INSERT INTO tickets (id_operador
, id_contacto
, id_empresa
, id_severidad
, id_categoria
, id_estado
, id_grupo_de_derivacion
, titulo
, descripcion) 
VALUES ( 4, 6, 5, 1, 1, 1, 1, 'ya me canse', 'lo mismo que el titulo');

-- 7
INSERT INTO tickets (id_operador
, id_contacto
, id_empresa
, id_severidad
, id_categoria
, id_estado
, id_grupo_de_derivacion
, titulo
, descripcion) 
VALUES ( 2, 7, 6, 3, 3, 3, 2, 'otra vez?', 'si querido');

-- 8
INSERT INTO tickets (id_operador
, id_contacto
, id_empresa
, id_severidad
, id_categoria
, id_estado
, id_grupo_de_derivacion
, titulo
, descripcion) 
VALUES ( 4, 7, 6, 1, 1, 1, 3, 'bueno basta', 'ok te respeto');

-- 1
INSERT INTO comentarios (id_operador
, id_ticket
, texto
) 
VALUES ( 1, 1, 'Primer comentario');

-- 2
INSERT INTO comentarios (id_operador
, id_ticket
, texto
) 
VALUES ( 1, 2, 'Solamente comento' );

-- 3
INSERT INTO comentarios (id_operador
, id_ticket
, texto
, solucion
) 
VALUES ( 1, 3, 'Se logra solucionar', 1 );

-- 4
INSERT INTO comentarios (id_operador
, id_ticket
, texto
) 
VALUES ( 2, 4, 'Derivado');

-- 5
INSERT INTO comentarios (id_operador
, id_ticket
, texto
) 
VALUES ( 4, 6, 'Se realiza reclamo por caso abierto');

-- 6
INSERT INTO comentarios (id_operador
, id_ticket
, texto
) 
VALUES ( 4, 8, 'Reclamo, necesito celeridad');

-- 7
INSERT INTO comentarios (id_operador
, id_ticket
, texto
, solucion
) 
VALUES ( 2, 7, 'Comentario solucion', 1);