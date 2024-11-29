WITH stg_sql_server_dbo__users AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__users') }}
    ),

dim_users AS (
    SELECT
        user_id
        , address_id
        , first_name
        , last_name
        , email
        , phone_number
        , created_at_utc
        , updated_at_utc
        , date_load
    FROM stg_sql_server_dbo__users
    )

SELECT * FROM dim_users