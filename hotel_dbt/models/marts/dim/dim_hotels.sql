with hotels as ( select * from {{ ref('stg_hotels') }} )

select
    hotel_id,
    hotel_name,
    hotel_chain,
    city,
    state,
    country,
    star_rating,
    opened_date,
    hotel_status
from hotels