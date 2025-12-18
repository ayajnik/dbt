select * from (
with customers as (

select * from analytics.dbt_ayajnik.stg_jaffle_shop__customers

)
SELECT * FROM CUSTOMERS
) as __preview_sbq__ limit 1000