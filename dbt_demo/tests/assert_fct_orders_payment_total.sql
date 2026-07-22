select *
from {{ ref('fct_orders') }}
where total_amount
    != credit_card_amount
     + coupon_amount
     + bank_transfer_amount
     + gift_card_amount