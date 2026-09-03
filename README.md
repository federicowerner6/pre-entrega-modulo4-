# Pre-entrega: Consultas multicapa para análisis de negocio (Módulo 4)

Este repositorio contiene las soluciones SQL a los problemas de negocio planteados en el Módulo 4 del curso.

## Estructura del repositorio
* `pre-entrega-modulo4.sql`: Script SQL principal con las 3 consultas solicitadas y sus explicaciones de negocio.
* `README.md`: Documentación del proyecto.

## Descripción de las Consultas

1. **Rentabilidad por Categoría:**
   * **Objetivo:** Identificar el volumen de unidades vendidas y los ingresos por categoría de producto.
   * **Implementación:** Une 3 tablas (`ventas`, `productos`, `categorias`) mediante `INNER JOIN`, agrupando por categoría y aplicando un filtro `HAVING` sobre las ventas totales.

2. **Clientes sin Compras:**
   * **Objetivo:** Detectar clientes registrados que no registran transacciones para campañas de reengagement.
   * **Implementación:** Utiliza `LEFT JOIN` entre `clientes` y `ventas`, filtrando los registros sin coincidencia (`IS NULL`) y gestionando valores nulos con `COALESCE`.

3. **Top de compras por cliente (Ranking de Volumen Total):**
   * **Objetivo:** Consolidar el volumen total gastado por cliente y su fecha de última transacción para armar el ranking de clientes principales.
   * **Implementación:** Une `clientes`, `ventas` y `productos`, utilizando agregaciones (`SUM`, `MAX`), `GROUP BY` y ordenamiento descendente por volumen abonado.
