"""
HotelVista Dataset Configuration
"""

# Output folder
OUTPUT_FOLDER = "00data/raw"

# Dataset size
CUSTOMER_COUNT = 5000

# Locations
LOCATIONS = [
    {"city": "Chennai", "state": "Tamil Nadu", "country": "India"},
    {"city": "Bengaluru", "state": "Karnataka", "country": "India"},
    {"city": "Mumbai", "state": "Maharashtra", "country": "India"},
    {"city": "Delhi", "state": "Delhi", "country": "India"},
    {"city": "Hyderabad", "state": "Telangana", "country": "India"},
    {"city": "Singapore", "state": "Singapore", "country": "Singapore"},
    {"city": "Dubai", "state": "Dubai", "country": "UAE"},
    {"city": "London", "state": "England", "country": "United Kingdom"},
    {"city": "New York", "state": "New York", "country": "United States"},
    {"city": "Sydney", "state": "New South Wales", "country": "Australia"}
]

# Loyalty Tiers
LOYALTY_TIERS = [
    "Silver",
    "Gold",
    "Platinum",
    "Diamond"
]

# Data Quality Rules
DATA_QUALITY = {
    "null_email_percent": 2,
    "invalid_email_percent": 2,
    "null_phone_percent": 2,
    "duplicate_customer_count": 50
}


HOTEL_COUNT = 250

HOTEL_CHAINS = [
    "HotelDawn",
    "Royal Stay",
    "Elite Suites",
    "Skyline Hotels",
    "Ocean Resorts"
]

HOTEL_STATUS = [
    "Open",
    "Renovation",
    "Closed"
]


ROOM_COUNT = 2000

ROOM_TYPES = [
    "Standard",
    "Deluxe",
    "Executive",
    "Suite",
    "Family",
    "Presidential"
]



EMPLOYEE_COUNT = 800

DEPARTMENTS = [
    "Front Office",
    "Housekeeping",
    "Finance",
    "HR",
    "IT",
    "Food & Beverage",
    "Security",
    "Maintenance"
]

DESIGNATIONS = [
    "Manager",
    "Executive",
    "Supervisor",
    "Associate",
    "Technician"
]



PROMOTION_COUNT = 500

PROMOTION_STATUS = [
    "Active",
    "Expired",
    "Upcoming"
]

CAMPAIGNS = [
    "Summer Sale",
    "Weekend Offer",
    "Festive Offer",
    "New Year Sale",
    "Corporate Deal",
    "Family Package"
]


BOOKING_COUNT = 50000

BOOKING_STATUS = [
    "Completed",
    "Confirmed",
    "Cancelled"
]

BOOKING_CHANNELS = [
    "Website",
    "Mobile App",
    "Booking.com",
    "Expedia",
    "Travel Agent",
    "Walk-In"
]

CURRENCIES = [
    "INR",
    "USD",
    "EUR",
    "GBP",
    "AED",
    "SGD"
]