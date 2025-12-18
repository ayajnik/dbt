select * from (
select * from {{ ref('stg_jaffle_shop__customers') }}
) as __preview_sbq__ limit 1000