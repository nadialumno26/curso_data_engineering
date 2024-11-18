
{{
  config(
    materialized='view'
  )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
    ),

renamed_casted AS (
    SELECT
          user_id
        , updated_at
        , address_id
        , first_name
        , last_name
        , created_at::TIMESTAMP_NTZ AS profile_created_at
        , phone_number
        , email
        , _fivetran_deleted AS if_deleted
        , _fivetran_synced AS date_load
    FROM src_users
    )

SELECT * FROM renamed_casted