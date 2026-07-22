with source as (

    select *
    from {{ source('postgres', 'raw_orders') }}

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