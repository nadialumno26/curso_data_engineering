
{{
  config(
    materialized='view'
  )
}}

WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
    ),

silver_promos AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promo_id
        , promo_id AS desc_promo
        , discount AS discount_in_euros
        , status AS promo_status
        , _fivetran_deleted AS if_deleted
        , _fivetran_synced::TIMESTAMP_NTZ AS date_load
    FROM src_promos
    )

SELECT * FROM silver_promos