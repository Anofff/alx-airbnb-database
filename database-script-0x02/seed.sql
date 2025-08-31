-- ========================
-- Users (Guests, Hosts, Admins)
-- ========================
INSERT INTO users (user_id, first_name, last_name, email, password_hash, role)
VALUES
  ('u1', 'Alice', 'Wong', 'alice@example.com', 'hash_pw1', 'guest'),
  ('u2', 'Bob', 'Smith', 'bob@example.com', 'hash_pw2', 'host'),
  ('u3', 'Charlie', 'Johnson', 'charlie@example.com', 'hash_pw3', 'guest'),
  ('u4', 'Diana', 'Prince', 'diana@example.com', 'hash_pw4', 'admin');

-- ========================
-- Properties
-- ========================
INSERT INTO properties (property_id, host_id, name, description, location, price_per_night)
VALUES
  ('p1', 'u2', 'Cozy Apartment', '2-bedroom apartment in city center', 'New York', 120.00),
  ('p2', 'u2', 'Beach House', 'House with sea view and pool', 'Miami', 250.00);

-- ========================
-- Bookings
-- ========================
INSERT INTO bookings (booking_id, property_id, guest_id, start_date, end_date, status)
VALUES
  ('b1', 'p1', 'u1', '2025-08-01', '2025-08-05', 'confirmed'),
  ('b2', 'p2', 'u3', '2025-08-10', '2025-08-15', 'pending');

-- ========================
-- Payments
-- ========================
INSERT INTO payments (payment_id, booking_id, amount, method, status)
VALUES
  ('pay1', 'b1', 480.00, 'credit_card', 'completed'),
  ('pay2', 'b2', 1250.00, 'paypal', 'pending');

-- ========================
-- Reviews
-- ========================
INSERT INTO reviews (review_id, booking_id, user_id, rating, comment)
VALUES
  ('r1', 'b1', 'u1', 5, 'Amazing place, very clean and close to everything!');

-- ========================
-- Messages
-- ========================
INSERT INTO messages (message_id, sender_id, receiver_id, booking_id, content)
VALUES
  ('m1', 'u1', 'u2', 'b1', 'Hi Bob, looking forward to my stay!'),
  ('m2', 'u2', 'u1', 'b1', 'Welcome Alice, see you soon!');
