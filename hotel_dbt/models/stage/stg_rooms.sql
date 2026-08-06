select 

trim(room_id) as room_id,
trim(hotel_id) as hotel_id,
trim(room_number) as room_number,
initcap(trim(room_type)) as room_type,
try_to_number(capacity) as capacity,
try_to_decimal(base_price, 10, 2) as base_price,
try_to_number(floor) as floor_number,
upper(trim(availability)) as status

from {{ source('bronze', 'rooms') }}