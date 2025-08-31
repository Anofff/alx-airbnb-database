# Airbnb Clone Database Schema (DDL)

This folder contains the SQL schema definition for the Airbnb Clone project.

## Files
- `schema.sql` → Contains the SQL `CREATE TABLE` statements for all entities (Users, Properties, Bookings, Payments, Reviews, Messages).
- `README.md` → This documentation file.

## Entities
- **Users** → Guests, Hosts, Admins
- **Properties** → Listings owned by Hosts
- **Bookings** → Reservations made by Guests for Properties
- **Payments** → Payments tied to Bookings
- **Reviews** → Feedback left by Guests, linked to a specific Booking (and therefore to a Property)
- **Messages** → Communication between Users 

## Constraints
- **Primary Keys** (`PRIMARY KEY`) uniquely identify each row.  
- **Foreign Keys** (`FOREIGN KEY`) enforce relationships:
  - Properties → Users (host owns property)
  - Bookings → Users (guest) & Properties
  - Payments → Bookings
  - Reviews → Users & Bookings
  - Messages → Users (sender & receiver) and Bookings
- **Unique Constraints**:
  - One review per user per booking (enforces Airbnb’s "one review per stay" rule).
- **Check Constraints** validate:
  - Ratings must be between `1` and `5`.
  - Booking dates must satisfy `start_date < end_date`.
  - Prices and payment amounts must be positive.

## Indexes
Indexes added for performance on frequently queried columns:
- `users.email`
- `properties.location`
- Foreign keys in `bookings`, `payments`, `reviews`, and `messages`

## How to Run
Run the schema file in MySQL:
```bash
mysql -u root -p < schema.sql
