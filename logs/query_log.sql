-- created_at: 2025-12-18T01:24:36.465934400+00:00
-- finished_at: 2025-12-18T01:24:36.569519900+00:00
-- elapsed: 103ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c11f54-0103-496b-0000-000495cb5929
-- desc: execute adapter call
show terse schemas in database analytics
    limit 10000
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","connection_name":""} */;
-- created_at: 2025-12-18T01:24:36.997714900+00:00
-- finished_at: 2025-12-18T01:24:37.059381500+00:00
-- elapsed: 61ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__orders
-- query_id: 01c11f54-0103-496b-0000-000495cb592d
-- desc: Get table schema
describe table "RAW"."JAFFLE_SHOP"."ORDERS";
-- created_at: 2025-12-18T01:24:37.276598100+00:00
-- finished_at: 2025-12-18T01:24:37.338766700+00:00
-- elapsed: 62ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__customers
-- query_id: 01c11f54-0103-496b-0000-000495cb5931
-- desc: Get table schema
describe table "RAW"."JAFFLE_SHOP"."CUSTOMERS";
-- created_at: 2025-12-18T01:24:37.720041300+00:00
-- finished_at: 2025-12-18T01:24:37.810466300+00:00
-- elapsed: 90ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__orders
-- query_id: 01c11f54-0103-496b-0000-000495cb5935
-- desc: get_relation > list_relations call
SHOW OBJECTS IN SCHEMA "ANALYTICS"."DBT_AYAJNIK" LIMIT 10000;
-- created_at: 2025-12-18T01:24:37.835913100+00:00
-- finished_at: 2025-12-18T01:24:38.040119700+00:00
-- elapsed: 204ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__orders
-- query_id: 01c11f54-0103-496b-0000-000495cb5939
-- desc: execute adapter call
drop table if exists ANALYTICS.DBT_AYAJNIK.STG_JAFFLE_SHOP__ORDERS cascade
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","node_id":"model.jaffle_shop.stg_jaffle_shop__orders"} */;
-- created_at: 2025-12-18T01:24:38.051518+00:00
-- finished_at: 2025-12-18T01:24:38.219461600+00:00
-- elapsed: 167ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__orders
-- query_id: 01c11f54-0103-496b-0000-000495cb593d
-- desc: execute adapter call
create or replace   view analytics.dbt_ayajnik.stg_jaffle_shop__orders
  
   as (
    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from raw.jaffle_shop.orders
  )
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","node_id":"model.jaffle_shop.stg_jaffle_shop__orders"} */;
-- created_at: 2025-12-18T01:24:38.104026500+00:00
-- finished_at: 2025-12-18T01:24:38.258784200+00:00
-- elapsed: 154ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__customers
-- query_id: 01c11f54-0103-496b-0000-000495cb5941
-- desc: execute adapter call
drop table if exists ANALYTICS.DBT_AYAJNIK.STG_JAFFLE_SHOP__CUSTOMERS cascade
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","node_id":"model.jaffle_shop.stg_jaffle_shop__customers"} */;
-- created_at: 2025-12-18T01:24:38.280036100+00:00
-- finished_at: 2025-12-18T01:24:38.594365300+00:00
-- elapsed: 314ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__customers
-- query_id: 01c11f54-0103-496b-0000-000495cb5945
-- desc: execute adapter call
create or replace   view analytics.dbt_ayajnik.stg_jaffle_shop__customers
  
   as (
        select
        id as customer_id,
        first_name,
        last_name

    from raw.jaffle_shop.customers
  )
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","node_id":"model.jaffle_shop.stg_jaffle_shop__customers"} */;
-- created_at: 2025-12-18T01:24:38.629041700+00:00
-- finished_at: 2025-12-18T01:24:40.284700300+00:00
-- elapsed: 1.7s
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.dim_customers
-- query_id: 01c11f54-0103-496b-0000-000495cb5949
-- desc: execute adapter call
create or replace transient  table analytics.dbt_ayajnik.dim_customers
    
    
    
    as (

with customers as (

select * from analytics.dbt_ayajnik.stg_jaffle_shop__customers

),

orders as (

    select * from analytics.dbt_ayajnik.stg_jaffle_shop__orders

),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders using (customer_id)

)

select * from final
    )

/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","node_id":"model.jaffle_shop.dim_customers"} */;
