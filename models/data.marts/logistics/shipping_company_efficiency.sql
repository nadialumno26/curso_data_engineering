WITH delivery_data AS (
    SELECT
        o.order_id
        , o.shipping_service_id
        , ss.shipping_service
        , DATEDIFF('day', o.order_created_at, o.order_delivered_at) AS delivery_days
    FROM {{ ref('fct_orders') }} o
    LEFT JOIN {{ ref('dim_shipping_service') }} ss
        ON o.shipping_service_id = ss.shipping_service_id
    WHERE o.order_delivered_at IS NOT NULL
),
average_delivery_time AS (
    SELECT shipping_service_id
        , shipping_service
        , AVG(delivery_days) AS avg_delivery_time
    FROM delivery_data
    GROUP BY shipping_service_id, shipping_service
)
SELECT
    shipping_service
    , ROUND(avg_delivery_time, 2) AS avg_delivery_time
FROM average_delivery_time
ORDER BY 2 DESC