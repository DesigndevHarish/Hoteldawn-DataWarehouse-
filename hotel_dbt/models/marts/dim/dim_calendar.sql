WITH calendar AS (

    SELECT
        DATEADD(
            'day',
            SEQ4(),
            '2024-01-01'::DATE
        ) AS calendar_date

    FROM TABLE(
        GENERATOR(ROWCOUNT => 1096)
    )

)


SELECT
    calendar_date,

    YEAR(calendar_date) AS calendar_year,

    MONTH(calendar_date) AS calendar_month,

    DAY(calendar_date) AS calendar_day,

    TO_CHAR(calendar_date, 'YYYY-MM') AS calendar_year_month,

    TO_CHAR(calendar_date, 'YYYY-MM-DD') AS calendar_year_month_day,

    DAYNAME(calendar_date) AS calendar_weekday,

    CASE
        WHEN DAYNAME(calendar_date) IN ('Sat', 'Sun')
            THEN 'Weekend'
        ELSE 'Weekday'
    END AS calendar_weekday_type

FROM calendar

ORDER BY calendar_date