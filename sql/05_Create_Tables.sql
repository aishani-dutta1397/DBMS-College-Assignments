CREATE DATABASE EventTicketingDB CHARACTER SET utf8mb4;
USE EventTicketingDB;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE Venues (
    venue_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    city VARCHAR(60) NOT NULL,
    total_capacity INT NOT NULL,
    CONSTRAINT positive_capacity CHECK (total_capacity > 0)
) ENGINE=InnoDB;

CREATE TABLE Seats (
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    venue_id INT NOT NULL,
    section VARCHAR(40) NOT NULL,
    row_label VARCHAR(10) NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    seat_type VARCHAR(15) NOT NULL DEFAULT 'Regular',
    CONSTRAINT seat_location UNIQUE
        (venue_id, section, row_label, seat_number),
    CONSTRAINT valid_seat_type CHECK
        (seat_type IN ('Regular', 'Premium', 'VIP')),
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE Events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    venue_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    category VARCHAR(40) NOT NULL,
    event_date DATE NOT NULL,
    start_time TIME NOT NULL,
    description VARCHAR(255),
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    event_id INT NOT NULL,
    booking_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    booking_status VARCHAR(15) NOT NULL DEFAULT 'Pending',
    UNIQUE KEY booking_event (booking_id, event_id),
    CONSTRAINT nonnegative_total CHECK (total_amount >= 0),
    CONSTRAINT valid_booking_status CHECK
        (booking_status IN ('Pending', 'Confirmed', 'Cancelled')),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON DELETE RESTRICT,
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE Booking_Seats (
    booking_seat_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    seat_id INT NOT NULL,
    event_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    ticket_code VARCHAR(40) NOT NULL UNIQUE,
    CONSTRAINT one_seat_per_event UNIQUE (event_id, seat_id),
    CONSTRAINT nonnegative_price CHECK (price >= 0),
    FOREIGN KEY (booking_id, event_id)
        REFERENCES Bookings(booking_id, event_id)
        ON DELETE RESTRICT,
    FOREIGN KEY (seat_id) REFERENCES Seats(seat_id)
        ON DELETE RESTRICT,
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    payment_status VARCHAR(15) NOT NULL DEFAULT 'Pending',
    paid_at DATETIME,
    CONSTRAINT positive_payment CHECK (amount > 0),
    CONSTRAINT valid_payment_method CHECK
        (payment_method IN ('UPI', 'Card', 'Net Banking')),
    CONSTRAINT valid_payment_status CHECK
        (payment_status IN ('Pending', 'Successful',
                            'Failed', 'Refunded')),
    CONSTRAINT payment_time CHECK
        (payment_status NOT IN ('Successful', 'Refunded')
         OR paid_at IS NOT NULL),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
        ON DELETE RESTRICT
) ENGINE=InnoDB;
