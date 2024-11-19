{% test positive_values(budget, quantity) %}

   select *
   from {{ budget }}
   where {{ quantity }} < 0

{% endtest %}

{% test positive_values(orders, order_total) %}

   select *
   from {{ orders }}
   where {{ order_total }} < 0

{% endtest %}

{% test positive_values(orders, order_cost) %}

   select *
   from {{ orders }}
   where {{ order_cost }} < 0

{% endtest %}

{% test positive_values(orders, order_total) %}

   select *
   from {{ orders }}
   where {{ order_total }} < 0

{% endtest %}

{% test positive_values(orders, shipping_cost) %}

   select *
   from {{ orders }}
   where {{ shipping_cost }} < 0

{% endtest %}

{% test positive_values(order_items, quantity) %}

   select *
   from {{ order_items }}
   where {{ quantity }} < 0

{% endtest %}