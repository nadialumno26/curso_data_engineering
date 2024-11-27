WITH base_orders AS (
                    SELECT * 
                    FROM {{ source('sql_server_dbo', 'orders') }}
                    ),

b_orders AS (
    SELECT
          order_id
        , user_id
        , address_id
        , promo_id
        , convert_timezone('UTC',created_at) AS created_at_utc
        , convert_timezone('UTC', estimated_delivery_at) AS estimated_delivery_at_utc
        , convert_timezone('UTC',delivered_at) AS delivered_at_utc
        , order_cost AS order_cost_in_euros
        , order_total AS order_total_in_euros
        , shipping_cost AS shipping_cost_in_euros
        ,   CASE WHEN shipping_service = '' THEN 'not_assigned'
                ELSE shipping_service
            END AS shipping_service
        , tracking_id
        , status AS order_status
        , _fivetran_deleted AS if_deleted
        , convert_timezone('UTC',_fivetran_synced) AS date_load_utc
    FROM base_orders
    )

SELECT   order_id
        , user_id
        , address_id
        , {{ dbt_utils.generate_surrogate_key(['promo_id'])}} as promo_id
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
 FROM b_orders