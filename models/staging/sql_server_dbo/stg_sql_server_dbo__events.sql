with 

source as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

renamed as (

    select
        event_id,
        page_url,
        event_type,
        user_id,
        product_id,
        session_id,
        created_at::TIMESTAMP_NTZ AS created_at_utc,
        order_id,
        _fivetran_deleted AS if_deleted,
        _fivetran_synced::TIMESTAMP_NTZ AS date_load_utc

    from source

)

select * from renamed
