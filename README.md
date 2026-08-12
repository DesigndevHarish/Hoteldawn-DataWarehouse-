# 🏨 HotelDawn Data Warehouse | Snowflake-DBT-PowerBI End-to-End Project

An end-to-end Snowflake Data Warehouse project that demonstrates how enterprise hotel booking data is ingested, cleaned, transformed, and analyzed using a modern ELT architecture.

This project simulates a real-world hospitality business by generating synthetic datasets and building a complete data warehouse using Snowflake.

---

# Project Overview

The objective of this project is to design and implement a scalable cloud data warehouse capable of handling hotel booking operations from raw CSV files to business-ready analytics.

The project demonstrates:

- Enterprise Data Warehouse Architecture
- Bronze, Silver, and Gold Data Layers
- dbt models
- Data Cleaning & Validation
- Snowflake SQL Development
- Data Modeling
- Analytical Views
- Power BI Dashboard Development

---

# Project Architecture

```
                Synthetic Dataset Generator
                         │
                         ▼
                 CSV Files (Raw Data)
                         │
                         ▼
                Snowflake Internal Stage
                         │
                         ▼
                  Bronze Layer
              (Raw Data Ingestion)
                         │ dbt models
                         ▼
                  Silver Layer
          (Cleaning & Transformation)
                         │ dbt models
                         ▼
                   Gold Layer
           (Business Data Model)
                         │
                         ▼
                Power BI Dashboards
```

---

# Dataset Overview

The project contains synthetic enterprise datasets representing hotel operations.

| Dataset | Description |
|----------|-------------|
| Customers | Customer master information |
| Hotels | Hotel master data |
| Rooms | Hotel room inventory |
| Employees | Hotel employees |
| Promotions | Discount campaigns |
| Exchange Rates | Daily currency exchange rates |
| Bookings | Hotel bookings |
| Payments | Customer payments |
| Reviews | Customer reviews |
| Room Services | Additional hotel services |

These datasets intentionally include:

- Missing values
- Duplicate records
- Invalid values
- Negative amounts
- Foreign key inconsistencies

These issues are cleaned during the Silver Layer.

---

# Folder Structure

```
Hoteldawn-DataWarehouse/

├── 00data/
│   ├── raw/
│   └── processed/
├── 01generator/
│   ├── customer_generator.py
│   ├── hotel_generator.py
│   ├── room_generator.py
│   ├── employee_generator.py
│   ├── promotion_generator.py
│   ├── exchange_rate_generator.py
│   ├── bookings_generator.py
│   ├── payments_generator.py
│   ├── reviews_generator.py
│   ├── room_services_generator.py
│   ├── config.py
│   └── utils.py
│
│
├── sql/
│
├── docs/
│
├── diagrams/
│
├── powerbi/
│
├── images/
│
├── .gitignore
│
└── README.md
```

---

# Tech Stack

### Cloud Data Warehouse

- Snowflake
- dbt

### Programming Language

- Python 3

### Python Libraries

- Pandas
- Faker

### Visualization

- Power BI

### Version Control

- Git
- GitHub

---

# Project Workflow

```
Generate Dataset
        │
        ▼
Load CSV Files
        │
        ▼
Internal Stage
        │
        ▼
Bronze Layer
        │ dbt_models_stage
        ▼
Silver Layer
        │ dbt_models(fact,dim,analytics)
        ▼
Gold Layer
        │ Business analysis sql
        ▼
Power BI Dashboard
```

---

# How to Run Dataset Generators

Clone the repository.

```bash
git clone <repository-url>
```

Navigate to the project folder.

```bash
cd Hoteldawn-DataWarehouse
```

Install dependencies.

```bash
pip install pandas faker
```

Run the generators.

```bash
python 01generator/customer_generator.py
python 01generator/hotel_generator.py
python 01generator/room_generator.py
python 01generator/employee_generator.py
python 01generator/promotion_generator.py
python 01generator/exchange_rate_generator.py
python 01generator/bookings_generator.py
python 01generator/payments_generator.py
python 01generator/reviews_generator.py
python 01generator/room_services_generator.py
```

Generated datasets will be available in:

```
data/raw/
```

---

# How to Run Snowflake Scripts

1. Create Database
2. Create Schemas
3. Create File Formats
4. Create Internal Stage
5. Upload CSV Files
6. Load Bronze Tables
7. Transform Data into Silver Layer using dbt models
8. Build Gold Layer using dbt models (fact,dim,analytics)
9. Connect Power BI

SQL scripts are located inside:

```
sql/
```

---

# Dashboards

The following Power BI dashboards will be developed.

- Executive Dashboard
- Revenue Trend Analysis
- Hotel Performance
- Occupancy & room insights
- Customer Insights


---

# Future Enhancements

- Snowpipe Automation
- Snowflake Streams & Tasks
- Dynamic Tables
- CI/CD Pipeline
- Row Level Security
- Cost Optimization

---

# Author

**Harish Kumar**

Aspiring Data Engineer specializing in Snowflake, SQL, Python, and Power BI.

---

# License

This project is licensed under the MIT License.
