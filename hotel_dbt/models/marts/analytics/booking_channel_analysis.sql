SELECT
    fb.hotel_id,
    dh.hotel_name,
    dh.hotel_chain,
    dh.city,
    fb.booking_channel,
    COUNT(fb.booking_id) AS total_bookings,
    SUM(fb.billable_nights) AS total_nights,

    ROUND(
        SUM(fb.final_amount_inr),2
        ) AS total_amount_inr,

    ROUND(
        SUM(fb.final_amount_inr) / NULLIF(COUNT(fb.booking_id), 0), 2
        ) AS average_booking_value,

    ROUND(
        AVG(fb.price_per_night), 2
        ) AS average_price_per_night,

    ROUND(
        SUM(fb.final_amount_inr) / NULLIF(SUM(SUM(fb.final_amount_inr)) OVER ( partition by fb.hotel_id), 0) * 100, 2
        ) AS "REVENUE_CONTRIBUTION_%" ,

    COUNT(DISTINCT fb.customer_id) AS unique_customers

FROM {{ ref("fact_bookings")}} fb left join {{ref ("dim_hotels")}} dh on fb.hotel_id = dh.hotel_id
WHERE booking_status in ('CONFIRMED', 'COMPLETED')
GROUP BY 
    fb.hotel_id,
    dh.hotel_name,
    dh.hotel_chain,
    dh.city,
    fb.booking_channel