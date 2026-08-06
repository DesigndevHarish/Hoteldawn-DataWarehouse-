select 

trim(promotion_id) as promotion_id,
trim(promo_code) as promotion_code,
initcap(trim(campaign_name)) as campaign_name,
try_to_decimal(discount_percentage, 10, 2) as discount_percentage,
try_to_date(start_date) as start_date,
try_to_date(end_date) as end_date,
upper(trim(status)) as promotion_status

from {{ source('bronze', 'promotions') }}