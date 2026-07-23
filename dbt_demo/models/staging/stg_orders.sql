{% set raw_source = 'iceberg' if target.name == 'test' else 'postgres' %}

with source as (

    select *
    from {{ source(raw_source, 'raw_orders') }}

),

renamed as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        lower(trim(status)) as order_status
    from source

)

select *
from renamed