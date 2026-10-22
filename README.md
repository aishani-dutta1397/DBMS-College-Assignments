EVENT TICKETING ASSIGNMENTS 3-9

Seven separate PDFs are included for upload. They use the seven-table design
from the existing Event Ticketing assignment.

MySQL scripts are in the SQL folder. Use MySQL 8.0.16 or later and run:
1. 05_Create_Tables.sql
2. 06_Venue_Rules.sql
3. 07_Insert_Data.sql
4. 08_Queries.sql and 09_Queries.sql
5. Each block of 06_Check_Constraints.sql separately.

Use a fresh database and run the creation/data scripts once. Invalid constraint
tests deliberately produce errors. Continue to ROLLBACK after each expected
error so the original sample records remain unchanged.

The scripts were executed on MySQL 8.0.46. The sample has 67 rows across seven
tables. Successful payments total Rs. 4,400. Twelve rejection tests and two
positive tests were checked. Screenshots show saved MySQL execution results
displayed in a browser. They are not MySQL Workbench screenshots.

The password_hash fields contain demonstration placeholders, not login hashes.
Pending bookings hold seats. A cancellation must remove seat allocations and
update the booking total in one transaction. Booking totals and capacity/seat-map
agreement require application checks; they are not enforced by the basic
CHECK constraints. Venue assignment is fixed for existing seat and event rows.
