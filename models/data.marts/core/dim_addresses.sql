WITH stg_sql_server_dbo__addresses AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__addresses') }}
    ),

dim_addresses AS (
    SELECT
        address_id
        , address
        , zipcode
        , state
        , country
        , if_deleted
        , date_load_utc
    FROM stg_sql_server_dbo__addresses
)

SELECT * FROM dim_addresses