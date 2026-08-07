with employees as (select * from {{ ref('stg_employees') }})

select
    employee_id,
    hotel_id,
    first_name,
    last_name,
    department,
    designation,
    salary,
    hire_date,
    status
from employees