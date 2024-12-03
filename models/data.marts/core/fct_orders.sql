WITH orders AS (
            SELECT 
                  order_id
                , user_id
                , address_id
                , promo_id
                , created_at_utc AS order_created_at
                , estimated_delivery_at_utc AS order_estimated_delivery
                , delivered_at_utc AS order_delivered_at
                , order_cost_in_euros
                , shipping_cost_in_euros AS order_shipping_cost
                , order_total_in_euros
                , shipping_service
                , tracking_id AS order_tracking_id
                , order_status
                , if_deleted
                , date_load_utc
            FROM {{ref('stg_sql_server_dbo__orders')}}
)

SELECT 
        order_items_id
        , o.order_id
        , product_id
        , quantity AS order_quantity
        , user_id
        , o.address_id
        , o.promo_id
        , o.order_created_at
        , o.order_estimated_delivery
        , o.order_delivered_at
        , o.order_cost_in_euros
        , o.order_shipping_cost
        , o.order_total_in_euros
        , o.shipping_service
        , o.order_tracking_id
        , o.order_status
        , o.if_deleted
        , o.date_load_utc

FROM {{ref ('stg_sql_server_dbo__order_items')}} ot 
LEFT JOIN orders o
ON ot.order_id = o.order_id