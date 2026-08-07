with room_services as (
    select * from {{ ref('stg_room_services') }}
)

select 
    service_id,
    booking_id,
    hotel_id,
    employee_id,

    service_name,
    service_date,
    quantity,
    unit_price,
    total_price
from room_services