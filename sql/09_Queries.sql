USE EventTicketingDB;

-- Booking list with customer and event
SELECT b.booking_id, u.name, e.title, b.booking_status
FROM Bookings b
JOIN Users u ON u.user_id = b.user_id
JOIN Events e ON e.event_id = b.event_id
ORDER BY b.booking_id;

-- Bookings for every event
SELECT e.event_id, e.title, COUNT(b.booking_id) AS bookings
FROM Events e
LEFT JOIN Bookings b ON b.event_id = e.event_id
GROUP BY e.event_id, e.title
ORDER BY e.event_id;

-- Available seats for Acoustic Evening
SELECT s.seat_id, s.row_label, s.seat_number, s.seat_type
FROM Seats s
JOIN Events e ON e.venue_id = s.venue_id
WHERE e.event_id = 101
  AND NOT EXISTS (
      SELECT 1 FROM Booking_Seats bs
      WHERE bs.event_id = e.event_id
        AND bs.seat_id = s.seat_id
  )
ORDER BY s.seat_id;

-- Customers without a booking
SELECT u.user_id, u.name
FROM Users u
WHERE NOT EXISTS (
    SELECT 1 FROM Bookings b WHERE b.user_id = u.user_id
)
ORDER BY u.user_id;

-- Bookings above the confirmed-booking average
SELECT booking_id, total_amount
FROM Bookings
WHERE booking_status = 'Confirmed'
  AND total_amount > (
      SELECT AVG(total_amount) FROM Bookings
      WHERE booking_status = 'Confirmed'
  )
ORDER BY total_amount DESC, booking_id;

-- Successful collections by event
SELECT e.event_id, e.title,
       COALESCE(SUM(p.amount), 0) AS collected
FROM Events e
LEFT JOIN Bookings b ON b.event_id = e.event_id
LEFT JOIN Payments p ON p.booking_id = b.booking_id
    AND p.payment_status = 'Successful'
GROUP BY e.event_id, e.title
ORDER BY e.event_id;