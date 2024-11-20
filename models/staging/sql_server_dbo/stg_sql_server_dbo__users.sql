
{{
  config(
    materialized='view'
  )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
    ),

silver_users AS (
    SELECT
          user_id
        , address_id
        , first_name
        , last_name
        , phone_number
        , email
        , created_at::TIMESTAMP_NTZ AS created_at_utc
        , updated_at::TIMESTAMP_NTZ AS updated_at_utc
        , _fivetran_deleted AS if_deleted
        , _fivetran_synced::TIMESTAMP_NTZ AS date_load_utc
    FROM src_users
    )

SELECT * FROM silver_users