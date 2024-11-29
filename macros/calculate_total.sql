
{% macro validate_cost_total(order_cost_in_euros, shipping_cost_in_euros, order_total_in_euros) %}
    CASE 
        WHEN {{ order_cost_in_euros }} + {{ shipping_cost_in_euros }} =! {{order_total_in_euros}} THEN 'Fail'
        ELSE order_total_in_euros
    END
{% endmacro %}
