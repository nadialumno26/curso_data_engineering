WITH users AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__users_snp') }}
    ),

dim_users AS (
    SELECT
        user_id
        , address_id
        , first_name
        , last_name
        , email
        , coalesce (regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')= true,false) as is_valid_email_address
        , phone_number
        , created_at_utc
        , updated_at_utc
        , if_deleted
        , date_load_utc
    FROM users
    )

SELECT * FROM dim_users