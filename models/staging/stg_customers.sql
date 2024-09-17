with raw as (
    select * from {{source("staging_sources","customers")}}
),
final as (
    select ID as Customer_ID,
    FIRST_NAME,
    LAST_NAME
    from raw
)

SELECT * from final