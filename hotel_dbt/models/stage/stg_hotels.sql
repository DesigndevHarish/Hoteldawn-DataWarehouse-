select 
trim(hotel_id) as hotel_id,
initcap(trim(hotel_name)) as hotel_name,
initcap(trim(hotel_chain)) as hotel_chain,
initcap(trim(city)) as city,
initcap(trim(state)) as state,
initcap(trim(country)) as country,
try_to_decimal(star_rating, 10, 1) as star_rating,
try_to_date(opened_date) as opened_date,
upper(trim(status)) as hotel_status

from {{ source('bronze', 'hotels') }}