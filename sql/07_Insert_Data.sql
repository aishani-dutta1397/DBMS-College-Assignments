USE EventTicketingDB;
START TRANSACTION;

INSERT INTO Users
    (user_id, name, phone, email, password_hash, created_at)
VALUES
(1, 'Ananya', '0000000001', 'ananya@example.com', 'demo_hash_01', '2026-09-01 09:00:00'),
(2, 'Riya', '0000000002', 'riya@example.com', 'demo_hash_02', '2026-09-01 09:00:00'),
(3, 'Soham', '0000000003', 'soham@example.com', 'demo_hash_03', '2026-09-01 09:00:00'),
(4, 'Ishaan', '0000000004', 'ishaan@example.com', 'demo_hash_04', '2026-09-01 09:00:00'),
(5, 'Mitali', '0000000005', 'mitali@example.com', 'demo_hash_05', '2026-09-01 09:00:00'),
(6, 'Tanya', '0000000006', 'tanya@example.com', 'demo_hash_06', '2026-09-01 09:00:00'),
(7, 'Nikhil', '0000000007', 'nikhil@example.com', 'demo_hash_07', '2026-09-01 09:00:00'),
(8, 'Pooja', '0000000008', 'pooja@example.com', 'demo_hash_08', '2026-09-01 09:00:00');

INSERT INTO Venues
    (venue_id, name, address, city, total_capacity)
VALUES
(1, 'Lakeview Hall', '12 Lake Road', 'Bengaluru', 6),
(2, 'Riverside Theatre', '8 River Lane', 'Kolkata', 6),
(3, 'City Studio', '21 Station Road', 'Pune', 6);

INSERT INTO Seats
    (seat_id, venue_id, section, row_label, seat_number, seat_type)
VALUES
(1, 1, 'Main', 'A', '1', 'Premium'),
(2, 1, 'Main', 'A', '2', 'Premium'),
(3, 1, 'Main', 'A', '3', 'Premium'),
(4, 1, 'Main', 'B', '1', 'Regular'),
(5, 1, 'Main', 'B', '2', 'Regular'),
(6, 1, 'Main', 'B', '3', 'Regular'),
(7, 2, 'Main', 'A', '1', 'Premium'),
(8, 2, 'Main', 'A', '2', 'Premium'),
(9, 2, 'Main', 'A', '3', 'Premium'),
(10, 2, 'Main', 'B', '1', 'Regular'),
(11, 2, 'Main', 'B', '2', 'Regular'),
(12, 2, 'Main', 'B', '3', 'Regular'),
(13, 3, 'Main', 'A', '1', 'Premium'),
(14, 3, 'Main', 'A', '2', 'Premium'),
(15, 3, 'Main', 'A', '3', 'Premium'),
(16, 3, 'Main', 'B', '1', 'Regular'),
(17, 3, 'Main', 'B', '2', 'Regular'),
(18, 3, 'Main', 'B', '3', 'Regular');

INSERT INTO Events
    (event_id, venue_id, title, category, event_date, start_time, description)
VALUES
(101, 1, 'Acoustic Evening', 'Concert', '2026-11-05', '18:00:00', 'An evening of acoustic music'),
(102, 2, 'The Last Letter', 'Theatre', '2026-11-07', '17:30:00', 'A student theatre performance'),
(103, 3, 'Design Meetup', 'Conference', '2026-11-08', '10:00:00', 'Design talks and discussion'),
(104, 1, 'Jazz Night', 'Concert', '2026-11-12', '19:00:00', 'A live jazz performance'),
(105, 2, 'Comedy Hour', 'Comedy', '2026-11-14', '18:30:00', 'An evening comedy show');

INSERT INTO Bookings
    (booking_id, user_id, event_id, booking_time, total_amount, booking_status)
VALUES
(201, 1, 101, '2026-10-10 10:00:00', 1000, 'Confirmed'),
(202, 2, 101, '2026-10-10 11:00:00', 300, 'Confirmed'),
(203, 3, 102, '2026-10-11 09:00:00', 800, 'Confirmed'),
(204, 4, 102, '2026-10-11 12:00:00', 250, 'Pending'),
(205, 1, 103, '2026-10-12 10:00:00', 600, 'Confirmed'),
(206, 5, 104, '2026-10-12 13:00:00', 1200, 'Confirmed'),
(207, 6, 104, '2026-10-13 10:00:00', 350, 'Pending'),
(208, 2, 103, '2026-10-13 11:00:00', 200, 'Confirmed'),
(209, 3, 104, '2026-10-14 09:00:00', 0, 'Cancelled'),
(210, 4, 101, '2026-10-14 12:00:00', 300, 'Confirmed');

INSERT INTO Booking_Seats
    (booking_seat_id, booking_id, seat_id, event_id, price, ticket_code)
VALUES
(301, 201, 1, 101, 500, 'TKT-301'),
(302, 201, 2, 101, 500, 'TKT-302'),
(303, 202, 4, 101, 300, 'TKT-303'),
(304, 203, 7, 102, 400, 'TKT-304'),
(305, 203, 8, 102, 400, 'TKT-305'),
(306, 204, 10, 102, 250, 'TKT-306'),
(307, 205, 13, 103, 300, 'TKT-307'),
(308, 205, 14, 103, 300, 'TKT-308'),
(309, 206, 1, 104, 600, 'TKT-309'),
(310, 206, 2, 104, 600, 'TKT-310'),
(311, 207, 4, 104, 350, 'TKT-311'),
(312, 208, 16, 103, 200, 'TKT-312'),
(313, 210, 5, 101, 300, 'TKT-313');

INSERT INTO Payments
    (payment_id, booking_id, amount, payment_method, payment_status, paid_at)
VALUES
(401, 201, 1000, 'UPI', 'Successful', '2026-10-10 10:02:00'),
(402, 202, 300, 'Card', 'Failed', NULL),
(403, 202, 300, 'UPI', 'Successful', '2026-10-10 11:05:00'),
(404, 203, 800, 'Card', 'Successful', '2026-10-11 09:02:00'),
(405, 204, 250, 'UPI', 'Pending', NULL),
(406, 205, 600, 'Net Banking', 'Successful', '2026-10-12 10:03:00'),
(407, 206, 1200, 'Card', 'Successful', '2026-10-12 13:02:00'),
(408, 207, 350, 'UPI', 'Failed', NULL),
(409, 208, 200, 'UPI', 'Successful', '2026-10-13 11:02:00'),
(410, 210, 300, 'Card', 'Successful', '2026-10-14 12:02:00');

COMMIT;
