import random
import pandas as pd
from faker import Faker

from config import *
from utils import *

fake = Faker()

def promotion_key(number):
    return f"PROMO{number:05d}"

def generate_promotions():

    promotions = []

    for i in range(1, PROMOTION_COUNT + 1):

        discount = random.choice([5,10,15,20,25,30,40])

        promotions.append({

            "promotion_id": promotion_key(i),
            "promo_code": fake.bothify(text="HV????##").upper(),
            "campaign_name": random.choice(CAMPAIGNS),
            "discount_percentage": discount,
            "start_date": fake.date_between(
                start_date="-2y",
                end_date="+1y"
            ),
            "end_date": fake.date_between(
                start_date="+1y",
                end_date="+2y"
            ),
            "status": random.choice(PROMOTION_STATUS)

        })

    df = pd.DataFrame(promotions)

    df.to_csv(
        OUTPUT_FOLDER + "/promotions.csv",
        index=False
    )

    print(f"Generated {len(df)} promotion records")

if __name__ == "__main__":
    generate_promotions()