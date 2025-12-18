
  
    

create or replace transient  table analytics.dbt_ayajnik.stg_jaffle_shop__customers
    
    
    
    as (    select
        id as customer_id,
        first_name,
        last_name

    from raw.jaffle_shop.customers
    )
;


  