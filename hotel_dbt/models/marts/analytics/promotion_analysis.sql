SELECT
    promotion_id,

    COUNT(booking_id) AS total_bookings,

    SUM(billable_nights) AS total_nights,

    COUNT(DISTINCT customer_id) AS unique_customers,

    ROUND(
        SUM(final_amount_inr),
        2
    ) AS total_revenue_inr,

    ROUND(
        SUM(discount_amount),
        2
    ) AS total_discount_inr,

    ROUND(
        AVG(discount_percentage),
        2
    ) AS average_discount_percentage,

    ROUND(
        SUM(final_amount_inr)
        / NULLIF(COUNT(booking_id), 0),
        2
    ) AS average_booking_value,

    ROUND(
        SUM(final_amount_inr)
        / NULLIF(SUM(billable_nights), 0),
        2
    ) AS revenue_per_night,

    ROUND(
        SUM(discount_amount)
        /
        NULLIF(
            SUM(final_amount_inr) + SUM(discount_amount),
            0
        ) * 100,
        2
    ) AS discount_impact_percentage

FROM {{ref("fact_bookings")}}

WHERE booking_status IN ('CONFIRMED', 'COMPLETED')

GROUP BY promotion_id