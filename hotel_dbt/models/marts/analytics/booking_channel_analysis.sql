SELECT
    booking_channel,
    COUNT(booking_id) AS total_bookings,
    SUM(billable_nights) AS total_nights,

    ROUND(
        SUM(final_amount_inr),2
        ) AS total_amount_inr,

    ROUND(
        SUM(final_amount_inr) / NULLIF(COUNT(booking_id), 0), 2
        ) AS average_booking_value,

    ROUND(
        AVG(price_per_night), 2
        ) AS average_price_per_night,

    ROUND(
        SUM(final_amount_inr) / NULLIF(SUM(SUM(final_amount_inr)) OVER (), 0) * 100, 2
        ) AS "REVENUE_CONTRIBUTION_%" ,

    COUNT(DISTINCT customer_id) AS unique_customers

FROM {{ ref("fact_bookings")}}
WHERE booking_status in ('CONFIRMED', 'COMPLETED')
GROUP BY booking_channel