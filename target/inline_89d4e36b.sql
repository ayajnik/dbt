select * from (
with customers as (

select * from {{ ref('stg_jaffle_shop__customers') }}

)
SELECT * FROM CUSTOMERS
) as __preview_sbq__ limit 1000