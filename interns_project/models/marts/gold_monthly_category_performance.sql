with orders as (
    select * from {{ ref('stg_ecommerce_orders') }}
)

select
    date_trunc('month', order_date)::date as order_month,
    category,
    count(*) as order_count,
    sum(quantity) as units_sold,
    sum(total_price_usd) as total_revenue_usd,
    sum(profit_usd) as total_profit_usd,
    avg(discount_percent) as avg_discount_percent
from orders
group by 1, 2
order by 1, 2
