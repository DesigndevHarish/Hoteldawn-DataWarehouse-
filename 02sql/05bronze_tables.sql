USE DATABASE HOTEL_DWH;
USE SCHEMA BRONZE;

CREATE OR REPLACE TABLE BRONZE.CUSTOMER(
CUSTOMER_ID VARCHAR,
FIRST_NAME VARCHAR,
LAST_NAME VARCHAR,
GENDER VARCHAR,
DOB VARCHAR,
EMAIL VARCHAR,
PHONE VARCHAR,
CITY VARCHAR,
STATE VARCHAR,
COUNTRY VARCHAR,
LOYALTY_TIER VARCHAR,
REGISTRATION_DATE VARCHAR,
STATUS VARCHAR
);

CREATE OR REPLACE TABLE BRONZE.EMPLOYEES(
EMPLOYEE_ID VARCHAR,
HOTEL_ID VARCHAR,
FIRST_NAME VARCHAR,
LAST_NAME VARCHAR,
DEPARTMENT VARCHAR,
DESIGNATION VARCHAR,
SALARY VARCHAR,
HIRE_DATE VARCHAR,
STATUS VARCHAR
);

CREATE OR REPLACE TABLE BRONZE.EXCHANGE_RATES(
DATE VARCHAR,
CURRENCY VARCHAR,
RATE_TO_USD VARCHAR,
RATE_TO_INR VARCHAR
);

DROP TABLE EXCHANGE_REATES;

CREATE OR REPLACE TABLE BRONZE.HOTELS(
HOTEL_ID VARCHAR,
HOTEL_NAME VARCHAR,
HOTEL_CHAIN VARCHAR,
CITY VARCHAR,
STATE VARCHAR,
COUNTRY VARCHAR,
STAR_RATING VARCHAR,
OPENED_DATE VARCHAR,
STATUS VARCHAR
);

CREATE OR REPLACE TABLE BRONZE.PAYMENTS (

    payment_id             VARCHAR,
    booking_id             VARCHAR,
    payment_date           VARCHAR,
    payment_method         VARCHAR,
    gateway                VARCHAR,
    currency               VARCHAR,
    payment_amount         VARCHAR,
    payment_status         VARCHAR,
    refund_amount          VARCHAR,
    transaction_reference  VARCHAR

);

CREATE OR REPLACE TABLE BRONZE.PROMOTIONS (

    promotion_id          VARCHAR,
    promo_code            VARCHAR,
    campaign_name         VARCHAR,
    discount_percentage   VARCHAR,
    start_date            VARCHAR,
    end_date              VARCHAR,
    status                VARCHAR

);

CREATE OR REPLACE TABLE BRONZE.REVIEWS (

    review_id         VARCHAR,
    booking_id        VARCHAR,
    customer_id       VARCHAR,
    hotel_id          VARCHAR,
    rating            VARCHAR,
    review_title      VARCHAR,
    review_text       VARCHAR,
    review_date       VARCHAR,
    sentiment         VARCHAR

);


CREATE OR REPLACE TABLE BRONZE.ROOM_SERVICES (

    service_id      VARCHAR,
    booking_id      VARCHAR,
    hotel_id        VARCHAR,
    employee_id     VARCHAR,
    service_name    VARCHAR,
    service_date    VARCHAR,
    quantity        VARCHAR,
    unit_price      VARCHAR,
    total_price     VARCHAR

);

CREATE OR REPLACE TABLE BRONZE.ROOMS (

    room_id         VARCHAR,
    hotel_id        VARCHAR,
    room_number     VARCHAR,
    room_type       VARCHAR,
    capacity        VARCHAR,
    base_price      VARCHAR,
    floor           VARCHAR,
    availability    VARCHAR

);

CREATE OR REPLACE TABLE BRONZE.BOOKINGS (

    booking_id             VARCHAR,
    customer_id            VARCHAR,
    hotel_id               VARCHAR,
    room_id                VARCHAR,
    promotion_id           VARCHAR,
    booking_date           VARCHAR,
    check_in_date          VARCHAR,
    check_out_date         VARCHAR,
    adults                 VARCHAR,
    children               VARCHAR,
    booking_channel        VARCHAR,
    booking_status         VARCHAR,
    currency               VARCHAR,
    amount                 VARCHAR,
    discount_percentage    VARCHAR,
    discount_amount        VARCHAR,
    tax_amount             VARCHAR,
    final_amount           VARCHAR,
    created_timestamp      VARCHAR,
    updated_timestamp      VARCHAR

);