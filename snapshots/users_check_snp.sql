{% snapshot users_check_snp%}

{{
    config(
        target_schema='snapshots',
        unique_key='DNI',
        strategy='check',
        check_cols=['Nombre', 'email']
    )
}}

SELECT
    Nombre,
    DNI,
    email,
    fecha_alta_sistema
FROM {{ source('ALUMNO26_DEV_BRONZE_DB', 'users') }}

{% endsnapshot %}