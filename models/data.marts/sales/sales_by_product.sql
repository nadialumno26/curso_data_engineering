WITH product_sales AS (
    SELECT
        p.product_id
        , p.desc_product
        , round(SUM(o.order_total_in_euros), 2) AS total_sales
        , round(AVG(o.order_total_in_euros), 2) AS average_sales
        , round(COUNT(o.order_id), 2) AS total_orders
    FROM {{ref ('fct_orders')}} o
    LEFT JOIN {{ref ('dim_products')}} p
        ON o.product_id = p.product_id
    GROUP BY 1,2
)

SELECT 
     desc_product
    , total_sales
    , average_sales
    , total_orders
FROM product_sales
WHERE desc_product IS NOT NULL
ORDER BY 2 DESC