with 

src_events as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

silver_events as (

    select
         event_id
        , page_url
        , event_type
        , user_id
        , product_id
        , session_id
        , convert_timezone('UTC',created_at) AS created_at_utc
        , order_id
        , _fivetran_deleted AS if_deleted
        , convert_timezone('UTC',_fivetran_synced) AS convert_to_utc

    from src_events

)

select * from silver_events
