-- =============================================================================
-- PRE-ENTREGA MÓDULO 4: Consultas multicapa para análisis de negocio
-- Script: pre-entrega-modulo4.sql
-- =============================================================================

-- -----------------------------------------------------------------------------
-- CONSULTA 1: Rentabilidad por Categoría
-- Problema de negocio: Evaluar el rendimiento comercial por categoría de producto,
-- calculando el total de unidades vendidas y los ingresos generados. Permite 
-- identificar las líneas de productos más rentables e implementar un filtro (HAVING)
-- para considerar solo aquellas categorías que superen un umbral de ventas determinado.
-- -----------------------------------------------------------------------------

SELECT 
    cat.nombre_categoria AS categoria,
    SUM(v.cantidad) AS unidades_vendidas,
    SUM(v.cantidad * p.precio_unitario) AS ingreso_total
FROM ventas v
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
GROUP BY cat.id_categoria, cat.nombre_categoria
HAVING SUM(v.cantidad * p.precio_unitario) > 10000
ORDER BY ingreso_total DESC;


-- -----------------------------------------------------------------------------
-- CONSULTA 2: Clientes sin Compras (Inactivos)
-- Problema de negocio: Detectar a los clientes registrados en el sistema que
-- aún no han realizado ninguna transacción. Permite al equipo de marketing 
-- diseñar campañas de activación/emailing dirigidas.
-- Manejo de Nulos: Se utiliza LEFT JOIN y la función COALESCE para evitar devolver
-- valores NULL en las agregaciones.
-- -----------------------------------------------------------------------------

SELECT 
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.email AS email_cliente,
    COALESCE(COUNT(v.id_venta), 0) AS total_compras,
    COALESCE(SUM(v.cantidad * p.precio_unitario), 0) AS monto_total_gastado
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
LEFT JOIN productos p ON v.id_producto = p.id_producto
WHERE v.id_venta IS NULL
GROUP BY c.id_cliente, c.nombre, c.email;


-- -----------------------------------------------------------------------------
-- CONSULTA 3: Top de compras por cliente (Ranking de Volumen Total)
-- Problema de negocio: Calcular el volumen total de compras por cliente (unidades 
-- compradas e ingresos acumulados) y la fecha de su última transacción, generando
-- un ranking descendente para identificar a los clientes VIP (Top Buyers).
-- Tablas unidas: clientes, ventas y productos.
-- -----------------------------------------------------------------------------

SELECT 
    c.id_cliente,
    c.nombre AS nombre_cliente,
    COALESCE(SUM(v.cantidad), 0) AS total_unidades_compradas,
    COALESCE(SUM(v.cantidad * p.precio_unitario), 0) AS volumen_total_compras,
    MAX(v.fecha_venta) AS fecha_ultima_transaccion
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
LEFT JOIN productos p ON v.id_producto = p.id_producto
GROUP BY c.id_cliente, c.nombre
ORDER BY volumen_total_compras DESC;





