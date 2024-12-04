
WITH src_promos AS (
                    SELECT * 
                    FROM {{ source('sql_server_dbo', 'promos') }}
                    ),

b_promos AS (
    SELECT {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promo_id
        , promo_id AS desc_promo
        , discount AS discount_in_euros
        , status AS promo_status
        , _fivetran_deleted AS if_deleted
        , convert_timezone('UTC', _fivetran_synced) AS date_load_utc
    FROM src_promos
    )

SELECT    promo_id
        , CASE WHEN
            desc_promo = '' then 'not_applicable'
            ELSE desc_promo
            END as desc_promo
        , discount_in_euros
        , promo_status
        , if_deleted
        , date_load_utc
 FROM b_promos