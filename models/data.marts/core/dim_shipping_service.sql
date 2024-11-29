WITH stg_sql_server_dbo__shipping_service AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__shipping_service') }}
    ),

dim_shipping_service AS (
        SELECT 
              shipping_service_id
            , shipping_service
            , if_deleted
            , date_load_utc
        FROM stg_sql_server_dbo__shipping_service
)

SELECT* FROM dim_shipping_service