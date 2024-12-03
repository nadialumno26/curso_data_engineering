WITH order_summary AS (
    SELECT
        u.user_id
        , first_name
        , last_name
        , email
        , COUNT(DISTINCT order_id) AS total_orders
        , round (SUM(order_cost_in_euros),2) AS total_spent
        , round (SUM(order_shipping_cost),2) AS total_shipping
        , EXTRACT (year from order_created_at) AS year_order_purchased
        , EXTRACT (month from order_created_at) AS month_order_purchased
        , EXTRACT (day from order_created_at) AS day_order_purchased
    FROM {{ref('fct_orders')}} o
    JOIN {{ref('dim_users')}} u 
    ON o.user_id = u.user_id
    GROUP BY 1,2,3,4,8,9,10
)

SELECT
    user_id
    , first_name
    , last_name
    , email
    , total_orders
    , total_spent
    , total_shipping
    , year_order_purchased
FROM order_summary