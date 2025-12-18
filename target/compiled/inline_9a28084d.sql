select * from (
select * from analytics.dbt_ayajnik.stg_jaffle_shop__customers
) as __preview_sbq__ limit 1000