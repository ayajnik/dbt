-- created_at: 2025-12-20T18:07:57.661653700+00:00
-- finished_at: 2025-12-20T18:07:58.810934900+00:00
-- elapsed: 1.1s
-- outcome: success
-- dialect: snowflake
-- node_id: test.jaffle_shop.source_not_null_jaffle_shop_customers_id.2b0a5f29a9
-- query_id: 01c12e7f-0103-4c24-0000-000495cbc13d
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
-- created_at: 2025-12-20T18:07:57.924393200+00:00
-- finished_at: 2025-12-20T18:07:58.848688300+00:00
-- elapsed: 924ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.jaffle_shop.source_unique_jaffle_shop_customers_id.aaddf56471
-- query_id: 01c12e7f-0103-4c24-0000-000495cbc141
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
