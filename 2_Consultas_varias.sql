SELECT * FROM empresas;
SELECT * FROM paises; 
SELECT * FROM puestos;
SELECT * FROM grupos_de_derivacion;
SELECT * FROM estados;
SELECT * FROM categorias;
SELECT * FROM severidades;
SELECT * FROM roles;
SELECT * FROM contactos;
SELECT * FROM telefonos;
SELECT * FROM llamados;
SELECT * FROM operadores;

SELECT now();

SELECT * FROM tickets;
SELECT * FROM empresas_x_paises;




/*
--- ID, nombre de empresa, telefono y nombre de pais ---

SELECT exp.ID, e.empresa, p.pais, t.telefono
FROM empresas_x_paises exp
INNER JOIN paises p ON p.ID = exp.id_pais
INNER JOIN empresas e ON e.ID = exp.id_empresa
INNER JOIN telefonos t ON t.id_telefono_empresa = exp.id_empresa;

--- Nombre, apellido, pais del contacto, la empresa, el telefono y el puesto ---

SELECT c.nombre, c.apellido, p.pais as Pais_de_contacto, e.empresa, pu.puesto, t.telefono
FROM contactos c
INNER JOIN paises p ON p.ID = c.id_pais_contacto 
INNER JOIN empresas e ON e.ID = c.id_empresa_contacto
INNER JOIN puestos pu ON pu.ID = c.id_puesto_contacto
INNER JOIN telefonos t ON t.id_telefono_contacto = c.ID;
/*


