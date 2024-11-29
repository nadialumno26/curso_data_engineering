WITH stg_sql_server_dbo__products AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__products') }}
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
    FROM stg_sql_server_dbo__products
)

SELECT * FROM dim_addresses