select 
trim(employee_id) as employee_id,
trim(hotel_id) as hotel_id,
initcap(trim(first_name)) as first_name,
initcap(trim(last_name)) as last_name,
initcap(trim(department)) as department,
initcap(trim(designation)) as designation,
try_to_decimal(salary, 10, 2) as salary,
try_to_date(hire_date) as hire_date,
upper(trim(status)) as status

from {{ source('bronze', 'employees') }}