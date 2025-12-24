-- created_at: 2025-12-24T16:11:56.651718400+00:00
-- finished_at: 2025-12-24T16:11:56.750850200+00:00
-- elapsed: 99ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c1448b-0103-5557-0004-95cb00012072
-- desc: execute adapter call
show terse schemas in database analytics
    limit 10000
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-24T16:11:56.751780+00:00
-- finished_at: 2025-12-24T16:11:56.849846200+00:00
-- elapsed: 98ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c1448b-0103-5557-0004-95cb00012076
-- desc: execute adapter call
create schema if not exists analytics.dbt_ayajnik_snapshots
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-24T16:11:57.242934700+00:00
-- finished_at: 2025-12-24T16:11:57.321990300+00:00
-- elapsed: 79ms
-- outcome: success
-- dialect: snowflake
-- node_id: snapshot.jaffle_shop.orders_snapshot
-- query_id: 01c1448b-0103-5557-0004-95cb0001207a
-- desc: get_relation > list_relations call
SHOW OBJECTS IN SCHEMA "ANALYTICS"."DBT_AYAJNIK_SNAPSHOTS" LIMIT 10000;
-- created_at: 2025-12-24T16:11:57.337384300+00:00
-- finished_at: 2025-12-24T16:11:57.464923200+00:00
-- elapsed: 127ms
-- outcome: success
-- dialect: snowflake
-- node_id: snapshot.jaffle_shop.orders_snapshot
-- query_id: 01c1448b-0103-5557-0004-95cb0001207e
-- desc: get_column_schema_from_query adapter call
select * from (
        
    

    select *,
        md5(coalesce(cast(id as varchar ), '')
         || '|' || coalesce(cast(to_timestamp_ntz(convert_timezone('UTC', current_timestamp())) as varchar ), '')
        ) as dbt_scd_id,
        to_timestamp_ntz(convert_timezone('UTC', current_timestamp())) as dbt_updated_at,
        to_timestamp_ntz(convert_timezone('UTC', current_timestamp())) as dbt_valid_from,
        
  
  coalesce(nullif(to_timestamp_ntz(convert_timezone('UTC', current_timestamp())), to_timestamp_ntz(convert_timezone('UTC', current_timestamp()))), null)
  as dbt_valid_to
from (
        select * from raw.jaffle_shop.orders
    ) sbq



    ) as __dbt_sbq
    where false
    limit 0

/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "snapshot.jaffle_shop.orders_snapshot", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-24T16:11:57.474008200+00:00
-- finished_at: 2025-12-24T16:11:57.536642300+00:00
-- elapsed: 62ms
-- outcome: success
-- dialect: snowflake
-- node_id: snapshot.jaffle_shop.orders_snapshot
-- query_id: 01c1448b-0103-5557-0004-95cb00012082
-- desc: get_column_schema_from_query adapter call
select * from (
        select to_timestamp_ntz(convert_timezone('UTC', current_timestamp())) as dbt_snapshot_time
    ) as __dbt_sbq
    where false
    limit 0

/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "snapshot.jaffle_shop.orders_snapshot", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2025-12-24T16:11:57.545801700+00:00
-- finished_at: 2025-12-24T16:11:58.575648400+00:00
-- elapsed: 1.0s
-- outcome: success
-- dialect: snowflake
-- node_id: snapshot.jaffle_shop.orders_snapshot
-- query_id: 01c1448b-0103-5557-0004-95cb00012086
-- desc: execute adapter call
create or replace transient  table analytics.dbt_ayajnik_snapshots.orders_snapshot
    
    
    
    as (
    

    select *,
        md5(coalesce(cast(id as varchar ), '')
         || '|' || coalesce(cast(to_timestamp_ntz(convert_timezone('UTC', current_timestamp())) as varchar ), '')
        ) as dbt_scd_id,
        to_timestamp_ntz(convert_timezone('UTC', current_timestamp())) as dbt_updated_at,
        to_timestamp_ntz(convert_timezone('UTC', current_timestamp())) as dbt_valid_from,
        
  
  coalesce(nullif(to_timestamp_ntz(convert_timezone('UTC', current_timestamp())), to_timestamp_ntz(convert_timezone('UTC', current_timestamp()))), null)
  as dbt_valid_to
from (
        select * from raw.jaffle_shop.orders
    ) sbq



    )

/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "snapshot.jaffle_shop.orders_snapshot", "profile_name": "default", "target_name": "dev"} */;
