import random
import pandas as pd
from faker import Faker

from config import *
from utils import *

fake = Faker()

def generate_customers():

    customers = []

    for i in range(1, CUSTOMER_COUNT + 1):

        location = random.choice(LOCATIONS)

        first_name = fake.first_name()
        last_name = fake.last_name()

        email = random_email(first_name, last_name)
        phone = random_phone()

        if chance(DATA_QUALITY["null_email_percent"]):
            email = None

        if chance(DATA_QUALITY["invalid_email_percent"]):
            email = invalid_email()

        if chance(DATA_QUALITY["null_phone_percent"]):
            phone = None

        city = location["city"]

        if chance(2):
            city = city.upper()

        if chance(2):
            city = " " + city

        if chance(2):
            city = city + " "

        customers.append({

            "customer_id": customer_key(i),
            "first_name": first_name,
            "last_name": last_name,
            "gender": random.choice(["Male", "Female"]),
            "dob": fake.date_of_birth(minimum_age=18, maximum_age=70),
            "email": email,
            "phone": phone,
            "city": city,
            "state": location["state"],
            "country": location["country"],
            "loyalty_tier": random.choice(LOYALTY_TIERS),
            "registration_date": fake.date_between(
                start_date="-5y",
                end_date="today"
            ),
            "status": random.choice(["Active", "Inactive"])
        })

    duplicates = random.sample(
        customers,
        DATA_QUALITY["duplicate_customer_count"]
    )

    customers.extend(duplicates)

    df = pd.DataFrame(customers)

    create_output_folder()

    df.to_csv(
        OUTPUT_FOLDER + "/customers.csv",
        index=False
    )

    print(f"Generated {len(df)} customer records")


if __name__ == "__main__":
    generate_customers()