
{% macro validate_total_cost (order_cost_in_euros, shipping_cost_in_euros, order_total_in_euros) %}

    CASE 
        WHEN {{ order_cost_in_euros }} + {{ shipping_cost_in_euros }} = {{order_total_in_euros}} THEN order_total_in_euros
        ELSE THEN 'Fail'
    END 
{% endmacro %}
