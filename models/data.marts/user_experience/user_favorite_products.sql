WITH user_order_counts AS (
    SELECT 
        u.user_id
        , p.desc_product
        , COUNT(order_id) AS order_count
    FROM {{ref('fct_orders')}} o
    JOIN {{ref('dim_users')}} u 
    ON u.user_id = o.user_id
    LEFT JOIN {{ref('dim_products')}} p
    ON o.product_id = p.product_id
    GROUP BY u.user_id, p.desc_product
)

SELECT desc_product
    , COUNT (CASE WHEN order_count = 2 THEN 1
            END) AS user_came_back
    , COUNT (CASE WHEN order_count >= 3 THEN 1
            END) AS user_satisfied
FROM user_order_counts
GROUP BY 1
ORDER BY 2 DESC