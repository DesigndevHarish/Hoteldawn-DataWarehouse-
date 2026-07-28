import random
import pandas as pd
from faker import Faker

from config import *
from utils import *

fake = Faker()

def employee_key(number):
    return f"EMP{number:05d}"

def generate_employees():

    hotels = pd.read_csv(OUTPUT_FOLDER + "/hotels.csv")

    employees = []

    for i in range(1, EMPLOYEE_COUNT + 1):

        hotel = hotels.sample(1).iloc[0]

        salary = random.randint(25000, 150000)

        # Dirty Data
        if chance(2):
            salary = None

        if chance(1):
            salary = -5000

        employees.append({

            "employee_id": employee_key(i),
            "hotel_id": hotel["hotel_id"],
            "first_name": fake.first_name(),
            "last_name": fake.last_name(),
            "department": random.choice(DEPARTMENTS),
            "designation": random.choice(DESIGNATIONS),
            "salary": salary,
            "hire_date": fake.date_between(
                start_date="-10y",
                end_date="today"
            ),
            "status": random.choice([
                "Active",
                "Resigned",
                "On Leave"
            ])

        })

    df = pd.DataFrame(employees)

    df.to_csv(
        OUTPUT_FOLDER + "/employees.csv",
        index=False
    )

    print(f"Generated {len(df)} employee records")

if __name__ == "__main__":
    generate_employees()