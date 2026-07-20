with orders as (
    select * from {{ ref('stg_ecommerce_orders') }}
)

select
    campaign_source,
    device_type,
    traffic_source,
    count(*) as order_count,
    sum(case when coupon_used then 1 else 0 end) as coupon_used_count,
    sum(case when abandoned_cart_before then 1 else 0 end) as abandoned_cart_count,
    avg(session_duration_minutes) as avg_session_duration_minutes,
    avg(pages_visited) as avg_pages_visited,
    sum(total_price_usd) as total_revenue_usd
from orders
group by 1, 2, 3
order by total_revenue_usd desc
