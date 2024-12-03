WITH fct_events AS (
            SELECT *
            FROM {{ref ('stg_sql_server_dbo__events')}}
),
            
events AS (
    SELECT
         event_id
        , page_url
        , event_type
        , user_id
        , product_id
        , session_id
        , order_id
        , created_at_utc
        , if_deleted
        , date_load_utc
    FROM fct_events
)

SELECT * FROM events