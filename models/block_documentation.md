{% docs event_type %}
	
One of the following values: 

| event type      | definition                                                 |
|-----------------|------------------------------------------------------------|
| page view       | customer looking at website, not yet added to cart         |
| add to cart     | products has been placed in cart, not yet purchased        |
| checkout        | order has been placed and products are paid for            |
| package shipped | order has left warehouse and is being shipped to customer  |

{% enddocs %}

{% docs _fivetran_synced %}
	
_fivetran_synced will express the date the data was loaded.

{% enddocs %}

{% docs _fivetran_deleted %}
	
_fivetran_deleted has data type: boolean. It will flag if there has been a "delete" without necessarily deleting the row. 

{% enddocs %}

{% docs order_items %}
	
order_items is the bridge between orders and products, hence both IDs (order_id, product_id)
are this table's primary key

{% enddocs %}

