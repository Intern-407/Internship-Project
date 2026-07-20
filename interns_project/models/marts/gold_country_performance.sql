with orders as (
    select * from {{ ref('stg_ecommerce_orders') }}
)

select
    country,
    count(*) as order_count,
    count(distinct customer_id) as customer_count,
    sum(total_price_usd) as total_revenue_usd,
    sum(profit_usd) as total_profit_usd
from orders
group by 1
order by total_revenue_usd desc
