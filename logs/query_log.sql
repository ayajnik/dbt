-- created_at: 2025-12-20T18:17:26.216451400+00:00
-- finished_at: 2025-12-20T18:17:26.320991+00:00
-- elapsed: 104ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c12e89-0103-4c24-0000-000495cbc145
-- desc: execute adapter call
show terse schemas in database analytics
    limit 10000
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-20T18:17:26.711194500+00:00
-- finished_at: 2025-12-20T18:17:26.804688+00:00
-- elapsed: 93ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.jaffle_shop.source_not_null_jaffle_shop_customers_id.2b0a5f29a9
-- query_id: 01c12e89-0103-4c24-0000-000495cbc149
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select id
from raw.jaffle_shop.customers
where id is null



  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.jaffle_shop.source_not_null_jaffle_shop_customers_id.2b0a5f29a9", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-20T18:17:26.956492600+00:00
-- finished_at: 2025-12-20T18:17:27.068518600+00:00
-- elapsed: 112ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_stripe__payment
-- query_id: 01c12e89-0103-4c24-0000-000495cbc14d
-- desc: get_relation > list_relations call
SHOW OBJECTS IN SCHEMA "ANALYTICS"."DBT_AYAJNIK" LIMIT 10000;
-- created_at: 2025-12-20T18:17:27.091626400+00:00
-- finished_at: 2025-12-20T18:17:27.268281200+00:00
-- elapsed: 176ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_stripe__payment
-- query_id: 01c12e89-0103-4c24-0000-000495cbc151
-- desc: execute adapter call
create or replace   view analytics.dbt_ayajnik.stg_stripe__payment
  
   as (
    select
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    -- amount is stored in cents, convert it to dollars
    amount / 100 as amount,
    created as created_at
from raw.stripe.payment
  )
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.jaffle_shop.stg_stripe__payment", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-20T18:17:27.218551100+00:00
-- finished_at: 2025-12-20T18:17:27.313095100+00:00
-- elapsed: 94ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.jaffle_shop.source_unique_jaffle_shop_customers_id.aaddf56471
-- query_id: 01c12e89-0103-4c24-0000-000495cbc155
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    id as unique_field,
    count(*) as n_records

from raw.jaffle_shop.customers
where id is not null
group by id
having count(*) > 1



  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.jaffle_shop.source_unique_jaffle_shop_customers_id.aaddf56471", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-20T18:17:27.474142200+00:00
-- finished_at: 2025-12-20T18:17:27.567818500+00:00
-- elapsed: 93ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__orders
-- query_id: 01c12e89-0103-4c24-0000-000495cbc159
-- desc: get_relation > list_relations call
SHOW OBJECTS IN SCHEMA "ANALYTICS"."DBT_AYAJNIK" LIMIT 10000;
-- created_at: 2025-12-20T18:17:27.590540+00:00
-- finished_at: 2025-12-20T18:17:27.875090600+00:00
-- elapsed: 284ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__orders
-- query_id: 01c12e89-0103-4c24-0000-000495cbc15d
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
-- created_at: 2025-12-20T18:17:27.761229800+00:00
-- finished_at: 2025-12-20T18:17:28.074849500+00:00
-- elapsed: 313ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.jaffle_shop.assert_stg__stripe_payment.549adc1a87
-- query_id: 01c12e89-0103-4c24-0000-000495cbc161
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  SELECT
  order_id,
  sum(amount) AS total_amount
FROM analytics.dbt_ayajnik.stg_stripe__payment
GROUP BY order_id
HAVING total_amount < 0
  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.jaffle_shop.assert_stg__stripe_payment.549adc1a87", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-20T18:17:27.993847300+00:00
-- finished_at: 2025-12-20T18:17:28.195959900+00:00
-- elapsed: 202ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.stg_jaffle_shop__customers
-- query_id: 01c12e89-0103-4c24-0000-000495cbc165
-- desc: execute adapter call
create or replace   view analytics.dbt_ayajnik.stg_jaffle_shop__customers
  
   as (
        select
        id as customer_id,
        first_name,
        last_name

    from raw.jaffle_shop.customers
  )
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.jaffle_shop.stg_jaffle_shop__customers", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-20T18:17:28.482987300+00:00
-- finished_at: 2025-12-20T18:17:28.639679800+00:00
-- elapsed: 156ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.jaffle_shop.not_null_stg_jaffle_shop__orders_order_id.f4fccc4c71
-- query_id: 01c12e89-0103-4c24-0000-000495cbc16d
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_id
from analytics.dbt_ayajnik.stg_jaffle_shop__orders
where order_id is null



  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.jaffle_shop.not_null_stg_jaffle_shop__orders_order_id.f4fccc4c71", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-20T18:17:28.235820100+00:00
-- finished_at: 2025-12-20T18:17:28.726342900+00:00
-- elapsed: 490ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.jaffle_shop.accepted_values_stg_jaffle_sho_8d0cd9c77228920edeb7f4a53788bf13.94b499f2bd
-- query_id: 01c12e89-0103-4c24-0000-000495cbc169
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        status as value_field,
        count(*) as n_records

    from analytics.dbt_ayajnik.stg_jaffle_shop__orders
    group by status

)

select *
from all_values
where value_field not in (
    'placed','shipped','completed','returned','return_pending'
)



  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.jaffle_shop.accepted_values_stg_jaffle_sho_8d0cd9c77228920edeb7f4a53788bf13.94b499f2bd", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-20T18:17:28.735416800+00:00
-- finished_at: 2025-12-20T18:17:28.902337100+00:00
-- elapsed: 166ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.jaffle_shop.unique_stg_jaffle_shop__orders_order_id.96447b5705
-- query_id: 01c12e89-0103-4c24-0000-000495cbc171
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    order_id as unique_field,
    count(*) as n_records

from analytics.dbt_ayajnik.stg_jaffle_shop__orders
where order_id is not null
group by order_id
having count(*) > 1



  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.jaffle_shop.unique_stg_jaffle_shop__orders_order_id.96447b5705", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-20T18:17:28.960595800+00:00
-- finished_at: 2025-12-20T18:17:29.548868300+00:00
-- elapsed: 588ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.jaffle_shop.relationships_stg_jaffle_shop__0dd647f89c34966822c5f4faca99b672.4786670766
-- query_id: 01c12e89-0103-4c24-0000-000495cbc175
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with child as (
    select customer_id as from_field
    from analytics.dbt_ayajnik.stg_jaffle_shop__orders
    where customer_id is not null
),

parent as (
    select customer_id as to_field
    from analytics.dbt_ayajnik.stg_jaffle_shop__orders
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.jaffle_shop.relationships_stg_jaffle_shop__0dd647f89c34966822c5f4faca99b672.4786670766", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-20T18:17:29.636950100+00:00
-- finished_at: 2025-12-20T18:17:29.820422200+00:00
-- elapsed: 183ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.jaffle_shop.unique_stg_jaffle_shop__customers_customer_id.bbddff99e3
-- query_id: 01c12e89-0103-4c24-0000-000495cbc179
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    customer_id as unique_field,
    count(*) as n_records

from analytics.dbt_ayajnik.stg_jaffle_shop__customers
where customer_id is not null
group by customer_id
having count(*) > 1



  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.jaffle_shop.unique_stg_jaffle_shop__customers_customer_id.bbddff99e3", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-20T18:17:29.905024800+00:00
-- finished_at: 2025-12-20T18:17:30.045330700+00:00
-- elapsed: 140ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.jaffle_shop.not_null_stg_jaffle_shop__customers_customer_id.4705beb1d4
-- query_id: 01c12e89-0103-4c24-0000-000495cbc17d
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select customer_id
from analytics.dbt_ayajnik.stg_jaffle_shop__customers
where customer_id is null



  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.jaffle_shop.not_null_stg_jaffle_shop__customers_customer_id.4705beb1d4", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-20T18:17:30.396204+00:00
-- finished_at: 2025-12-20T18:17:31.606371800+00:00
-- elapsed: 1.2s
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.dim_customers
-- query_id: 01c12e89-0103-4c24-0000-000495cbc185
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

/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.jaffle_shop.dim_customers", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-20T18:17:30.142573900+00:00
-- finished_at: 2025-12-20T18:17:31.613825900+00:00
-- elapsed: 1.5s
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.fact_orders
-- query_id: 01c12e89-0103-4c24-0000-000495cbc181
-- desc: execute adapter call
create or replace transient  table analytics.dbt_ayajnik.fact_orders
    
    
    
    as (with orders as  (
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
    )

/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.jaffle_shop.fact_orders", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-20T18:17:32.025236200+00:00
-- finished_at: 2025-12-20T18:17:32.909006700+00:00
-- elapsed: 883ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.fct_customers
-- query_id: 01c12e89-0103-4c24-0000-000495cbc189
-- desc: execute adapter call
create or replace transient  table analytics.dbt_ayajnik.fct_customers
    
    
    
    as (with customers as (
    select * from analytics.dbt_ayajnik.stg_jaffle_shop__customers
),
orders as (
    select * from analytics.dbt_ayajnik.fact_orders
),
customer_orders as (
    select
        customer_id,
        min (order_date) as first_order_date,
        max (order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(amount) as lifetime_value
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
        coalesce (customer_orders.number_of_orders, 0) as number_of_orders,
        customer_orders.lifetime_value
    from customers
    left join customer_orders using (customer_id)
)
select * from final
    )

/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.jaffle_shop.fct_customers", "profile_name": "default", "target_name": "dev"} */;
