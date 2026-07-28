import random
from pathlib import Path
from faker import Faker

from config import OUTPUT_FOLDER

fake = Faker()

# Create output folder
def create_output_folder():
    Path(OUTPUT_FOLDER).mkdir(parents=True, exist_ok=True)

# Business Key
def customer_key(number):
    return f"CUST{number:06d}"

# Random phone
def random_phone():
    return fake.msisdn()[:10]

# Random email
def random_email(first_name, last_name):
    domains = [
        "gmail.com",
        "yahoo.com",
        "outlook.com",
        "hotmail.com"
    ]
    return f"{first_name.lower()}.{last_name.lower()}@{random.choice(domains)}"

# Invalid email
def invalid_email():
    return random.choice([
        "abc@",
        "@gmail.com",
        "gmail.com",
        "john@gmail",
        "###@gmail.com"
    ])

# Random chance
def chance(percent):
    return random.random() < (percent / 100)