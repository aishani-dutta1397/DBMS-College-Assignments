USE EventTicketingDB;
DELIMITER //
CREATE TRIGGER check_seat_insert
BEFORE INSERT ON Booking_Seats
FOR EACH ROW
BEGIN
    DECLARE seat_venue INT;
    DECLARE event_venue INT;
    SELECT venue_id INTO seat_venue FROM Seats
        WHERE seat_id = NEW.seat_id FOR SHARE;
    SELECT venue_id INTO event_venue FROM Events
        WHERE event_id = NEW.event_id FOR SHARE;
    IF seat_venue IS NOT NULL AND event_venue IS NOT NULL
       AND seat_venue <> event_venue THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Seat belongs to another venue';
    END IF;
END//

CREATE TRIGGER check_seat_update
BEFORE UPDATE ON Booking_Seats
FOR EACH ROW
BEGIN
    DECLARE seat_venue INT;
    DECLARE event_venue INT;
    SELECT venue_id INTO seat_venue FROM Seats
        WHERE seat_id = NEW.seat_id FOR SHARE;
    SELECT venue_id INTO event_venue FROM Events
        WHERE event_id = NEW.event_id FOR SHARE;
    IF seat_venue IS NOT NULL AND event_venue IS NOT NULL
       AND seat_venue <> event_venue THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Seat belongs to another venue';
    END IF;
END//

CREATE TRIGGER keep_seats_venue
BEFORE UPDATE ON Seats
FOR EACH ROW
BEGIN
    IF NEW.venue_id <> OLD.venue_id THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Venue cannot be changed';
    END IF;
END//

CREATE TRIGGER keep_events_venue
BEFORE UPDATE ON Events
FOR EACH ROW
BEGIN
    IF NEW.venue_id <> OLD.venue_id THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Venue cannot be changed';
    END IF;
END//

DELIMITER ;
