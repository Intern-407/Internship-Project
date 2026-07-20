with orders as (
    select * from {{ ref('stg_ecommerce_orders') }}
)

select
    payment_method,
    payment_status,
    installment_plan,
    count(*) as order_count,
    sum(total_price_usd) as total_revenue_usd
from orders
group by 1, 2, 3
order by total_revenue_usd desc
