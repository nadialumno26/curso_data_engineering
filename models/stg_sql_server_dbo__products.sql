
{{
  config(
    materialized='view'
  )
}}

WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
    ),

silver_products AS (
    SELECT
          product_id
        , name AS desc_product
        , price AS price_in_euro
        , inventory 
        , _fivetran_deleted AS if_deleted
        , _fivetran_synced::TIMESTAMP_NTZ AS date_load_utc
    FROM src_products
    )

SELECT * FROM silver_products