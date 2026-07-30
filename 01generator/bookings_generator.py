import random
import pandas as pd
from faker import Faker
from datetime import timedelta

from config import *
from utils import *

fake = Faker()


def booking_key(number):
    return f"BOOK{number:06d}"


def random_booking_status():
    return random.choices(
        ["Completed", "Confirmed", "Cancelled", "No Show"],
        weights=[60, 20, 15, 5],
        k=1
    )[0]


def random_channel():
    return random.choice([
        "Website",
        "Mobile App",
        "Booking.com",
        "Expedia",
        "Walk-In",
        "Travel Agent"
    ])


def random_currency():
    return random.choice([
        "INR",
        "USD",
        "EUR",
        "AED",
        "SGD",
        "GBP"
    ])


def generate_bookings():

    print("Loading master datasets...")

    customers = pd.read_csv(f"{OUTPUT_FOLDER}/customers.csv")
    hotels = pd.read_csv(f"{OUTPUT_FOLDER}/hotels.csv")
    rooms = pd.read_csv(f"{OUTPUT_FOLDER}/rooms.csv")
    promotions = pd.read_csv(f"{OUTPUT_FOLDER}/promotions.csv")

    bookings = []

    for i in range(1, BOOKING_COUNT + 1):

        customer = customers.sample(1).iloc[0]

        hotel = hotels.sample(1).iloc[0]

        hotel_rooms = rooms[
            rooms["hotel_id"] == hotel["hotel_id"]
        ]

        if len(hotel_rooms) == 0:
            continue

        room = hotel_rooms.sample(1).iloc[0]

        promotion = promotions.sample(1).iloc[0]

        booking_date = fake.date_between(
            start_date="-2y",
            end_date="today"
        )

        days_until_checkin = random.randint(1, 60)

        check_in = booking_date + timedelta(
            days=days_until_checkin
        )

        nights = random.randint(1, 7)

        check_out = check_in + timedelta(
            days=nights
        )

        adults = random.randint(1, 4)

        children = random.randint(0, 2)

        booking_status = random_booking_status()

        booking_channel = random_channel()

        currency = random_currency()

        room_price = abs(
            float(room["base_price"])
        )

        amount = round(
            room_price * nights,
            2
        )

        discount_percent = random.choice(
            [0, 5, 10, 15, 20]
        )

        discount = round(
            amount * discount_percent / 100,
            2
        )

        taxable_amount = amount - discount

        tax = round(
            taxable_amount * 0.18,
            2
        )

        final_amount = round(
            taxable_amount + tax,
            2
        )

        created_timestamp = fake.date_time_this_decade()

        updated_timestamp = fake.date_time_between(
            start_date=created_timestamp
        )
        bookings.append({

            "booking_id": booking_key(i),

            "customer_id": customer["customer_id"],

            "hotel_id": hotel["hotel_id"],

            "room_id": room["room_id"],

            "promotion_id": promotion["promotion_id"],

            "booking_date": booking_date,

            "check_in_date": check_in,

            "check_out_date": check_out,

            "adults": adults,

            "children": children,

            "booking_channel": booking_channel,

            "booking_status": booking_status,

            "currency": currency,

            "amount": amount,

            "discount_percentage": discount_percent,

            "discount_amount": discount,

            "tax_amount": tax,

            "final_amount": final_amount,

            "created_timestamp": created_timestamp,

            "updated_timestamp": updated_timestamp

        })

    print("Injecting dirty data...")

    # Null currency
    for row in random.sample(bookings, min(50, len(bookings))):
        row["currency"] = None

    # Invalid customer IDs
    for row in random.sample(bookings, min(30, len(bookings))):
        row["customer_id"] = "CUST999999"

    # Negative amounts
    for row in random.sample(bookings, min(25, len(bookings))):
        row["final_amount"] = -abs(row["final_amount"])

    # Invalid dates
    for row in random.sample(bookings, min(20, len(bookings))):
        row["check_out_date"] = row["booking_date"]

    # Duplicate bookings
    duplicates = random.sample(bookings, min(100, len(bookings)))
    bookings.extend(duplicates)

    print("Writing CSV...")

    df = pd.DataFrame(bookings)

    create_output_folder()

    df.to_csv(
        f"{OUTPUT_FOLDER}/bookings.csv",
        index=False
    )

    print(f"Generated {len(df)} booking records")

if __name__ == "__main__":
    generate_bookings()