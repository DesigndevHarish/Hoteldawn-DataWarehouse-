with payments as (select * from {{ ref('stg_payments') }})

select 
    payment_id,
    booking_id,
    payment_date,
    method,
    gateway,
    currency,
    payment_amount,
    payment_status,
    refund_amount,
    transaction_reference
from payments