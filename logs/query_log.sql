-- created_at: 2025-12-18T01:13:36.701285100+00:00
-- finished_at: 2025-12-18T01:13:36.788620500+00:00
-- elapsed: 87ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c11f49-0103-496b-0000-000495cb5829
-- desc: execute adapter call
show terse schemas in database analytics
    limit 10000
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","connection_name":""} */;
-- created_at: 2025-12-18T01:13:37.396246500+00:00
-- finished_at: 2025-12-18T01:13:37.488143400+00:00
-- elapsed: 91ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__customers
-- query_id: 01c11f49-0103-496b-0000-000495cb582d
-- desc: Get table schema
describe table "RAW"."JAFFLE_SHOP"."CUSTOMERS";
-- created_at: 2025-12-18T01:13:37.659579100+00:00
-- finished_at: 2025-12-18T01:13:37.940944500+00:00
-- elapsed: 281ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__orders
-- query_id: 01c11f49-0103-496b-0000-000495cb5831
-- desc: Get table schema
describe table "RAW"."JAFFLE_SHOP"."ORDERS";
-- created_at: 2025-12-18T01:13:38.416569+00:00
-- finished_at: 2025-12-18T01:13:38.507212400+00:00
-- elapsed: 90ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__customers
-- query_id: 01c11f49-0103-496b-0000-000495cb5835
-- desc: get_relation > list_relations call
SHOW OBJECTS IN SCHEMA "ANALYTICS"."DBT_AYAJNIK" LIMIT 10000;
-- created_at: 2025-12-18T01:13:38.692168600+00:00
-- finished_at: 2025-12-18T01:13:38.771652+00:00
-- elapsed: 79ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__orders
-- query_id: 01c11f49-0103-496b-0000-000495cb583d
-- desc: get_relation > list_relations call
SHOW OBJECTS IN SCHEMA "ANALYTICS"."DBT_AYAJNIK" LIMIT 10000;
-- created_at: 2025-12-18T01:13:38.523952600+00:00
-- finished_at: 2025-12-18T01:13:40.094447300+00:00
-- elapsed: 1.6s
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__customers
-- query_id: 01c11f49-0103-496b-0000-000495cb5839
-- desc: execute adapter call
create or replace transient  table analytics.dbt_ayajnik.stg_jaffle_shop__customers
    
    
    
    as (    select
        id as customer_id,
        first_name,
        last_name

    from raw.jaffle_shop.customers
    )

/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","node_id":"model.jaffle_shop.stg_jaffle_shop__customers"} */;
-- created_at: 2025-12-18T01:13:38.785589100+00:00
-- finished_at: 2025-12-18T01:13:40.280059700+00:00
-- elapsed: 1.5s
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__orders
-- query_id: 01c11f49-0103-496b-0000-000495cb5841
-- desc: execute adapter call
create or replace transient  table analytics.dbt_ayajnik.stg_jaffle_shop__orders
    
    
    
    as (select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from raw.jaffle_shop.orders
    )

/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","node_id":"model.jaffle_shop.stg_jaffle_shop__orders"} */;
-- created_at: 2025-12-18T01:13:40.329850800+00:00
-- finished_at: 2025-12-18T01:13:40.515171300+00:00
-- elapsed: 185ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.customers
-- query_id: 01c11f49-0103-496b-0000-000495cb5845
-- desc: execute adapter call
create or replace   view analytics.dbt_ayajnik.customers
  
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
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","node_id":"model.jaffle_shop.customers"} */;
