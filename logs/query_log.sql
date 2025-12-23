-- created_at: 2025-12-23T18:24:11.856589300+00:00
-- finished_at: 2025-12-23T18:24:11.944822600+00:00
-- elapsed: 88ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c13f70-0103-53b2-0004-95cb0001004e
-- desc: list_relations_in_parallel
SHOW OBJECTS IN SCHEMA "ANALYTICS"."DBT_AYAJNIK" LIMIT 10000;
-- created_at: 2025-12-23T18:24:12.899275900+00:00
-- finished_at: 2025-12-23T18:24:12.972979+00:00
-- elapsed: 73ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.fact_orders
-- query_id: 01c13f70-0103-53b2-0004-95cb00010052
-- desc: Get table schema
describe table "ANALYTICS"."DBT_AYAJNIK"."FACT_ORDERS";
-- created_at: 2025-12-23T18:24:13.630271600+00:00
-- finished_at: 2025-12-23T18:24:13.855288900+00:00
-- elapsed: 225ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: not available
-- desc: dbt run query
select * from (

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

order by order_date desc) limit 1000;
