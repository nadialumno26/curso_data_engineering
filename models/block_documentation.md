{% docs event_type %}
	
One of the following values: 

| event type      | definition                                                 |
|-----------------|------------------------------------------------------------|
| page view       | customer looking at website, not yet added to cart         |
| add to cart     | products has been placed in cart, not yet purchased        |
| checkout        | order has been placed and products are paid for            |
| package shipped | order has left warehouse and is being shipped to customer  |

{% enddocs %}

{% docs order_items %}
	
order_items is the bridge between orders and products, hence both IDs (order_id, product_id)
are this table's primary key.
In the core layer this tables is joined to orders, creating a macro table named dim_orders

{% enddocs %}

{% docs is_valid_email_test %}
	
a test inserted in the dim_users that ensures that the email given by the user is written correctly

{% enddocs %}

{% docs users_timestamp_snp %}
	
snapshot done in the user's source, the client wants to keep their user's historical information

{% enddocs %}

{% docs dbt_utils %}

- `surrogate_key` to create a randomly selected id
- `at_least_one test` a test to ensure that at least one "item" is a data entry, used 
                        for inventory and quantity


{% enddocs %}

{% docs dbt_expectations %}

- `expect_column_values_to_be_in_set` test where the approved value_set is: 
                                    'page_view', 'add_to_cart', 'checkout', 'package_shipped'
                                    
{% enddocs %}
