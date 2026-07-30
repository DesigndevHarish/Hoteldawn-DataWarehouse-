import random
import uuid
from datetime import timedelta

import pandas as pd

from config import *
from utils import *

def payment_key(number):
    return f"PAY{number:06d}"


def generate_payments():

    bookings = pd.read_csv(f"{OUTPUT_FOLDER}/bookings.csv")

    payments = []

    for i, booking in bookings.iterrows():

        booking_date = pd.to_datetime(
            booking["booking_date"]
        ).date()

        payment_date = booking_date + timedelta(
            days=random.randint(0, 5)
        )

        payment_status = random.choices(
            PAYMENT_STATUS,
            weights=[85, 10, 5],
            k=1
        )[0]

        payment_method = random.choice(PAYMENT_METHODS)

        gateway = random.choice(PAYMENT_GATEWAYS)

        currency = booking["currency"]

        payment_amount = abs(
            float(booking["final_amount"])
        )

        refund_amount = 0

        if payment_status == "Refunded":

            refund_amount = round(
                payment_amount * random.uniform(0.25, 1.00),
                2
            )

        payments.append({

            "payment_id": payment_key(i + 1),

            "booking_id": booking["booking_id"],

            "payment_date": payment_date,

            "payment_method": payment_method,

            "gateway": gateway,

            "currency": currency,

            "payment_amount": payment_amount,

            "payment_status": payment_status,

            "refund_amount": refund_amount,

            "transaction_reference": str(uuid.uuid4())

        })

    # -----------------------
    # Dirty Data
    # -----------------------

    for row in random.sample(
        payments,
        min(25, len(payments))
    ):
        row["gateway"] = None

    for row in random.sample(
        payments,
        min(20, len(payments))
    ):
        row["refund_amount"] = -100

    duplicates = random.sample(
        payments,
        min(50, len(payments))
    )

    payments.extend(duplicates)

    df = pd.DataFrame(payments)

    create_output_folder()

    df.to_csv(
        f"{OUTPUT_FOLDER}/payments.csv",
        index=False
    )

    print(
        f"Generated {len(df)} payment records"
    )


if __name__ == "__main__":
    generate_payments()