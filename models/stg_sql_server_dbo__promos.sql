
{{
  config(
    materialized='view'
  )
}}

WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
    ),

renamed_casted AS (
    SELECT
          distinct md5 (promo_id) AS promo_id
        , promo_id AS desc_promo
        , discount AS discount_in_euro
        , status AS promo_status
        , _fivetran_deleted AS if_deleted
        , _fivetran_synced AS date_load
    FROM src_promos
    )

SELECT * FROM renamed_casted