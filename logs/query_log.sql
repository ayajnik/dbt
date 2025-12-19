-- created_at: 2025-12-19T20:40:11.595305500+00:00
-- finished_at: 2025-12-19T20:40:12.688392300+00:00
-- elapsed: 1.1s
-- outcome: success
-- dialect: snowflake
-- node_id: source.jaffle_shop.jaffle_shop.orders
-- query_id: 01c12978-0103-4da3-0000-000495cbb061
-- desc: execute adapter call
select
      max(_etl_loaded_at) as max_loaded_at,
      convert_timezone('UTC', current_timestamp()) as snapshotted_at
    from raw.jaffle_shop.orders
/* {"app":"dbt","dbt_version":"2.0.0","profile_name":"default","target_name":"dev","node_id":"source.jaffle_shop.jaffle_shop.orders"} */;
