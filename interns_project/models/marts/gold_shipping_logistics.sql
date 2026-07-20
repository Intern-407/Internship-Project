with orders as (
    select * from {{ ref('stg_ecommerce_orders') }}
)

select
    shipping_method,
    delivery_status,
    warehouse_location,
    count(*) as order_count,
    avg(delivery_days) as avg_delivery_days,
    avg(shipping_cost_usd) as avg_shipping_cost_usd
from orders
group by 1, 2, 3
order by order_count desc
