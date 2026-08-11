WITH room_inventory AS (

    SELECT
        dr.hotel_id,

        COUNT_IF(
            dr.status IN ('AVAILABLE', 'OCCUPIED')
        ) AS operable_rooms

    FROM {{ ref('dim_rooms') }} dr

    GROUP BY
        dr.hotel_id
),

calendar_months AS (

    SELECT
        DATE_TRUNC('month', calendar_date) AS revenue_month,

        COUNT(DISTINCT calendar_date) AS days_in_month

    FROM {{ ref('dim_calendar') }}

    GROUP BY
        DATE_TRUNC('month', calendar_date)
),

hotel_monthly_inventory AS (

    SELECT
        ri.hotel_id,
        cm.revenue_month,

        ri.operable_rooms,
        cm.days_in_month,

        ri.operable_rooms * cm.days_in_month
            AS available_room_nights

    FROM room_inventory ri

    CROSS JOIN calendar_months cm
),

monthly_bookings AS (

    SELECT
        fb.hotel_id,

        DATE_TRUNC(
            'month',
            fb.check_in_date
        ) AS revenue_month,

        SUM(fb.billable_nights)
            AS booked_room_nights,

        ROUND(
            SUM(fb.final_amount_inr),
            2
        ) AS monthly_revenue_inr

    FROM {{ ref('fact_bookings') }} fb

    WHERE fb.booking_status IN (
        'CONFIRMED',
        'COMPLETED'
    )

    GROUP BY
        fb.hotel_id,
        DATE_TRUNC(
            'month',
            fb.check_in_date
        )
),

hotel_occupancy AS (

    SELECT
        hmi.hotel_id,
        dh.hotel_name,
        dh.city,
        hmi.revenue_month,

        hmi.operable_rooms,
        hmi.days_in_month,
        hmi.available_room_nights,

        COALESCE(
            mb.booked_room_nights,
            0
        ) AS booked_room_nights,

        COALESCE(
            mb.monthly_revenue_inr,
            0
        ) AS monthly_revenue_inr

    FROM hotel_monthly_inventory hmi

    INNER JOIN {{ ref('dim_hotels') }} dh
        ON hmi.hotel_id = dh.hotel_id

    LEFT JOIN monthly_bookings mb
        ON hmi.hotel_id = mb.hotel_id
        AND hmi.revenue_month = mb.revenue_month

    WHERE dh.hotel_status = 'OPEN'
)


SELECT
    hotel_id,
    hotel_name,
    city,
    revenue_month,

    operable_rooms,
    days_in_month,

    available_room_nights,
    booked_room_nights,

    ROUND(
        booked_room_nights
        / NULLIF(available_room_nights, 0)
        * 100,
        2
    ) AS occupancy_percentage,

    monthly_revenue_inr,

    ROUND(
        monthly_revenue_inr
        / NULLIF(booked_room_nights, 0),
        2
    ) AS revenue_per_occupied_night

FROM hotel_occupancy

ORDER BY
    hotel_id,
    revenue_month DESC
