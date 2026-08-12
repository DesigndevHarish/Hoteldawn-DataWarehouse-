WITH hotel_revenue AS (

    SELECT
        fb.hotel_id,

        COUNT(fb.booking_id) AS total_bookings,

        SUM(fb.billable_nights) AS total_room_nights,

        ROUND(
            SUM(fb.final_amount_inr),
            2
        ) AS total_revenue_inr,

        ROUND(
            SUM(fb.final_amount_inr)
            / NULLIF(COUNT(fb.booking_id), 0),
            2
        ) AS average_booking_value,

        ROUND(
            SUM(fb.final_amount_inr)
            / NULLIF(SUM(fb.billable_nights), 0),
            2
        ) AS revenue_per_night,

        COUNT(DISTINCT fb.customer_id) AS unique_customers

    FROM {{ ref('fact_bookings') }} fb

    WHERE fb.booking_status IN ('CONFIRMED', 'COMPLETED')

    GROUP BY
        fb.hotel_id
),

hotel_rooms AS (

    SELECT
        dr.hotel_id,

        COUNT(dr.room_id) AS total_rooms

    FROM {{ ref('dim_rooms') }} dr

    WHERE dr.status IN ('AVAILABLE', 'OCCUPIED')

    GROUP BY
        dr.hotel_id
),

hotel_occupancy AS (

    SELECT
        hotel_id,

        SUM(booked_room_nights) AS booked_room_nights,

        SUM(operable_room_nights) AS operable_room_nights

    FROM {{ ref('room_performance_analysis') }}

    GROUP BY
        hotel_id
),

hotel_performance AS (

    SELECT
        dh.hotel_id,
        dh.hotel_name,
        dh.hotel_chain,
        dh.city,
        dh.star_rating,
        dh.hotel_status,
        dh.opened_date,

        COALESCE(hr.total_rooms, 0)
            AS total_rooms,

        COALESCE(hrev.total_bookings, 0)
            AS total_bookings,

        COALESCE(hrev.unique_customers, 0)
            AS unique_customers,

        COALESCE(hrev.total_room_nights, 0)
            AS total_room_nights,

        COALESCE(hrev.total_revenue_inr, 0)
            AS total_revenue_inr,

        COALESCE(hrev.average_booking_value, 0)
            AS average_booking_value,

        COALESCE(hrev.revenue_per_night, 0)
            AS revenue_per_night,

        COALESCE(ho.booked_room_nights, 0)
            AS booked_room_nights,

        COALESCE(ho.operable_room_nights, 0)
            AS operable_room_nights,

        ROUND(
            COALESCE(ho.booked_room_nights, 0)
            / NULLIF(
                COALESCE(ho.operable_room_nights, 0),
                0
            ) * 100,
            2
        ) AS occupancy_percentage,

        DATEDIFF(
            'year',
            dh.opened_date,
            CURRENT_DATE()
        ) AS hotel_age_years

    FROM {{ ref('dim_hotels') }} dh

    LEFT JOIN hotel_revenue hrev
        ON dh.hotel_id = hrev.hotel_id

    LEFT JOIN hotel_rooms hr
        ON dh.hotel_id = hr.hotel_id

    LEFT JOIN hotel_occupancy ho
        ON dh.hotel_id = ho.hotel_id

    WHERE dh.hotel_status = 'OPEN'
),

ranked_hotels AS (

    SELECT
        *,

        DENSE_RANK() OVER (
            ORDER BY total_revenue_inr DESC
        ) AS revenue_rank,

        DENSE_RANK() OVER (
            ORDER BY occupancy_percentage DESC
        ) AS occupancy_rank

    FROM hotel_performance
)

SELECT
    hotel_id,
    hotel_name,
    hotel_chain,
    city,
    star_rating,
    hotel_status,
    opened_date,
    hotel_age_years,

    total_rooms,
    total_bookings,
    unique_customers,
    total_room_nights,

    booked_room_nights,
    operable_room_nights,

    total_revenue_inr,
    average_booking_value,
    revenue_per_night,
    occupancy_percentage,

    revenue_rank,
    occupancy_rank,

    CASE
        WHEN occupancy_percentage >= 5
             AND revenue_rank <= 10
            THEN 'TOP PERFORMER'

        WHEN occupancy_percentage >= 3
             AND revenue_rank <= 25
            THEN 'STRONG PERFORMER'

        WHEN occupancy_percentage >= 2
            THEN 'AVERAGE PERFORMER'

        ELSE 'NEEDS ATTENTION'
    END AS performance_category

FROM ranked_hotels

ORDER BY
    revenue_rank