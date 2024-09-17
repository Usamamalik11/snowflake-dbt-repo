{{config (
    database = 'Golden',
    schema= 'analytics'
)
}}


WITH customers as (
    SELECT * FROM {{ref('stg_customers')}}
),

 orders as (
    select * from {{ref('stg_orders')}}
),
 payments as (
    select * from {{ref('stg_payments')}}
)
,
customer_level_details as (
    SELECT 
    c.FIRST_NAME,
    c.LAST_NAME,
    c.customer_id,
    min(o.ORDER_DATE) as first_order,
    max(o.ORDER_DATE) as last_order
     FROM CUSTOMERS  c
    LEFT JOIN ORDERS o
    on c.customer_id = o.customer_id
    group by c.FIRST_NAME,c.LAST_NAME,c.customer_id
)
,payment_details as (
    SELECT 
    o.customer_id,
    SUM(P.sales_amount) as sales
    
    FROM payments p 
    LEFT JOIN ORDERS o 
    on p.order_id= o.order_id
    group by o.customer_id

)

,
final as (
    select cl.*,pd.sales from customer_level_details cl
    left join payment_details pd
    on cl.customer_id =pd.customer_id
)
select * from final