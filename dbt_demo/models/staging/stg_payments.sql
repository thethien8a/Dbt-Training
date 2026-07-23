{% set raw_source = 'iceberg' if target.name == 'test' else 'postgres' %}

with source as (

    select *
    from {{ source(raw_source, 'raw_payments') }}

),

renamed as (

    select
        id as payment_id,
        order_id,
        payment_method,
        amount as amount_cents
    from source

)

select *
from renamed