-- created_at: 2025-12-20T17:56:37.227484900+00:00
-- finished_at: 2025-12-20T17:56:37.310604100+00:00
-- elapsed: 83ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c12e74-0103-4c24-0000-000495cbc135
-- desc: Get table schema
describe table "ANALYTICS"."DBT_AYAJNIK"."STG_STRIPE__PAYMENT";
-- created_at: 2025-12-20T17:56:38.205676100+00:00
-- finished_at: 2025-12-20T17:56:39.080690300+00:00
-- elapsed: 875ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.jaffle_shop.assert_stg__stripe_payment.549adc1a87
-- query_id: 01c12e74-0103-4c24-0000-000495cbc139
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
