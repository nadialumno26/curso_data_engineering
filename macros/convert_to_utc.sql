{% macro convert_to_utc(_fivestran_synced, from_tz) %}
    {% if target.type == 'snowflake' %}
        return "CONVERT_TIMEZONE('{{ from_tz }}', 'UTC', {{ _fivetran_synced }})"
     {% else %}
        -- Default fallback (e.g., unsupported DB)
        return "{{ _fivestran_synced }}"
    {% endif %}
{% endmacro %}