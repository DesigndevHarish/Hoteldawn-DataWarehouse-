select
trim(review_id) as review_id,
trim(customer_id) as customer_id,
trim(booking_id) as booking_id,
trim(hotel_id) as hotel_id,

try_to_decimal(rating, 10, 2) as rating,
initcap(trim(review_title)) as feedback_title,
trim(review_text) as feedback_description,
try_to_date(review_date) as review_date,
upper(trim(sentiment)) as sentiment


from {{ source('bronze', 'reviews') }}