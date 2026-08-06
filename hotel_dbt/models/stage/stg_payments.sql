select 
trim(payment_id) as payment_id,
trim(booking_id) as booking_id,
try_to_date(payment_date) as payment_date,
initcap(trim(payment_method)) as method,
initcap(trim(gateway)) as gateway,
upper(trim(currency)) as currency,
try_to_decimal(payment_amount, 10, 2) as payment_amount,
upper(trim(payment_status)) as payment_status,
try_to_decimal(refund_amount, 10, 2) as refund_amount,
trim(transaction_reference) as transaction_reference


from {{ source('bronze', 'payments') }}