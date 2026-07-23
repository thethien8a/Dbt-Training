{% macro cents_to_amount(column_name) %}
    cast(
        coalesce(
            {{ column_name }},
            0
        ) / 100.0
        as numeric(18, 2)
    )
{% endmacro %}
