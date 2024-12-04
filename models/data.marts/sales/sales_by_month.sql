WITH product_sales AS (
    SELECT
        p.product_id
        , p.desc_product
        , order_created_at
        , round(SUM(o.order_total_in_euros), 2) AS total_sales
        , round(AVG(o.order_total_in_euros), 2) AS average_sales
        , round(COUNT(o.order_id), 2) AS total_orders
    FROM {{ref ('fct_orders')}} o
    LEFT JOIN {{ref ('dim_products')}} p
        ON o.product_id = p.product_id
    GROUP BY 1,2,3
)

SELECT 
     month_name
    , round (SUM (total_sales),2) AS ventas_totales_mes
    , SUM (total_orders) AS total_orders_mes
FROM product_sales ps 
JOIN {{ref ('dim_date')}} d
ON ps.order_created_at = d.date_day
WHERE desc_product IS NOT NULL
GROUP BY 1
ORDER BY 3 DESC