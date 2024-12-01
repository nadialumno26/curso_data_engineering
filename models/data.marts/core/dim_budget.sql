WITH stg_google_sheets__budget AS (
    SELECT * 
    FROM {{ ref('stg_google_sheets__budget') }}
    ),

dim_budget AS (
    SELECT
          _row
        , product_id
        , quantity
        , month
        , date_load_utc
    FROM stg_google_sheets__budget
    )

SELECT * FROM dim_budget