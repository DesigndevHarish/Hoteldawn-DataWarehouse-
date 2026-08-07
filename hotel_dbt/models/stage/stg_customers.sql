select 
trim(customer_id) as customer_id,
initcap(trim(first_name)) as first_name,
initcap(trim(last_name)) as last_name,
initcap(trim(gender)) as gender,
try_to_date(dob) as date_of_birth,
lower(trim(email)) as email,
trim(phone) as phone_number,
initcap(trim(city)) as city,
initcap(trim(state)) as state,
initcap(trim(country)) as country,
upper(trim(loyalty_tier)) as membership_tier,
try_to_date(registration_date) as registration_date,
upper(trim(status)) as status,

from {{source('bronze', 'customers')}}

