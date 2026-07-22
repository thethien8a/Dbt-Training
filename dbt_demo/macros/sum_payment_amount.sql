{% macro sum_payment_amount(payment_method) %}
    sum(
        case
            when payment_method = '{{ payment_method }}' then amount_cents
            else 0
        end
    )
{% endmacro %}
