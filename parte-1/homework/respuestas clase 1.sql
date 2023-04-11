Homework Clase 1

1.	SELECT *
FROM stg.product_master
WHERE categoria= 'Electro'

2.	SELECT *
FROM stg.product_master
WHERE origen='China'

3.	SELECT *
FROM stg.product_master
WHERE categoria= 'Electro'
ORDER BY nombre

4.	SELECT *
FROM stg.product_master
WHERE subcategoria='TV' and is_active='TRUE'

5.	SELECT *
FROM stg.store_master
WHERE país='Argentina'
ORDER BY fecha_apertura ASC

6.	SELECT orden
FROM stg.order_line_sale
ORDER BY fecha DESC
LIMIT 5

7.	SELECT *
FROM stg.super_store_count
ORDER BY fecha	
LIMIT 10

8.	SELECT subsubcategoria
FROM stg.product_master
WHERE categoria='Electro' AND subsubcategoria NOT IN ('Soporte','Control Remoto')

9.	SELECT *
FROM stg.order_line_sale
WHERE venta> 100000 AND moneda='ARS'

10.	SELECT *
FROM stg.order_line_sale
WHERE fecha>= '2022-10-01' AND fecha<= '2022-10-31'


11.	SELECT *
FROM stg.product_master
WHERE ean IS NOT NULL

12.	SELECT *
FROM stg.order_line_sale
WHERE fecha BETWEEN '2022-10-01' AND '2022-11-10'
