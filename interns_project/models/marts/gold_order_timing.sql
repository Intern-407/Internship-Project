with orders as (
    select * from {{ ref('stg_ecommerce_orders') }}
)

select
    is_weekend,
    order_priority,
    count(*) as order_count,
    sum(total_price_usd) as total_revenue_usd
from orders
group by 1, 2
order by 1, 2
