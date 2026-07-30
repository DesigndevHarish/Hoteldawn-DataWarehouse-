import random
from datetime import timedelta

import pandas as pd

from config import *
from utils import *


def review_key(number):
    return f"REV{number:06d}"


REVIEW_TITLES = [
    "Excellent Stay",
    "Very Good",
    "Average Experience",
    "Needs Improvement",
    "Highly Recommended",
    "Value for Money",
    "Poor Service",
    "Amazing Hospitality"
]

REVIEW_TEXTS = [
    "Room was clean and comfortable.",
    "Staff were friendly and helpful.",
    "Food quality was excellent.",
    "Check-in process was smooth.",
    "Will definitely visit again.",
    "Bathroom needs improvement.",
    "Great location and ambience.",
    "Overall satisfied with the stay."
]


def sentiment(rating):

    if rating >= 4:
        return "Positive"

    elif rating == 3:
        return "Neutral"

    else:
        return "Negative"


def generate_reviews():

    bookings = pd.read_csv(f"{OUTPUT_FOLDER}/bookings.csv")

    reviews = []

    completed = bookings[
        bookings["booking_status"] == "Completed"
    ]

    sample_size = min(3000, len(completed))

    selected = completed.sample(sample_size)

    for i, booking in enumerate(selected.itertuples(), start=1):

        checkout = pd.to_datetime(
            booking.check_out_date
        ).date()

        review_date = checkout + timedelta(
            days=random.randint(1, 10)
        )

        rating = random.randint(1, 5)

        reviews.append({

            "review_id": review_key(i),

            "booking_id": booking.booking_id,

            "customer_id": booking.customer_id,

            "hotel_id": booking.hotel_id,

            "rating": rating,

            "review_title": random.choice(REVIEW_TITLES),

            "review_text": random.choice(REVIEW_TEXTS),

            "review_date": review_date,

            "sentiment": sentiment(rating)

        })

    # ----------------------
    # Dirty Data
    # ----------------------

    for row in random.sample(
        reviews,
        min(20, len(reviews))
    ):
        row["review_text"] = None

    for row in random.sample(
        reviews,
        min(10, len(reviews))
    ):
        row["rating"] = 6

    duplicates = random.sample(
        reviews,
        min(30, len(reviews))
    )

    reviews.extend(duplicates)

    df = pd.DataFrame(reviews)

    create_output_folder()

    df.to_csv(
        f"{OUTPUT_FOLDER}/reviews.csv",
        index=False
    )

    print(
        f"Generated {len(df)} review records"
    )


if __name__ == "__main__":
    generate_reviews()