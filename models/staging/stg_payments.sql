with raw as (
    select * from {{source("staging_sources","payments")}}
),
final as (
    select ID as payment_id,
    order_id,
    payment_method as payment_mode,
    amount/100 as sales_amount
    from raw
)

SELECT * from final