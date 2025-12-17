-- created_at: 2025-12-17T22:01:52.459741500+00:00
-- finished_at: 2025-12-17T22:01:52.666639700+00:00
-- elapsed: 206ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c11e89-0103-496b-0000-000495cb5319
-- desc: execute adapter call
show terse schemas in database analytics
    limit 10000
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","connection_name":""} */;
-- created_at: 2025-12-17T22:01:52.680002700+00:00
-- finished_at: 2025-12-17T22:01:52.772275200+00:00
-- elapsed: 92ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c11e89-0103-496b-0000-000495cb531d
-- desc: execute adapter call
create schema if not exists analytics.dbt_ayajnik
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","connection_name":""} */;
-- created_at: 2025-12-17T22:01:53.153656700+00:00
-- finished_at: 2025-12-17T22:01:53.222387+00:00
-- elapsed: 68ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.customers
-- query_id: 01c11e89-0103-496b-0000-000495cb5321
-- desc: Get table schema
describe table "RAW"."JAFFLE_SHOP"."CUSTOMERS";
-- created_at: 2025-12-17T22:01:53.257386700+00:00
-- finished_at: 2025-12-17T22:01:53.343185500+00:00
-- elapsed: 85ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.customers
-- query_id: 01c11e89-0103-496b-0000-000495cb5325
-- desc: Get table schema
describe table "RAW"."JAFFLE_SHOP"."ORDERS";
-- created_at: 2025-12-17T22:01:53.973513200+00:00
-- finished_at: 2025-12-17T22:01:54.050398100+00:00
-- elapsed: 76ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.customers
-- query_id: 01c11e89-0103-496b-0000-000495cb5329
-- desc: get_relation > list_relations call
SHOW OBJECTS IN SCHEMA "ANALYTICS"."DBT_AYAJNIK" LIMIT 10000;
-- created_at: 2025-12-17T22:01:54.089679700+00:00
-- finished_at: 2025-12-17T22:01:54.506342700+00:00
-- elapsed: 416ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.customers
-- query_id: 01c11e89-0103-496b-0000-000495cb532d
-- desc: execute adapter call
create or replace   view analytics.dbt_ayajnik.customers
  
   as (
    with customers as (

    select
        id as customer_id,
        first_name,
        last_name

    from raw.jaffle_shop.customers

),

orders as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from raw.jaffle_shop.orders

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
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","node_id":"model.jaffle_shop.customers"} */;
