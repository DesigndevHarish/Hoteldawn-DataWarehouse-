select  
trim(service_id) as service_id,
trim(booking_id) as booking_id,
trim(hotel_id) as hotel_id,
trim(employee_id) as employee_id,

initcap(trim(service_name)) as service_name,
try_to_date(service_date) as service_date,
try_to_number(quantity) as quantity,
try_to_decimal(unit_price, 10, 2) as unit_price,
try_to_decimal(total_price, 10, 2) as total_price

from {{ source('bronze', 'room_services') }}