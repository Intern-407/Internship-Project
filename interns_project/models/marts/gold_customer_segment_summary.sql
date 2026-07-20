with orders as (
    select * from {{ ref('stg_ecommerce_orders') }}
)

select
    customer_segment,
    count(*) as order_count,
    count(distinct customer_id) as customer_count,
    sum(total_price_usd) as total_revenue_usd,
    avg(total_price_usd) as avg_order_value_usd
from orders
group by 1
order by total_revenue_usd desc
