{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

silver_shipping_service AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['shipping_service']) }} as shipping_service_id
        , CASE WHEN shipping_service = '' THEN 'not_assigned'
                ELSE shipping_service
            END AS shipping_service
        , _fivetran_deleted AS if_deleted
        , _fivetran_synced AS date_load_utc
    FROM src_orders
    )

SELECT *
 FROM silver_shipping_service