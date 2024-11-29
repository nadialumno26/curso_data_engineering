
WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
    ),

silver_addresses AS (
    SELECT
        address_id
        , address
        , zipcode
        , state
        , country
        , _fivetran_deleted AS if_deleted
        , convert_timezone('UTC',_fivetran_synced) AS date_load_utc
    FROM src_addresses
    )

SELECT * FROM silver_addresses