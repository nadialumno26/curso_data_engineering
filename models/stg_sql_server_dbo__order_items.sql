
{{
  config(
    materialized='view'
  )
}}

WITH src_order_items AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'order_items') }}
    ),

silver_order_items AS (
    SELECT
         md5 (order_id, product_id) as order_items_id
        , order_id
        , product_id
        , quantity
        , _fivetran_synced AS date_load
    FROM src_order_items
    )

SELECT * 
FROM silver_order_items