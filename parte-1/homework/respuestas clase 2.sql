Homework Clase 2

--1
SELECT distinct(pais)
FROM stg.store_master

--2
SELECT subcategoria, count(codigo_producto)
FROM stg.product_master
GROUP BY subcategoria

--3
SELECT *
FROM stg.order_line_sale
WHERE moneda='ARS' and venta>'100000'


--4
SELECT moneda, coalesce(sum(descuento),0)
FROM stg.order_line_sale
WHERE fecha BETWEEN '2022-11-01' AND '2022-11-30'
GROUP BY moneda

--5
SELECT sum(impuestos) as impuestos
FROM stg.order_line_sale
WHERE moneda='EUR' and fecha BETWEEN '2022-01-01' AND '2022-12-31'


--6
SELECT count (distinct orden)
FROM stg.order_line_sale
WHERE creditos IS NOT null

--7
SELECT tienda, sum(venta) as total_venta, sum(descuento) as total_dcto, round(sum(descuento)/sum(venta)*100,2) as porcentaje_dcto
FROM stg.order_line_sale
GROUP BY tienda


--8
SELECT fecha,tienda, avg((inicial+final)/2) as inventario_promedio
FROM stg.inventory
GROUP BY fecha, tienda
ORDER BY fecha, tienda

--9
SELECT 	producto, 
		moneda,
		sum(venta+coalesce(descuento,0)- coalesce(impuestos,0)) as venta_neta,
		round(sum(coalesce(descuento,0))/sum(venta) * 100,2) as porcentaje_dcto
FROM stg.order_line_sale
WHERE moneda='ARS'
GROUP BY producto, moneda
ORDER BY producto

--10
SELECT tienda, cast(fecha as varchar(10)),conteo FROM stg.market_count
UNION ALL
SELECT tienda, cast(fecha as varchar(10)),conteo FROM stg.super_store_count

--11
SELECT *
FROM stg.product_master
WHERE nombre LIKE '%PHILIPS%' AND is_active='true'

--12
SELECT tienda, moneda, sum(venta)
FROM stg.order_line_sale
GROUP BY tienda, moneda
ORDER BY sum(venta) DESC

--13
SELECT producto, moneda, round(sum(venta)/sum(cantidad),2) as precio_promedio
FROM stg.order_line_sale
GROUP BY producto, moneda
ORDER BY producto, moneda

--14
SELECT orden, round(sum(impuestos)/sum(venta)*100,2) as tasa_impuestos
FROM stg.order_line_sale
GROUP BY orden
ORDER BY orden
