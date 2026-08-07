with bookings as (
    select * from {{ ref('stg_bookings') }}
)

select
    booking_id,
    customer_id,
    hotel_id,
    room_id,
    promotion_id,

    booking_date,
    check_in_date,
    check_out_date,

    adults,
    children,

    booking_channel,
    booking_status,
    currency,

    amount,
    discount_percentage,
    discount_amount,
    tax_amount,
    final_amount,

    created_at,
    updated_at,
    
from bookings

    