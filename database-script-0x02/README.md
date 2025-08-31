# Airbnb Clone Database Seeding (Task 3)

This folder contains SQL scripts to populate the Airbnb Clone database with realistic sample data.

## Files
- `seed.sql` → Contains `INSERT` statements to add sample users, properties, bookings, payments, reviews, and messages.
- `README.md` → This documentation file.

## Sample Data
- **Users** → Guests, Hosts, and Admins
- **Properties** → Listings owned by Hosts
- **Bookings** → Reservations created by Guests
- **Payments** → Linked to Bookings
- **Reviews** → One review per booking (by the guest)
- **Messages** → Communication between guests and hosts

## How to Run
Run the seed script after creating the schema:
```bash
mysql -u root -p < ../database-script-0x01/schema.sql
mysql -u root -p < seed.sql
