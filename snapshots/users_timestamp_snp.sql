{% snapshot users_timestamp_snp %}

{{
    config(
        target_schema='snapshots',
        unique_key='DNI',
        strategy='timestamp',
        updated_at='fecha_alta_sistema'
    )
}}

SELECT
    Nombre,
    DNI,
    email,
    fecha_alta_sistema
FROM {{ source('ALUMNO26_DEV_BRONZE_DB', 'users') }}

{% endsnapshot %}