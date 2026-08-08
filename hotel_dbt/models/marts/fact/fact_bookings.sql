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

    datediff('day', check_in_date, check_out_date) as stay_duration,

    case
        when datediff('day', check_in_date, check_out_date) = 0 then 1
        when datediff('day', check_in_date, check_out_date) >0 
        then datediff('day', check_in_date, check_out_date)
        else  null
    end as billable_nights,

    adults + children as total_guests,


    abs(case
        when billable_nights > 0 then round(final_amount / billable_nights, 2)
        else  null
    end )as price_per_night,


    booking_channel,
    booking_status,
    currency,

    amount,
    discount_percentage,
    discount_amount,
    tax_amount,
    abs(final_amount) as final_amount,
    
    abs(case
        when currency = 'INR' then final_amount
        when currency = 'USD' then final_amount * 82.5
        when currency = 'EUR' then final_amount * 90.5
        when currency = 'GBP' then final_amount * 105.5
        when currency = 'AED' then final_amount * 22.5
        when currency = 'SGD' then final_amount * 60.5
        else null
    end ) as final_amount_inr,

    created_at,
    updated_at
    
from bookings

    