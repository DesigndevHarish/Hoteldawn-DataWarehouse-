# Data Quality Rules

## Objective

The Silver Layer applies business rules to improve data quality before analytical reporting.

---

# Validation Rules

## Customer

- customer_id cannot be NULL
- Email format validation
- Remove duplicate customers

---

## Booking

- Check-out date must be after check-in date
- Booking amount cannot be negative
- Currency cannot be NULL
- Customer must exist

---

## Payment

- Payment amount must be positive
- Booking ID must exist
- Gateway cannot be NULL

---

## Reviews

- Rating must be between 1 and 5
- Booking must exist
- Customer must exist

---

## Room Service

- Quantity must be positive
- Employee ID must exist
- Total Price = Quantity × Unit Price

---

# Cleaning Operations

- Remove duplicates
- Replace empty strings with NULL
- Standardize date formats
- Convert currencies to INR
- Validate foreign keys
