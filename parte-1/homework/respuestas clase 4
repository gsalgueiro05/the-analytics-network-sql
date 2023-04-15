--Homework Clase 4--

--1
CREATE SCHEMA bkp;
SELECT *, current_date as backup_date
INTO bkp.product_master_20231304
FROM stg.product_master

--2
UPDATE bkp.product_master_20231304
SET material='N/A'
WHERE material is NULL;

UPDATE bkp.product_master_20231304
SET color='N/A'
WHERE color is NULL;

--3
UPDATE bkp.product_master_20231304
SET is_active='false'
WHERE subsubcategoria='Control remoto';

--4
ALTER TABLE bkp.product_master_20231304
ADD is_local boolean;

UPDATE bkp.product_master_20231304
SET is_local='true'
WHERE origen='Argentina';

UPDATE bkp.product_master_20231304
SET is_local='false'
WHERE origen!='Argentina';

--5
ALTER TABLE stg.order_line_sale
ADD line_key varchar;
UPDATE stg.order_line_sale
SET line_key=CONCAT(orden,'-',producto);

--6
DELETE
FROM stg.order_line_sale
WHERE pos=1

--7
CREATE TABLE employees(
		id serial PRIMARY KEY,
		nombre varchar,
		apellido varchar,
		fecha_entrada date,
		fecha_salida date,
		telefono varchar,
		pais varchar,
		provincia varchar,
		codigo_tienda int,
		posicion varchar);
		
--8
INSERT INTO employees (nombre, apellido, fecha_entrada, fecha_salida, telefono, pais, provincia, codigo_tienda, posicion) 
VALUES
	('Juan', 'Perez', '2022-01-01', null ,541113869867, 'Argentina','Santa Fe',2,'Vendedor'),
	('Catalina', 'Garcia', '2022-03-01', null, null, 'Argentina', 'Buenos Aires',2, 'Representante Comercial'),
	('Ana', 'Valdez', '2020-02-21', '2022-03-01', null, 'España', 'Madrid',8,'Jefe Logistica'),
	('Fernando','Moralez', '2022-04-04', null, null, 'España','Valencia', 9, 'Vendedor');

--9
SELECT *, now() as last_updated_ts
INTO bkp.cost
FROM stg.cost

--10
--No se puede recuperar, excepto que hayamos creado un backup. Se podrían volver a agregar los valores con INSERT INTO--
