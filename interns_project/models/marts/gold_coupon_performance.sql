with orders as (
    select * from {{ ref('stg_ecommerce_orders') }}
)

select
    coupon_used,
    coupon_code,
    count(*) as order_count,
    sum(total_price_usd) as total_revenue_usd,
    sum(discount_amount_usd) as total_discount_usd
from orders
group by 1, 2
order by order_count desc
