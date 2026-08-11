with customer_analysis as (
SELECT
    dc.customer_id,
    dc.first_name,
    dc.membership_tier,
    COUNT(fb.booking_id) AS total_bookings,
    COALESCE(SUM(fb.billable_nights), 0) AS total_nights,
    COALESCE(ROUND(SUM(fb.final_amount_inr), 2), 0) AS total_revenue_inr,
    ROUND(SUM(fb.final_amount_inr) / NULLIF(COUNT(fb.booking_id), 0), 2) AS average_booking_value,
    MIN(fb.check_in_date) AS first_booking_date,
    MAX(fb.check_in_date) AS last_booking_date,
    dc.status
FROM {{ref("dim_customers")}} dc
LEFT JOIN {{ref("fact_bookings")}} fb
    ON dc.customer_id = fb.customer_id
    AND fb.booking_status IN ('CONFIRMED', 'COMPLETED')
GROUP BY dc.customer_id, dc.first_name, dc.membership_tier, dc.status
ORDER BY dc.customer_id ASC
),

customer_value_analysis as (
    select * ,
    CASE
        WHEN total_bookings = 1 THEN 'NEW'
        WHEN total_bookings > 1 THEN 'REPEATED'
        ELSE NULL
    END AS customer_type,
    dense_rank() over ( order by total_revenue_inr desc ) as customer_revenue_rank,
    case
        when customer_revenue_rank between 1 and 25 then 'TOP VALUE'
        when customer_revenue_rank between 26 and 75 then 'HIGH VALUE'
        when customer_revenue_rank between 76 and 500 then 'MID VALUE '
        else 'LOW VALUE'
    end as customer_value_badge

    from customer_analysis 

    order by customer_revenue_rank asc
)

select * from customer_value_analysis 