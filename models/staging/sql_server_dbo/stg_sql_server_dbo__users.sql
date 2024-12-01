
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
        , convert_timezone('UTC',created_at) created_at_utc
        , convert_timezone('UTC',updated_at) AS updated_at_utc
        , _fivetran_deleted AS if_deleted
        , convert_timezone('UTC',_fivetran_synced) AS date_load_utc
    FROM src_users
    )

SELECT * FROM silver_users