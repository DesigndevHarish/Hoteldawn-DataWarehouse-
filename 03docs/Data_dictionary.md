# Data Dictionary

## customers.csv

| Column | Data Type | Description |
|---------|-----------|-------------|
| customer_id | VARCHAR | Unique customer identifier |
| customer_name | VARCHAR | Customer full name |
| email | VARCHAR | Email address |
| phone | VARCHAR | Phone number |
| country | VARCHAR | Customer country |
| city | VARCHAR | Customer city |

---

## hotels.csv

| Column | Data Type | Description |
|---------|-----------|-------------|
| hotel_id | VARCHAR | Unique hotel ID |
| hotel_name | VARCHAR | Hotel name |
| city | VARCHAR | Hotel city |
| country | VARCHAR | Hotel country |
| star_rating | INTEGER | Hotel rating |

---

## rooms.csv

| Column | Data Type | Description |
|---------|-----------|-------------|
| room_id | VARCHAR | Room identifier |
| hotel_id | VARCHAR | Related hotel |
| room_type | VARCHAR | Room category |
| base_price | NUMBER | Base room price |

---

## bookings.csv

| Column | Data Type | Description |
|---------|-----------|-------------|
| booking_id | VARCHAR | Booking identifier |
| customer_id | VARCHAR | Customer FK |
| hotel_id | VARCHAR | Hotel FK |
| room_id | VARCHAR | Room FK |
| booking_date | DATE | Booking creation date |
| check_in_date | DATE | Check-in |
| check_out_date | DATE | Check-out |
| final_amount | NUMBER | Booking total |

---

## payments.csv

Stores payment transactions.

---

## reviews.csv

Stores customer reviews.

---

## room_services.csv

Stores hotel room service transactions.
