WITH stg_sql_server_dbo__promos AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__promos') }}
    ),

dim_promos AS (
    SELECT
          promo_id
        , desc_promo
        , discount_in_euros
        , promo_status
        , if_deleted
        , date_load_utc
    FROM stg_sql_server_dbo__promos
    )

SELECT * FROM dim_promos