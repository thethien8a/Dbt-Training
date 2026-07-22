with payments as (

    select *
    from {{ ref('stg_payments') }}

),

aggregated as (

    select
        order_id,

        count(*) as payment_count,

        sum(
            case
                when payment_method = 'credit_card'
                    then amount_cents
                else 0
            end
        ) as credit_card_amount_cents,

        sum(
            case
                when payment_method = 'coupon'
                    then amount_cents
                else 0
            end
        ) as coupon_amount_cents,

        sum(
            case
                when payment_method = 'bank_transfer'
                    then amount_cents
                else 0
            end
        ) as bank_transfer_amount_cents,

        sum(
            case
                when payment_method = 'gift_card'
                    then amount_cents
                else 0
            end
        ) as gift_card_amount_cents,

        sum(amount_cents) as total_amount_cents

    from payments
    group by order_id

)

select *
from aggregated