USE call_center_db;

-- Views

-- 1
CREATE OR REPLACE VIEW ListarTickets_vw AS(
SELECT ES.estado, SE.severidad, CA.categoria, GD.mesa, EM.empresa, C.nombre_completo AS Contacto, O.usuario as Operador, T.titulo, T.descripcion
FROM tickets T
INNER JOIN estados AS ES ON ES.ID = T.id_estado
INNER JOIN severidades AS SE ON SE.ID = T.id_severidad
INNER JOIN categorias AS CA ON CA.ID = T.id_categoria
INNER JOIN grupos_de_derivacion AS GD ON GD.ID = T.id_grupo_de_derivacion
INNER JOIN empresas AS EM ON EM.ID = T.id_empresa
INNER JOIN contactos AS C ON C.ID = T.id_contacto
INNER JOIN operadores as O ON O.ID = T.id_operador
);

-- 2
CREATE OR REPLACE VIEW list_contact_vw AS(
SELECT c.nombre_completo, p.pais as Pais_de_contacto, e.empresa, pu.puesto, t.telefono
FROM contactos c
INNER JOIN paises p ON p.ID = c.id_pais_contacto 
INNER JOIN empresas e ON e.ID = c.id_empresa_contacto
INNER JOIN puestos pu ON pu.ID = c.id_puesto_contacto
INNER JOIN telefonos t ON t.id_telefono_contacto = c.ID
);

-- 3
CREATE OR REPLACE VIEW list_empresas_vw AS(
SELECT e.empresa, p.pais, t.telefono, e.fecha_reg AS Alta_Empresa, ep.estado AS Activo
FROM empresas_x_paises AS ep
INNER JOIN paises p ON p.ID = ep.id_pais
INNER JOIN empresas e ON e.ID = ep.id_empresa
INNER JOIN telefonos t ON t.id_telefono_empresa = ep.id_empresa
);

-- 4
CREATE OR REPLACE VIEW list_operator_vw AS(
SELECT o.usuario, r.rol, o.fecha_reg AS Fecha_Alta, o.estado AS Activo
FROM operadores AS o
INNER JOIN roles AS r ON r.ID = o.id_rol_operador
);

-- 5
CREATE OR REPLACE VIEW tickets_successful AS (
SELECT t.id, em.empresa, t.titulo, e.estado, o.usuario AS Operador
FROM Tickets as t
INNER JOIN operadores AS o ON o.id = t.id_operador
INNER JOIN estados AS e ON e.id = t.id_estado
INNER JOIN empresas AS em ON em.id = t.id_empresa
WHERE t.id_estado = 3
);
