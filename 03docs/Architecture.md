# Architecture Document

## Project Objective

Design and implement an enterprise-grade hotel booking data warehouse using Snowflake.

The project demonstrates the complete data lifecycle from raw CSV ingestion to business-ready analytics.

---

# Architecture

```
Python Dataset Generator
          │
          ▼
     CSV Files
          │
          ▼
 Snowflake Internal Stage
          │
          ▼
      Bronze Layer
   (Raw Data Storage)
          │
          ▼
      Silver Layer
(Data Cleaning & Business Rules)
          │
          ▼
       Gold Layer
 (Business Data Model)
          │
          ▼
     Power BI Reports
```

---

# Layers

## Bronze

Purpose

- Store raw source data
- No transformations
- Audit-ready

---

## Silver

Purpose

- Data cleaning
- Remove duplicates
- Handle NULL values
- Standardize data types
- Currency conversion
- Business rule validation

---

## Gold

Purpose

- Business-ready data
- Star Schema
- KPI Views
- Dashboard reporting

---

# Technologies

- Snowflake
- Python
- Pandas
- Faker
- SQL
- Power BI
- Git
- GitHub
