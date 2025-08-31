# Normalization of the Airbnb Clone Database

This document explains how the **Airbnb Clone** database design satisfies the rules of normalization, up to the **Third Normal Form (3NF)**.

---

## First Normal Form (1NF)

**Rule:** Eliminate repeating groups; ensure attributes are atomic.

- **Users:** Each field (`first_name`, `last_name`, `email`, etc.) holds atomic values. No multi-valued columns.  
- **Properties:** Attributes such as `name`, `description`, `location`, and `price_per_night` are indivisible.  
- **Bookings:** Each record contains one property, one user, one `start_date`, one `end_date`. No repeating groups.  
- **Payments, Reviews, Messages:** Each attribute is atomic (e.g., a single payment amount, a single rating).  

**Result:** The schema is in 1NF.

---

## Second Normal Form (2NF)

**Rule:** Already in 1NF, and all non-key attributes must depend on the whole primary key (no partial dependency).

- All tables use a **single-column primary key (UUIDs)** such as `user_id`, `property_id`, `booking_id`.  
- Because there are no composite keys, **partial dependency cannot occur**.  
- **Example:** In **Bookings**, `start_date`, `end_date`, and `status` all depend on `booking_id`.  

**Result:** The schema is in 2NF.

---

## Third Normal Form (3NF)

**Rule:** Already in 2NF, and no non-key attribute depends on another non-key attribute (no transitive dependency).

- **Users:** Attributes (`email`, `password_hash`, `role`, etc.) depend only on `user_id`. No transitive dependency.  
- **Properties:** Attributes (`host_id`, `name`, `location`, `price_per_night`, etc.) depend only on `property_id`.  
- **Bookings:**  
  - `start_date`, `end_date`, and `status` depend directly on `booking_id`.  
  - `total_price` is a **special case**:  
    - It can be derived from `(end_date - start_date) × price_per_night`.  
    - If kept, it introduces a transitive dependency.  
    - If removed, the database remains in strict 3NF.  
    - **Decision:** Keep `total_price` for performance reasons, but ensure the application **calculates and validates** it to avoid inconsistency.  
- **Payments, Reviews, Messages:** All attributes depend solely on their primary keys.  

**Result:** With the exception of the controlled redundancy in `total_price`, the schema is in 3NF.

---

## Conclusion

The **Airbnb Clone** database design follows normalization principles up to **Third Normal Form (3NF).**

- **1NF:** All attributes are atomic.  
- **2NF:** No partial dependencies, since all primary keys are single-column.  
- **3NF:** No transitive dependencies, except for `total_price` (kept for performance).  

This ensures the database is:

- Free from redundancy  
- Consistent and reliable  
- Scalable for real-world Airbnb-like usage  
