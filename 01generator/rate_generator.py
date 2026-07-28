import pandas as pd
from datetime import datetime

from config import *

def generate_exchange_rates():

    dates = pd.date_range(
        start="2024-01-01",
        end="2026-12-31"
    )

    data = []

    rates = {

        "USD": (1.00, 83.0),
        "EUR": (1.08, 90.0),
        "GBP": (1.27, 105.0),
        "AED": (0.27, 22.5),
        "SGD": (0.74, 61.5),
        "INR": (0.012, 1.0)

    }

    for d in dates:

        for currency, values in rates.items():

            data.append({

                "date": d.date(),

                "currency": currency,

                "rate_to_usd": values[0],

                "rate_to_inr": values[1]

            })

    df = pd.DataFrame(data)

    df.to_csv(
        OUTPUT_FOLDER + "/exchange_rates.csv",
        index=False
    )

    print(f"Generated {len(df)} exchange rate records")

if __name__ == "__main__":
    generate_exchange_rates()