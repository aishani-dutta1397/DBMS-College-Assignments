USE EventTicketingDB;
-- Run each block separately; errors in rejection tests are expected.

-- Duplicate Primary Key
START TRANSACTION;
INSERT INTO Venues VALUES
(1, 'Test Hall', 'Test Road', 'Pune', 6);
ROLLBACK;

-- Missing parent record
START TRANSACTION;
INSERT INTO Payments
(payment_id, booking_id, amount, payment_method)
VALUES (999, 999, 100, 'UPI');
ROLLBACK;

-- Duplicate email
START TRANSACTION;
UPDATE Users SET email = 'ananya@example.com'
WHERE user_id = 2;
ROLLBACK;

-- Duplicate ticket code
START TRANSACTION;
UPDATE Booking_Seats SET ticket_code = 'TKT-301'
WHERE booking_seat_id = 302;
ROLLBACK;

-- Seat already booked for the event
START TRANSACTION;
INSERT INTO Booking_Seats VALUES
(999, 201, 1, 101, 500, 'TEST-999');
ROLLBACK;

-- Booking and ticket refer to different events
START TRANSACTION;
INSERT INTO Booking_Seats VALUES
(999, 201, 3, 104, 500, 'TEST-999');
ROLLBACK;

-- Negative ticket price
START TRANSACTION;
UPDATE Booking_Seats SET price = -50
WHERE booking_seat_id = 301;
ROLLBACK;

-- Invalid booking status
START TRANSACTION;
UPDATE Bookings SET booking_status = 'Done'
WHERE booking_id = 201;
ROLLBACK;

-- Seat from a different venue
START TRANSACTION;
INSERT INTO Booking_Seats VALUES
(999, 201, 9, 101, 500, 'TEST-999');
ROLLBACK;

-- Parent with booking history
START TRANSACTION;
DELETE FROM Users WHERE user_id = 1;
ROLLBACK;

-- Required customer name
START TRANSACTION;
UPDATE Users SET name = NULL WHERE user_id = 1;
ROLLBACK;

-- Default values for a new booking
START TRANSACTION;
INSERT INTO Bookings (booking_id, user_id, event_id)
VALUES (999, 7, 105);
SELECT booking_id, total_amount, booking_status
FROM Bookings WHERE booking_id = 999;
ROLLBACK;

-- Valid seat for the same event
START TRANSACTION;
INSERT INTO Booking_Seats VALUES
(999, 201, 3, 101, 500, 'TEST-999');
SELECT booking_id, seat_id, event_id
FROM Booking_Seats WHERE booking_seat_id = 999;
ROLLBACK;

-- Protect the event venue
START TRANSACTION;
UPDATE Events SET venue_id = 2 WHERE event_id = 101;
ROLLBACK;