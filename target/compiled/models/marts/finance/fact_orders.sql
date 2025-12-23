

with orders as  (
    select * from analytics.dbt_ayajnik.stg_jaffle_shop__orders
),

payments as (
    select * from analytics.dbt_ayajnik.stg_stripe__payment
),

order_payments as (
    select
        order_id,
        sum (case when status = 'success' then amount end) as amount

    from payments
    group by 1
),

 final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce (order_payments.amount, 0) as amount

    from orders
    left join order_payments using (order_id)
)

select * from final

  where order_date > (select max(order_date) from analytics.dbt_ayajnik.fact_orders)

order by order_date desc