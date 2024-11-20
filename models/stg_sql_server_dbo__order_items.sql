
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
         order_id
        , product_id
        , quantity
        , _fivetran_deleted as if_deleted
        , _fivetran_synced::TIMESTAMP_NTZ as date_load
    FROM src_order_items
    )

SELECT * 
FROM silver_order_items