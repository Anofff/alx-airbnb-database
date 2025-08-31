-- Airbnb Clone Database Schema
-- Task 2: Create tables, constraints, and indexes

-- Drop existing tables (for reruns)
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS properties;
DROP TABLE IF EXISTS users;

-- ========================
-- Users Table
-- ========================
CREATE TABLE users (
  user_id CHAR(36) PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('guest','host','admin') NOT NULL DEFAULT 'guest',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================
-- Properties Table
-- ========================
CREATE TABLE properties (
  property_id CHAR(36) PRIMARY KEY,
  host_id CHAR(36) NOT NULL,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  location VARCHAR(100) NOT NULL,
  price_per_night DECIMAL(10,2) NOT NULL CHECK (price_per_night >= 0),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (host_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- ========================
-- Bookings Table
-- ========================
CREATE TABLE bookings (
  booking_id CHAR(36) PRIMARY KEY,
  property_id CHAR(36) NOT NULL,
  guest_id CHAR(36) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status ENUM('pending','confirmed','cancelled') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
  FOREIGN KEY (guest_id) REFERENCES users(user_id) ON DELETE CASCADE,
  CHECK (start_date < end_date)
);

-- ========================
-- Payments Table
-- ========================
CREATE TABLE payments (
  payment_id CHAR(36) PRIMARY KEY,
  booking_id CHAR(36) NOT NULL,
  amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  method ENUM('credit_card','paypal','bank_transfer') NOT NULL,
  status ENUM('pending','completed','failed') NOT NULL DEFAULT 'pending',
  FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE
);

-- ========================
-- Reviews Table 
-- ========================
CREATE TABLE reviews (
  review_id CHAR(36) PRIMARY KEY,
  booking_id CHAR(36) NOT NULL,
  user_id CHAR(36) NOT NULL,
  rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  UNIQUE (booking_id, user_id) -- one review per user per booking
);

-- ========================
-- Messages Table
-- ========================
CREATE TABLE messages (
  message_id CHAR(36) PRIMARY KEY,
  sender_id CHAR(36) NOT NULL,
  receiver_id CHAR(36) NOT NULL,
  booking_id CHAR(36),
  content TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sender_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (receiver_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE
);

-- ========================
-- Indexes for performance
-- ========================
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_property_location ON properties(location);
CREATE INDEX idx_booking_user ON bookings(guest_id);
CREATE INDEX idx_booking_property ON bookings(property_id);
CREATE INDEX idx_payment_booking ON payments(booking_id);
CREATE INDEX idx_review_booking ON reviews(booking_id);
CREATE INDEX idx_message_sender ON messages(sender_id);
CREATE INDEX idx_message_receiver ON messages(receiver_id);
