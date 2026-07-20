with orders as (
    select * from {{ ref('stg_ecommerce_orders') }}
)

select
    category,
    order_status,
    return_reason,
    sum(case when support_ticket_created then 1 else 0 end) as support_ticket_count,
    count(*) as order_count
from orders
group by 1, 2, 3
order by order_count desc
