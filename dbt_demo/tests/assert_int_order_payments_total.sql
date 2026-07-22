-- Bây giờ ta cần test một quy tắc riêng:
-- Tổng tiền phải bằng tổng các cột payment method.
select *
from {{ ref('int_order_payments') }}
where total_amount_cents
    != credit_card_amount_cents
     + coupon_amount_cents
     + bank_transfer_amount_cents
     + gift_card_amount_cents