-- created_at: 2025-12-24T17:20:47.379631200+00:00
-- finished_at: 2025-12-24T17:20:47.520167200+00:00
-- elapsed: 140ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c144d0-0103-5557-0004-95cb0001209a
-- desc: list_relations_in_parallel
SHOW OBJECTS IN SCHEMA "ANALYTICS"."DBT_AYAJNIK" LIMIT 10000;
-- created_at: 2025-12-24T17:20:48.628340500+00:00
-- finished_at: 2025-12-24T17:20:48.703784700+00:00
-- elapsed: 75ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c144d0-0103-5557-0004-95cb0001209e
-- desc: execute adapter call
show terse schemas in database analytics
    limit 10000
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-24T17:20:49.246487600+00:00
-- finished_at: 2025-12-24T17:20:49.445679800+00:00
-- elapsed: 199ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_stripe__payment
-- query_id: 01c144d0-0103-5557-0004-95cb000120a2
-- desc: execute adapter call
create or replace   view analytics.dbt_ayajnik.stg_stripe__payment
  
   as (
    select
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    -- amount is stored in cents, convert it to dollars
    round( amount * 1.0 /100, 2 ) as amount,
    --
    -- 
    created as created_at
from raw.stripe.payment
  )
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.jaffle_shop.stg_stripe__payment", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-24T17:20:49.479752300+00:00
-- finished_at: 2025-12-24T17:20:49.651857200+00:00
-- elapsed: 172ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__orders
-- query_id: 01c144d0-0103-5557-0004-95cb000120a6
-- desc: execute adapter call
create or replace   view analytics.dbt_ayajnik.stg_jaffle_shop__orders
  
   as (
    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status, 
        _etl_loaded_at
    from raw.jaffle_shop.orders
  )
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.jaffle_shop.stg_jaffle_shop__orders", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-24T17:20:49.709152300+00:00
-- finished_at: 2025-12-24T17:20:49.777846700+00:00
-- elapsed: 68ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.fact_orders
-- query_id: 01c144d0-0103-5557-0004-95cb000120aa
-- desc: Get table schema
describe table "ANALYTICS"."DBT_AYAJNIK"."FACT_ORDERS";
-- created_at: 2025-12-24T17:20:50.797927200+00:00
-- finished_at: 2025-12-24T17:20:51.110494200+00:00
-- elapsed: 312ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.fact_orders
-- query_id: 01c144d0-0103-5557-0004-95cb000120ae
-- desc: execute adapter call
create or replace  temporary view analytics.dbt_ayajnik.fact_orders__dbt_tmp
  
   as (
    

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
  )
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.jaffle_shop.fact_orders", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-24T17:20:51.118934300+00:00
-- finished_at: 2025-12-24T17:20:51.278500400+00:00
-- elapsed: 159ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.fact_orders
-- query_id: 01c144d0-0103-5557-0004-95cb000120b2
-- desc: execute adapter call
describe table analytics.dbt_ayajnik.fact_orders__dbt_tmp
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.jaffle_shop.fact_orders", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-24T17:20:51.290634700+00:00
-- finished_at: 2025-12-24T17:20:51.416074800+00:00
-- elapsed: 125ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.fact_orders
-- query_id: 01c144d0-0103-5557-0004-95cb000120b6
-- desc: execute adapter call
describe table analytics.dbt_ayajnik.fact_orders
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.jaffle_shop.fact_orders", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-24T17:20:51.425127600+00:00
-- finished_at: 2025-12-24T17:20:51.490079700+00:00
-- elapsed: 64ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.fact_orders
-- query_id: 01c144d0-0103-5557-0004-95cb000120ba
-- desc: execute adapter call
describe table ANALYTICS.DBT_AYAJNIK.FACT_ORDERS
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.jaffle_shop.fact_orders", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-24T17:20:51.502766100+00:00
-- finished_at: 2025-12-24T17:20:51.596054100+00:00
-- elapsed: 93ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.fact_orders
-- query_id: 01c144d0-0103-5557-0004-95cb000120be
-- desc: execute adapter call
-- back compat for old kwarg name
  
  begin
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.jaffle_shop.fact_orders", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-24T17:20:51.596460900+00:00
-- finished_at: 2025-12-24T17:20:53.207892300+00:00
-- elapsed: 1.6s
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.fact_orders
-- query_id: 01c144d0-0103-5557-0004-95cb000120c2
-- desc: execute adapter call

    

        insert into analytics.dbt_ayajnik.fact_orders ("ORDER_ID", "CUSTOMER_ID", "ORDER_DATE", "AMOUNT")
        (
            select "ORDER_ID", "CUSTOMER_ID", "ORDER_DATE", "AMOUNT"
            from analytics.dbt_ayajnik.fact_orders__dbt_tmp
        )
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.jaffle_shop.fact_orders", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-24T17:20:53.209762+00:00
-- finished_at: 2025-12-24T17:20:53.463164200+00:00
-- elapsed: 253ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.fact_orders
-- query_id: 01c144d0-0103-5557-0004-95cb000120c6
-- desc: execute adapter call

    commit
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.jaffle_shop.fact_orders", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-24T17:20:53.465697+00:00
-- finished_at: 2025-12-24T17:20:53.782667600+00:00
-- elapsed: 316ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.fact_orders
-- query_id: 01c144d0-0103-5557-0004-95cb000120ca
-- desc: execute adapter call
drop view if exists analytics.dbt_ayajnik.fact_orders__dbt_tmp cascade
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.jaffle_shop.fact_orders", "profile_name": "default", "target_name": "dev"} */;
