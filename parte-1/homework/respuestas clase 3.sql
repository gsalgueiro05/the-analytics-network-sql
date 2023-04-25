--Homework Clase 3--

--1
SELECT nombre, codigo_producto, categoria, coalesce(color,'Unknown') as color
FROM stg.product_master
WHERE nombre LIKE '%PHILIPS%' OR nombre LIKE '%Samsung%'

--2
SELECT sm.pais, sm.provincia, ols.moneda, sum(ols.venta) as venta_bruta, sum(ols.impuestos) as impuestos
FROM stg.order_line_sale as ols
LEFT JOIN stg.store_master as sm
ON ols.tienda=sm.codigo_tienda
GROUP BY pais, provincia,moneda

--3
SELECT subcategoria, sum(venta) as venta_total,moneda
FROM stg.order_line_sale as ols
LEFT JOIN stg.product_master as pm
ON ols.producto=pm.codigo_producto
GROUP BY subcategoria,moneda
ORDER BY subcategoria, moneda

--4
SELECT subcategoria, sum(cantidad) as unidades_vendidas, concat(pais,'-',provincia) as sitio
FROM stg.order_line_sale as ols
LEFT JOIN stg.product_master as pm
ON ols.producto=pm.codigo_producto
LEFT JOIN stg.store_master as sm
ON sm.codigo_tienda=ols.tienda
GROUP BY subcategoria, sitio
ORDER BY sitio

--5
	SELECT nombre, sum(conteo) as total_personas
	FROM stg.super_store_count as ssc
	LEFT JOIN stg.store_master as sm
	ON sm.codigo_tienda=ssc.tienda
	GROUP BY nombre

--6
SELECT i.sku, i.tienda, sm.nombre, avg((inicial+final)/2) as inv_promedio, extract(month from fecha) as mes
FROM stg.inventory as i
LEFT JOIN stg.store_master as sm
ON sm.codigo_tienda=i.tienda
GROUP BY sm.nombre, i.tienda, i.sku, mes

--7
SELECT
CASE
	when material='Metal' then 'Metal'
	when material='plastico' then 'Plastico'
	when material='PLASTICO' then 'Plastico'
	else 'Unknown'
	end as group_material,
sum(cantidad) as unidades_vendidas
FROM stg.order_line_sale as ols
LEFT JOIN stg.product_master as pm
ON pm.codigo_producto=ols.producto
GROUP BY group_material

--8
SELECT *,
round((CASE
	when moneda='ARS' then venta/cotizacion_usd_peso
	when moneda='URU' then venta/cotizacion_usd_uru
	when moneda='EUR' then venta/cotizacion_usd_eur
	else 0
	end),2) as venta_usd
FROM stg.order_line_sale as ols
LEFT JOIN stg.monthly_average_fx_rate as mafr
ON extract(month from ols.fecha)=extract(month from mafr.mes)

--9

SELECT 
round(sum(CASE
	when moneda='ARS' then venta/cotizacion_usd_peso
	when moneda='URU' then venta/cotizacion_usd_uru
	when moneda='EUR' then venta/cotizacion_usd_eur
	else 0
	end),2) as venta_usd
FROM stg.order_line_sale as ols
LEFT JOIN stg.monthly_average_fx_rate as mafr
ON extract(month from ols.fecha)=extract(month from mafr.mes)

--10

SELECT ols.*,
round(CASE
	when moneda='ARS' then (venta+coalesce(descuento,0))/cotizacion_usd_peso - costo_promedio_usd
	when moneda='EUR' then (venta+coalesce(descuento,0))/cotizacion_usd_eur - costo_promedio_usd
	when moneda='URU' then (venta+coalesce(descuento,0))/cotizacion_usd_uru - costo_promedio_usd
	else 0
	end,2) as margen_venta
FROM stg.order_line_sale as ols
LEFT JOIN stg.monthly_average_fx_rate as mafr
ON extract(month from ols.fecha)=extract(month from mafr.mes)
LEFT JOIN stg.cost as c
ON c.codigo_producto=ols.producto

--11

SELECT orden, count(distinct subsubcategoria)
FROM stg.order_line_sale as ols
LEFT JOIN stg.product_master as pm
ON ols.producto=pm.codigo_producto
GROUP BY orden
