WITH promo_sales AS (
    SELECT
        pr.promo_id
        , pr.desc_promo
        , pr.discount_in_euros
        , round(SUM(o.order_total_in_euros), 2) AS total_sales
        , round(AVG(o.order_total_in_euros), 2) AS average_sales
        , round(COUNT(o.order_id), 2) AS total_orders
    FROM fct_orders o
    LEFT JOIN dim_promos pr
        ON o.promo_id = pr.promo_id
    GROUP BY 1,2,3
)

SELECT 
     desc_promo
    , discount_in_euros
    , total_sales
    , average_sales
    , total_orders
FROM promo_sales
WHERE desc_promo IS NOT NULL
ORDER BY 3 DESC