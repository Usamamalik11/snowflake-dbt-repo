with raw as (
    select * from {{source("staging_sources","orders")}}
),
final as (
    select ID as order_id,
    USER_ID AS customer_id,
    ORDER_DATE,
    STATUS
    from raw
)

SELECT * from final