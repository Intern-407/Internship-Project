with orders as (
    select * from {{ ref('stg_ecommerce_orders') }}
)

select
    review_sentiment,
    rating,
    count(*) as order_count,
    avg(product_rating_avg) as avg_product_rating_avg
from orders
group by 1, 2
order by 2 desc, 1
