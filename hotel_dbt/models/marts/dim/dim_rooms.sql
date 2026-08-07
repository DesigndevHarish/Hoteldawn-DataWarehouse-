with rooms as (select * from {{ref('stg_rooms')}})

select
    room_id,
    hotel_id,
    room_number,
    room_type,
    capacity,
    base_price,
    floor_number,
    status
from rooms