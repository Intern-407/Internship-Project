with orders as (
    select * from {{ ref('stg_ecommerce_orders') }}
)

select
    order_priority,
    case
        when fraud_risk_score < 20 then 'Low (0-20)'
        when fraud_risk_score < 50 then 'Medium (20-50)'
        when fraud_risk_score < 80 then 'High (50-80)'
        else 'Critical (80-100)'
    end as fraud_risk_band,
    count(*) as order_count,
    avg(profit_margin_percent) as avg_profit_margin_percent,
    sum(total_price_usd) as total_revenue_usd
from orders
group by 1, 2
order by 1, 2
