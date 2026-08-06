select 
trim(booking_id) as booking_id,
trim(customer_id) as customer_id,
trim(room_id) as room_id,
trim(hotel_id) as hotel_id,
trim(promotion_id) as promotion_id,

try_to_date(booking_date) as booking_date,
try_to_date(check_in_date) as check_in_date,
try_to_date(check_out_date) as check_out_date,

try_to_number(adults) as adults,
try_to_number(children) as children,

upper(trim(booking_channel)) as booking_channel,
upper(trim(booking_status)) as booking_status,
upper(trim(currency)) as currency,

try_to_decimal(amount, 10, 2) as amount,
try_to_decimal(discount_percentage, 10, 2) as discount_percentage,
try_to_decimal(discount_amount, 10, 2) as discount_amount,
try_to_decimal(tax_amount, 10, 2) as tax_amount,
try_to_decimal(final_amount, 10, 2) as final_amount,

try_to_timestamp(created_timestamp) as created_at,
try_to_timestamp(updated_timestamp) as updated_at

from {{ source('bronze', 'bookings') }}