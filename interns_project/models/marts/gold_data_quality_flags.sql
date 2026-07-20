with orders as (
    select * from {{ ref('stg_ecommerce_orders') }}
),

brand_randomness as (
    select
        'brand_not_tied_to_product' as check_name,
        'Every brand should map to a small, consistent set of products; instead brand appears independent of product_name/category in the source data.' as description,
        count(distinct product_name) as products_checked,
        avg(brands_per_product) as avg_distinct_brands_per_product
    from (
        select product_name, count(distinct brand) as brands_per_product
        from orders
        group by product_name
    )
),

duplicate_order_ids as (
    select
        'duplicate_order_id' as check_name,
        'order_id should be unique; these repeat across genuinely different customers in the source data.' as description,
        count(*) as affected_order_ids,
        null as avg_distinct_brands_per_product
    from (
        select order_id
        from orders
        group by order_id
        having count(*) > 1
    )
),

null_key_fields as (
    select
        'null_key_fields' as check_name,
        'Rows missing a key field (order_id, product_id, or category).' as description,
        count(*) as affected_rows,
        null as avg_distinct_brands_per_product
    from orders
    where order_id is null or product_id is null or category is null
)

select check_name, description, products_checked as affected_count, avg_distinct_brands_per_product
from brand_randomness

union all

select check_name, description, affected_order_ids as affected_count, avg_distinct_brands_per_product
from duplicate_order_ids

union all

select check_name, description, affected_rows as affected_count, avg_distinct_brands_per_product
from null_key_fields
