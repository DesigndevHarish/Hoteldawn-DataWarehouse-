WITH customer_analysis AS (

    SELECT
        fb.hotel_id,
        dh.hotel_name,
        fb.customer_id,

        COUNT(fb.booking_id) AS customer_booking_count,

        CASE
            WHEN COUNT(fb.booking_id) = 1
                THEN 'NEW'

            WHEN COUNT(fb.booking_id) > 1
                THEN 'REPEATED'
        END AS customer_type

    FROM {{ ref('fact_bookings') }} fb inner join {{ref("dim_hotels")}} dh on fb.hotel_id = dh.hotel_id

    WHERE fb.booking_status IN ('CONFIRMED', 'COMPLETED') and dh.hotel_status = 'OPEN'

    GROUP BY
        fb.hotel_id,
        fb.customer_id,
        dh.hotel_name
),

hotel_retention AS (

    SELECT
        hotel_id,
        hotel_name,

        COUNT(customer_id) AS total_customers,

        COUNT_IF(customer_type = 'NEW')
            AS new_customers,

        COUNT_IF(customer_type = 'REPEATED')
            AS repeat_customers,

        ROUND(
            COUNT_IF(customer_type = 'REPEATED')
            / NULLIF(COUNT(customer_id), 0)
            * 100,
            2
        ) AS repeat_customer_percentage

    FROM customer_analysis

    GROUP BY hotel_id, hotel_name
),

hotel_revenue AS (

    SELECT
        fb.hotel_id,

        ROUND(
            SUM(fb.final_amount_inr),
            2
        ) AS total_revenue_inr

    FROM {{ ref('fact_bookings') }} fb

    WHERE fb.booking_status IN ('CONFIRMED', 'COMPLETED')

    GROUP BY fb.hotel_id
)

SELECT
    hr.hotel_id,
    hr.hotel_name,

    hr.total_customers,
    hr.new_customers,
    hr.repeat_customers,
    hr.repeat_customer_percentage,

    COALESCE(hrev.total_revenue_inr, 0)
        AS total_revenue_inr,

    ROUND(
        hrev.total_revenue_inr
        / NULLIF(hr.total_customers, 0),
        2
    ) AS average_revenue_per_customer

FROM hotel_retention hr

LEFT JOIN hotel_revenue hrev
    ON hr.hotel_id = hrev.hotel_id

ORDER BY
    repeat_customer_percentage DESC