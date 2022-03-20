use tiny_theatre_db;

select * from temp_tiny_theatre;

select distinct theater from temp_tiny_theatre;

select distinct theater, theater_address, theater_phone, theater_email 
from temp_tiny_theatre;

select * from theatre;

insert into theatre (name, address, phone, email)
select distinct theater, theater_address, theater_phone, theater_email 
from temp_tiny_theatre;

select distinct customer_first, customer_last, customer_address, customer_phone, customer_email
from temp_tiny_theatre;

insert into customer (first_name, last_name, address, phone, email)
select distinct customer_first, customer_last, customer_address, customer_phone, customer_email
from temp_tiny_theatre;

select * from customer;

select distinct show_date, `show`   -- ***************************
from temp_tiny_theatre;

insert into `show` (show_date, show_title, theatre_id)
select distinct date, `show`, t.theatre_id
from temp_tiny_theatre tt
join theatre t on tt.theater = t.name;

select * from `show`;

select distinct seat, ticket_price  -- ********************the ticket-id is messed up********************************
from temp_tiny_theatre;

insert into ticket (seat, ticket_price, show_id, customer_id)  -- *******how do you RE_SET the ticket_id if it is a primary key??
select seat, ticket_price, s.show_id, c.customer_id
from temp_tiny_theatre tt
join `show` s on tt.`show` = s.show_title and s.show_date = tt.date
join customer c on tt.customer_email = c.email;

set sql_safe_updates = 0;
delete from ticket;
set sql_safe_updates = 1;

-- *****************************UPDATES*********************************************************
select * from ticket;

-- The Little Fitz's 2021-03-01 performance of The Sky Lit Up is listed with a $20 ticket price. 
-- The actual price is $22.25 because of a visiting celebrity actor. (Customers were notified.) 
-- Update the ticket price for that performance only.
update ticket set
ticket_price = 22.50
where show_id = 5;


-- In the Little Fitz's 2021-03-01 performance of The Sky Lit Up, Pooh Bedburrow and Cullen Guirau 
-- seat reservations aren't in the same row. Adjust seating so all groups are seated together in a row. 
-- This may require updates to all reservations for that performance. Confirm that no seat is double-booked
-- and that everyone who has a ticket is as close to their original seat as possible.

-- c.ids 37 & 38   show id 5 2021-03-01
select * from ticket;
select * from `show`;

 
update ticket set
seat = 'B4'
where ticket_id = 98;


update ticket set
seat = 'A4'
where ticket_id = 101;


update ticket set
seat = 'C2'
where ticket_id = 100;

-- Update Jammie Swindles's phone number from "801-514-8648" to "1-801-EAT-CAKE".
update customer c set
c.phone = "1-801-EAT-CAKE"
where c.customer_id = 48;

-- ****************************DELETES*****************************************************************

-- Delete all single-ticket reservations at the 10 Pin. (You don't have to do it with one query.)
select * from ticket;

delete from ticket
where show_id = 1 and customer_id = 7;
delete from ticket
where show_id = 2 and customer_id = 8;
delete from ticket
where show_id = 2 and customer_id = 10;
delete from ticket
where show_id = 2 and customer_id = 15;
delete from ticket
where show_id = 3 and customer_id = 18;
delete from ticket
where show_id = 3 and customer_id = 19;
delete from ticket
where show_id = 3 and customer_id = 22;
delete from ticket
where show_id = 3 and customer_id = 25;
delete from ticket
where show_id = 4 and customer_id = 26;

-- Delete the customer Liv Egle of Germany. It appears their reservations were an elaborate joke.
delete from ticket where customer_id = 65;
delete from customer where customer_id = 65;



