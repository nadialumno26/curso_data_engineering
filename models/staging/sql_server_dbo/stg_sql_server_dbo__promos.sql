
WITH src_promos AS (
    SELECT * 
    FROM {{ref('base_sql_server_dbo_promos') }}
    ),

silver_promos AS (
    SELECT
          promo_id
        , desc_promo
        , discount_in_euros
        , promo_status
        , if_deleted
        , date_load_utc
    FROM src_promos
    )

SELECT * FROM silver_promos