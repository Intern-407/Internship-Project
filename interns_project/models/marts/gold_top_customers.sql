with orders as (
    select * from {{ ref('stg_ecommerce_orders') }}
),

by_customer as (
    select
        customer_id,
        max(customer_name) as customer_name,
        max(customer_segment) as customer_segment,
        max(country) as country,
        max(total_orders_by_customer) as total_orders_by_customer,
        max(customer_loyalty_score) as customer_loyalty_score,
        count(*) as order_count,
        sum(total_price_usd) as total_revenue_usd,
        sum(profit_usd) as total_profit_usd
    from orders
    group by customer_id
)

select *
from by_customer
order by total_revenue_usd desc
limit 100
