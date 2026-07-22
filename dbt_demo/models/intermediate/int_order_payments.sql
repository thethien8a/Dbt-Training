{% set payment_methods = [
    'credit_card',
    'coupon',
    'bank_transfer',
    'gift_card'
] %}

with payments as (

    select *
    from {{ ref('stg_payments') }}

),

aggregated as (

    select
        order_id,

        count(*) as payment_count,

        {% for payment_method in payment_methods %}
        {{ sum_payment_amount(payment_method) }}
            as {{ payment_method }}_amount_cents,
        {% endfor %}

        sum(amount_cents) as total_amount_cents

    from payments
    group by order_id

)

select *
from aggregated
