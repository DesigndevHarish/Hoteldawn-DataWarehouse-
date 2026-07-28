import random
import pandas as pd

from config import *
from utils import *

def room_key(number):
    return f"ROOM{number:06d}"


def generate_rooms():

    hotels = pd.read_csv(OUTPUT_FOLDER + "/hotels.csv")

    rooms = []

    for i in range(1, ROOM_COUNT + 1):

        hotel = hotels.sample(1).iloc[0]

        room_type = random.choice(ROOM_TYPES)

        base_price = random.choice([
            2500,
            3500,
            5000,
            7000,
            10000,
            15000
        ])

        # Dirty Data

        if chance(2):
            room_type = None

        if chance(1):
            base_price = -base_price

        rooms.append({

            "room_id": room_key(i),

            "hotel_id": hotel["hotel_id"],

            "room_number": random.randint(100,999),

            "room_type": room_type,

            "capacity": random.randint(1,6),

            "base_price": base_price,

            "floor": random.randint(1,15),

            "availability": random.choice([
                "Available",
                "Occupied",
                "Maintenance"
            ])

        })

    df = pd.DataFrame(rooms)

    create_output_folder()

    df.to_csv(
        OUTPUT_FOLDER + "/rooms.csv",
        index=False
    )

    print(f"Generated {len(df)} room records")


if __name__ == "__main__":
    generate_rooms()