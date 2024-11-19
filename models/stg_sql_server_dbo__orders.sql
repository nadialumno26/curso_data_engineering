
{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

silver_orders AS (
    SELECT
          order_id
        , user_id
        , address_id
        , md5 (promo_id) AS promo_id
        , created_at::TIMESTAMP_NTZ AS created_at_utc
        , estimated_delivery_at::TIMESTAMP_NTZ AS estimated_delivery_at_utc
        , delivered_at::TIMESTAMP_NTZ AS delivered_at_utc
        , order_cost AS order_cost_in_euros
        , order_total AS order_total_in_euros
        , shipping_service
        , shipping_cost AS shipping_cost_in_euros
        , tracking_id
        , status AS order_status
        , _fivetran_deleted AS if_deleted
        , _fivetran_synced AS date_load
    FROM src_orders
    )

SELECT * FROM silver_orders