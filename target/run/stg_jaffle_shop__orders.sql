
  
    

create or replace transient  table analytics.dbt_ayajnik.stg_jaffle_shop__orders
    
    
    
    as (select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from raw.jaffle_shop.orders
    )
;


  