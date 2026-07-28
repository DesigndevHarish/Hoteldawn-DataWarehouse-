import random
import pandas as pd
from faker import Faker

from config import *
from utils import *

fake = Faker()

def hotel_key(number):
    return f"HOT{number:04d}"

def generate_hotels():

    hotels = []

    for i in range(1, HOTEL_COUNT + 1):

        location = random.choice(LOCATIONS)

        star_rating = random.choice([3, 4, 5])

        # Dirty data
        if chance(2):
            star_rating = None

        hotel_name = f"{random.choice(HOTEL_CHAINS)} {location['city']} {random.choice(['Grand','Elite','Plaza','Residency','Inn'])}"

        hotels.append({

            "hotel_id": hotel_key(i),
            "hotel_name": hotel_name,
            "hotel_chain": hotel_name.split()[0],
            "city": location["city"],
            "state": location["state"],
            "country": location["country"],
            "star_rating": star_rating,
            "opened_date": fake.date_between(
                start_date="-20y",
                end_date="-1y"
            ),
            "status": random.choice(HOTEL_STATUS)

        })

    df = pd.DataFrame(hotels)

    create_output_folder()

    df.to_csv(
        OUTPUT_FOLDER + "/hotels.csv",
        index=False
    )

    print(f"Generated {len(df)} hotel records")

if __name__ == "__main__":
    generate_hotels()