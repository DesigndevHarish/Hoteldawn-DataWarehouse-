WITH monthly_seasonality AS (

    SELECT
        MONTH(fb.booking_date) AS month_number,

        MONTHNAME(fb.booking_date) AS month_name,

        COUNT(fb.booking_id) AS total_bookings,

        SUM(fb.billable_nights) AS total_nights,

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
            AVG(fb.price_per_night),
            2
        ) AS average_price_per_night

    FROM {{ ref('fact_bookings') }} fb

    WHERE fb.booking_status IN ('CONFIRMED', 'COMPLETED')

    GROUP BY
        MONTH(fb.booking_date),
        MONTHNAME(fb.booking_date)
),

seasonality_analysis AS (

    SELECT
        month_number,
        month_name,
        total_bookings,
        total_nights,
        total_revenue_inr,
        average_booking_value,
        average_price_per_night,

        ROUND(
            total_revenue_inr
            / NULLIF(
                SUM(total_revenue_inr) OVER (),
                0
            ) * 100,
            2
        ) AS revenue_contribution_percentage,

        DENSE_RANK() OVER (
            ORDER BY total_revenue_inr DESC
        ) AS revenue_rank

    FROM monthly_seasonality
)

SELECT
    month_number,
    month_name,
    total_bookings,
    total_nights,
    total_revenue_inr,
    average_booking_value,
    average_price_per_night,
    revenue_contribution_percentage,
    revenue_rank,

    CASE
        WHEN revenue_rank <= 3
            THEN 'HIGH SEASON'

        WHEN revenue_rank >= 10
            THEN 'LOW SEASON'

        ELSE 'NORMAL SEASON'
    END AS season_category

FROM seasonality_analysis

ORDER BY month_number