import random
from datetime import timedelta

import pandas as pd

from config import *
from utils import *


SERVICE_NAMES = [
    "Breakfast",
    "Lunch",
    "Dinner",
    "Laundry",
    "Spa",
    "Airport Pickup",
    "Mini Bar",
    "Room Cleaning",
    "Gym",
    "Swimming Pool"
]


def service_key(number):
    return f"SER{number:06d}"


def generate_room_services():

    bookings = pd.read_csv(f"{OUTPUT_FOLDER}/bookings.csv")

    employees = pd.read_csv(f"{OUTPUT_FOLDER}/employees.csv")

    services = []

    selected_bookings = bookings.sample(
        min(2500, len(bookings))
    )

    for i, booking in enumerate(
        selected_bookings.itertuples(),
        start=1
    ):

        employee = employees.sample(1).iloc[0]

        checkin = pd.to_datetime(
            booking.check_in_date
        ).date()

        checkout = pd.to_datetime(
            booking.check_out_date
        ).date()

        stay_days = max(
            1,
            (checkout - checkin).days
        )

        service_date = checkin + timedelta(
            days=random.randint(0, stay_days - 1)
        )

        quantity = random.randint(1, 4)

        unit_price = random.choice(
            [250, 500, 750, 1000, 1500, 2000]
        )

        total_price = quantity * unit_price

        services.append({

            "service_id": service_key(i),

            "booking_id": booking.booking_id,

            "hotel_id": booking.hotel_id,

            "employee_id": employee["employee_id"],

            "service_name": random.choice(
                SERVICE_NAMES
            ),

            "service_date": service_date,

            "quantity": quantity,

            "unit_price": unit_price,

            "total_price": total_price

        })

    # -------------------------
    # Dirty Data
    # -------------------------

    # Null employee
    for row in random.sample(
        services,
        min(20, len(services))
    ):
        row["employee_id"] = None

    # Negative quantity
    for row in random.sample(
        services,
        min(15, len(services))
    ):
        row["quantity"] = -1

    # Wrong total
    for row in random.sample(
        services,
        min(20, len(services))
    ):
        row["total_price"] += random.randint(100, 500)

    # Duplicate rows
    duplicates = random.sample(
        services,
        min(50, len(services))
    )

    services.extend(duplicates)

    df = pd.DataFrame(services)

    create_output_folder()

    df.to_csv(
        f"{OUTPUT_FOLDER}/room_services.csv",
        index=False
    )

    print(
        f"Generated {len(df)} room service records"
    )


if __name__ == "__main__":
    generate_room_services()