WITH stg_sql_server_dbo__date AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__date') }}
    ),

dim_date AS (
        SELECT *
        FROM stg_sql_server_dbo__date
)

SELECT * FROM dim_date