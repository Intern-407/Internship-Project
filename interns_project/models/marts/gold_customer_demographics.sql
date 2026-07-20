with orders as (
    select * from {{ ref('stg_ecommerce_orders') }}
)

select
    gender,
    case
        when age < 25 then 'Under 25'
        when age between 25 and 34 then '25-34'
        when age between 35 and 44 then '35-44'
        when age between 45 and 54 then '45-54'
        else '55+'
    end as age_group,
    count(*) as order_count,
    count(distinct customer_id) as customer_count,
    sum(total_price_usd) as total_revenue_usd,
    avg(customer_loyalty_score) as avg_loyalty_score
from orders
group by 1, 2
order by 1, 2
