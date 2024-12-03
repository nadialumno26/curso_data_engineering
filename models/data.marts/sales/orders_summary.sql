WITH order_summary AS (
    SELECT
        user_id
        , COUNT(DISTINCT order_id) AS total_orders
        , round (SUM(order_cost_in_euros),2) AS total_spent
        , round (SUM(order_shipping_cost),2) AS total_shipping
        , EXTRACT (year from order_created_at) AS year_order_purchased
    FROM fct_orders 
    GROUP BY 1,5
)

SELECT
    user_id
    , total_orders
    , total_spent
    , total_shipping
    , year_order_purchased
FROM order_summary