WITH product_sales AS (
    SELECT
        p.product_id
        , p.desc_product
        , p.price_in_euro
        , order_quantity
        , pr.discount_in_euros
        , p.inventory
        , SUM(order_quantity) AS units_sold
        , round (p.price_in_euro * inventory) AS cost_inventory
        , round (p.price_in_euro * order_quantity) AS revenue_per_purchase
    FROM fct_orders o
    LEFT JOIN dim_products p
    ON o.product_id = p.product_id
    LEFT JOIN dim_promos pr
    ON o.promo_id = pr.promo_id
    GROUP BY 1,2,3,4,5,6
),

net_profit_calculation AS (
    SELECT
        desc_product
        , units_sold
        , cost_inventory
        , (units_sold * revenue_per_purchase) AS total_gross_revenue --with promo
        , (revenue_per_purchase - discount_in_euros) AS net_product_revenue --took out promo
    FROM product_sales
)

SELECT  desc_product
    ,  ROW_NUMBER () OVER (PARTITION BY desc_product ORDER BY net_product_revenue) AS product_rank
    , total_gross_revenue
    , (net_product_revenue * units_sold) AS total_net_profit
    , (cost_inventory - units_sold) AS cost_spare_inventory
FROM net_profit_calculation
WHERE product_rank = 1
GROUP BY 1, 2, 3, 4, 5
