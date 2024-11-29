WITH stg_sql_server_dbo__products AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__products') }}
    ),

dim_products AS (
    SELECT
          product_id
        , desc_product
        , price_in_euro
        , inventory 
        , if_deleted
        , date_load_utc
    FROM stg_sql_server_dbo__products
)

SELECT * FROM dim_products