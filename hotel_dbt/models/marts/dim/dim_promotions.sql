with promotions as (select * from {{ref('stg_promotions')}})

select
    promotion_id,
    promotion_code,
    campaign_name,
    discount_percentage,
    start_date,
    end_date,
    promotion_status
from promotions