{% set raw_source = 'iceberg' if target.name == 'test' else 'postgres' %}

with source as (

    select *
    from {{ source(raw_source, 'raw_customers') }}

),

renamed as (

    select
        id as customer_id,
        first_name,
        last_name
    from source

)

select *
from renamed