WITH hotel_rooms AS (

    SELECT
        dr.room_id,
        dr.room_number,
        dr.hotel_id,
        dh.hotel_name,
        dr.room_type,
        dr.status AS room_status

    FROM {{ ref('dim_rooms') }} dr

    INNER JOIN {{ ref('dim_hotels') }} dh
        ON dr.hotel_id = dh.hotel_id

    WHERE dh.hotel_status = 'OPEN'
),


room_calendar AS (

    SELECT
        hr.room_id,
        hr.room_number,
        hr.hotel_id,
        hr.hotel_name,
        hr.room_type,
        hr.room_status,
        c.calendar_date

    FROM hotel_rooms hr

    CROSS JOIN {{ ref('dim_calendar') }} c

    WHERE hr.room_status IN ('AVAILABLE', 'OCCUPIED')
),



room_operable_days AS (

    SELECT
        room_id,
        COUNT(calendar_date) AS operable_room_nights

    FROM room_calendar

    GROUP BY room_id
),



room_revenue AS (

    SELECT
        fb.room_id,

        COUNT(fb.booking_id) AS total_bookings,

        SUM(fb.billable_nights) AS booked_room_nights,

        ROUND(
            SUM(fb.final_amount_inr),
            2
        ) AS total_revenue_inr,

        ROUND(
            AVG(fb.price_per_night),
            2
        ) AS average_price_per_night

    FROM {{ ref('fact_bookings') }} fb

    WHERE fb.booking_status IN ('CONFIRMED', 'COMPLETED')

    GROUP BY fb.room_id
)

SELECT
    hr.room_id,
    hr.room_number,
    hr.hotel_id,
    hr.hotel_name,
    hr.room_type,
    hr.room_status,

    COALESCE(rr.total_bookings, 0)
        AS total_bookings,

    COALESCE(rr.booked_room_nights, 0)
        AS booked_room_nights,

    COALESCE(rod.operable_room_nights, 0)
        AS operable_room_nights,

    COALESCE(rr.total_revenue_inr, 0)
        AS total_revenue_inr,

    COALESCE(rr.average_price_per_night, 0)
        AS average_price_per_night,

    ROUND(
        COALESCE(rr.booked_room_nights, 0)
        / NULLIF(rod.operable_room_nights, 0)
        * 100,
        2
    ) AS occupancy_percentage,

    ROUND(
        COALESCE(rr.total_revenue_inr, 0)
        / NULLIF(rod.operable_room_nights, 0),
        2
    ) AS revenue_per_available_room_night

FROM hotel_rooms hr

LEFT JOIN room_revenue rr
    ON hr.room_id = rr.room_id

LEFT JOIN room_operable_days rod
    ON hr.room_id = rod.room_id

ORDER BY
    hr.hotel_id,
    total_revenue_inr DESC