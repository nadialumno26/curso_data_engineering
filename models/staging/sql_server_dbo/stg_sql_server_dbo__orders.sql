


WITH src_orders AS (
    SELECT * 
    FROM {{ ref("base_sql_server_dbo_orders") }}
    ),

silver_orders AS (
    SELECT
          order_id
        , user_id
        , address_id
        , promo_id
        , created_at_utc
        , estimated_delivery_at_utc
        , delivered_at_utc
        , order_cost_in_euros
        , order_total_in_euros
        , shipping_cost_in_euros
        , shipping_service
        , tracking_id
        , order_status
        , if_deleted
        , date_load_utc
    FROM src_orders
    )

SELECT * FROM silver_orders