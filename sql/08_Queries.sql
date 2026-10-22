USE EventTicketingDB;

-- Show confirmed bookings
SELECT booking_id, user_id, total_amount
FROM Bookings
WHERE booking_status = 'Confirmed'
ORDER BY booking_id;

-- List the next events
SELECT event_id, title, event_date
FROM Events
WHERE event_date >= '2026-11-01'
ORDER BY event_date, start_time, event_id;

-- Count bookings by status
SELECT booking_status, COUNT(*) AS booking_count
FROM Bookings
GROUP BY booking_status
ORDER BY booking_status;

-- Find events with at least three bookings
SELECT event_id, COUNT(*) AS booking_count
FROM Bookings
GROUP BY event_id
HAVING COUNT(*) >= 3
ORDER BY event_id;

-- Calculate successful payment totals
SELECT COUNT(*) AS payments,
       SUM(amount) AS total_received,
       ROUND(AVG(amount), 2) AS average_amount,
       MIN(amount) AS smallest,
       MAX(amount) AS largest
FROM Payments
WHERE payment_status = 'Successful';

-- Change an event start time
START TRANSACTION;
UPDATE Events SET start_time = '19:30:00'
WHERE event_id = 105;
SELECT event_id, title, start_time
FROM Events WHERE event_id = 105;
ROLLBACK;