with customers as ( select * from {{ ref('stg_customers') }} )

select 

    customer_id,
    first_name,
    last_name,
    gender,
    date_of_birth,
    email,
    phone_number,
    city,
    state,
    country,
    membership_tier,
    registration_date,
    status
from customers

