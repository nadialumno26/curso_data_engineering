
{{
  config(
    materialized='view'
  )
}}

WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
    ),

renamed_casted AS (
    SELECT
          addresses_id
        , address
        , zipcode
        , state
        , country
        , _fivetran_deleted AS if_deleted
        , _fivetran_synced AS date_load
    FROM src_addresses
    )

SELECT * FROM renamed_casted