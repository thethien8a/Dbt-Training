with orders as (

    select *
    from {{ ref('stg_orders') }}

),

order_payments as (

    select *
    from {{ ref('int_order_payments') }}

),

joined as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.order_status,

        coalesce(
            order_payments.payment_count,
            0
        ) as payment_count,

        {{ cents_to_amount('order_payments.credit_card_amount_cents') }}
            as credit_card_amount,

        {{ cents_to_amount('order_payments.coupon_amount_cents') }}
            as coupon_amount,

        {{ cents_to_amount('order_payments.bank_transfer_amount_cents') }}
            as bank_transfer_amount,

        {{ cents_to_amount('order_payments.gift_card_amount_cents') }}
            as gift_card_amount,

        {{ cents_to_amount('order_payments.total_amount_cents') }}
            as total_amount

    from orders
    left join order_payments
        on orders.order_id = order_payments.order_id

)

select *
from joined
