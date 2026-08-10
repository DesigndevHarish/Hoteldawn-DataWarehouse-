with hotel_months as (
    select distinct
        h.hotel_id,
        h.hotel_name,
        date_trunc('month', c.calendar_date) as revenue_month,
        h.hotel_status
    from {{ ref('dim_hotels') }} h
    cross join {{ ref('dim_calendar') }} c
    where h.hotel_status = 'OPEN'
),





monthly_revenue AS (

    SELECT
        fb.hotel_id,
        DATE_TRUNC('month', fb.booking_date) AS revenue_month,
        ROUND(SUM(fb.final_amount_inr), 2) AS monthly_revenue_inr

    FROM {{ ref('fact_bookings') }} fb


    WHERE fb.booking_status IN ('CONFIRMED', 'COMPLETED')

    GROUP BY
        fb.hotel_id,
        DATE_TRUNC('month', fb.booking_date)
),


hotel_monthly_revenue as (
    select
        hm.hotel_id,
        hm.hotel_name,
        hm.revenue_month,
        coalesce(mr.monthly_revenue_inr,0) as monthly_revenue_inr,
        hm.hotel_status
    from hotel_months hm 
    left join monthly_revenue mr 
    on hm.hotel_id = mr.hotel_id and hm.revenue_month = mr.revenue_month
),

previous_month_revenue AS (

    SELECT
        hotel_id,
        hotel_name,
        revenue_month,
        monthly_revenue_inr,
        hotel_status,

        LAG(monthly_revenue_inr) OVER (
            PARTITION BY hotel_id
            ORDER BY revenue_month
        ) AS previous_month_revenue_inr

    FROM hotel_monthly_revenue
),

revenue_percentage_change AS (

    SELECT
        hotel_id,
        hotel_name,
        revenue_month,
        monthly_revenue_inr,
        previous_month_revenue_inr,
        hotel_status,

        monthly_revenue_inr - previous_month_revenue_inr
            AS revenue_difference,

        CASE
            WHEN previous_month_revenue_inr IS NULL THEN NULL
            WHEN previous_month_revenue_inr = 0 THEN NULL
            ELSE ROUND(
                (
                    (monthly_revenue_inr - previous_month_revenue_inr)
                    / previous_month_revenue_inr
                ) * 100,
                2
            )
        END AS revenue_percentage_change,

        CASE
        WHEN previous_month_revenue_inr IS NULL
            THEN 'NEW'

        WHEN monthly_revenue_inr > previous_month_revenue_inr
            THEN 'INCREMENTING'

        WHEN monthly_revenue_inr < previous_month_revenue_inr
            THEN 'DECREMENTING'

        ELSE 'NO CHANGE'
        END AS revenue_trend



    FROM previous_month_revenue
)

SELECT
    hotel_id,
    hotel_name,
    revenue_month,
    monthly_revenue_inr,
    previous_month_revenue_inr,
    revenue_difference,
    revenue_percentage_change,
    revenue_trend,
    hotel_status

FROM revenue_percentage_change

ORDER BY
    hotel_id,
    revenue_month DESC