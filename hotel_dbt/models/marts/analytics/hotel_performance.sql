select 
fb.hotel_id ,
dh.hotel_name,
dh.hotel_chain,
dh.city,
round(avg(fb.price_per_night),2) as avg_price_per_night, 
count(fb.booking_id)as booking_count,
round(avg(dh.star_rating),2) as rating,
round(
(sum(fb.final_amount_inr)/nullif(sum(fb.billable_nights),0))
,2) as revenue_per_night,
round(sum(fb.final_amount_inr),2) as total_revenue_inr,
dense_rank() over ( order by total_revenue_inr desc) as performance_rank,
UPPER(case
    when performance_rank between 1 and 10 then 'top_performer'
    when performance_rank between 11 and 25 then 'Avergae_performer'
    else 'low_perfomer'
    end) as Performance_badge,
dh.hotel_status,
dh.opened_date,
datediff('year',dh.opened_date,current_date()) as age

from {{ ref('fact_bookings') }} fb
inner join {{ ref('dim_hotels') }} dh on fb.hotel_id = dh.hotel_id

where fb.booking_status IN ('CONFIRMED','COMPLETED') and dh.hotel_status = 'OPEN'
group by fb.hotel_id, dh.city,dh.hotel_name,dh.hotel_chain,dh.hotel_status,age,dh.opened_date 
having count(fb.booking_id) > 15 order by total_revenue_inr desc