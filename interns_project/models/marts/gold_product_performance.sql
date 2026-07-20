with orders as (
    select * from {{ ref('stg_ecommerce_orders') }}
)

select
    product_id,
    max(product_name) as product_name,
    max(category) as category,
    max(sub_category) as sub_category,
    max(brand) as brand,
    max(product_rating_avg) as product_rating_avg,
    max(product_reviews_count) as product_reviews_count,
    max(stock_quantity) as stock_quantity,
    sum(quantity) as units_sold,
    sum(total_price_usd) as total_revenue_usd,
    sum(profit_usd) as total_profit_usd
from orders
group by product_id
order by total_revenue_usd desc
