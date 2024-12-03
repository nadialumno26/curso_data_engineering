WITH shipping_information AS (
    SELECT 
          a.state
        , o.shipping_service
        , DATEDIFF (hour, order_estimated_delivery, order_delivered_at) AS hours_taken_to_deliver
    FROM fct_orders o
    LEFT JOIN dim_addresses a
    ON o.address_id = a.address_id
    GROUP BY 1,2,3
),

avg_time AS (
            SELECT DISTINCT  
                              state
                            , round (AVG (hours_taken_to_deliver), 2) AS avg_time_to_deliver
FROM shipping_information
GROUP BY state
)

SELECT  DISTINCT 
                  state
                , avg_time_to_deliver
FROM avg_time
WHERE avg_time_to_deliver IS NOT NULL
GROUP BY 1, 2
