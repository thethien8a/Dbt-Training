{% set start_date = "cast('2023-01-01' as date)" %}
{% set end_date_exclusive = "cast('2025-01-02' as date)" %}

with date_spine as (

    {{ dbt_utils.date_spine(
        datepart='day',
        start_date=start_date,
        end_date=end_date_exclusive
    ) }}

),

date_attributes as (

    select
        cast(date_day as date) as date_day,
        cast(extract(year from date_day) as integer) as calendar_year,
        cast(extract(quarter from date_day) as integer) as calendar_quarter,
        cast(extract(month from date_day) as integer) as month_of_year,
        cast(extract(week from date_day) as integer) as week_of_year,
        cast(extract(day from date_day) as integer) as day_of_month,
        cast(extract(doy from date_day) as integer) as day_of_year
    from date_spine

),

final as (

    select
        calendar_year * 10000
            + month_of_year * 100
            + day_of_month as date_key,
        date_day,
        calendar_year,
        calendar_quarter,
        month_of_year,
        week_of_year,
        day_of_month,
        day_of_year
    from date_attributes

)

select *
from final
