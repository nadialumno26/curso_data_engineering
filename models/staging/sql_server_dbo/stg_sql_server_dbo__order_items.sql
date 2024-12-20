
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
        {{ dbt_utils.generate_surrogate_key(['order_id', 'product_id']) }} AS order_items_id
        , order_id
        , product_id
        , quantity
        , _fivetran_deleted as if_deleted
        , convert_timezone('UTC', _fivetran_synced) AS date_load_utc
    FROM src_order_items
    )

SELECT * 
FROM silver_order_items