
{{
  config(
    materialized='view'
  )
}}

WITH src_budget AS (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }}
    ),

silver_budget AS (
    SELECT
          _row
        , product_id
        , quantity
        , month AS end_month_budgeted
        , _fivetran_synced AS date_load
    FROM src_budget
    )

SELECT * FROM silver_budget