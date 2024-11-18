
{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

renamed_casted AS (
    SELECT
          order_id,
        , shipping_service
        , shipping_cost AS shipping_cost_in_euro
        , address_id
        , created_at::TIMESTAMP_NTZ AS order_created_at
        , distinct md5 (promo_id) AS promo_id
        , estimated_delivery_at::TIMESTAMP_NTZ AS estimated_delivery_at_utc
        , order_cost AS order_cost_in_euro
        , user_id
        , order_total AS order_total_in_euro
        , delivered_at::TIMESTAMP_NTZ AS delivered_at_utc
        , tracking_id
        , status AS order_status
        , _fivetran_deleted AS if_deleted
        , _fivetran_synced AS date_load
    FROM src_orders
    )

SELECT * FROM renamed_casted