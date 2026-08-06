select 

try_to_date(date) as transaction_date,
upper(trim(currency)) as base_currency,
try_to_decimal(rate_to_usd, 10, 4) as amount_in_usd,
try_to_decimal(rate_to_inr, 10, 4) as amount_in_inr

from {{ source('bronze', 'exchange_rates') }}