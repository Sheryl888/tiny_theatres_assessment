use tiny_theatre_db;

select * from temp_tiny_theatre;

select distinct theater from temp_tiny_theatre;

select distinct theater, theater_address, theater_phone, theater_email 
from temp_tiny_theatre;

insert into theatre (name, address, phone, email)
select distinct theater, theater_address, theater_phone, theater_email 
from temp_tiny_theatre;

select distinct customer_first, customer_last, customer_address, customer_phone, customer_email
from temp_tiny_theatre;

insert into customer (first_name, last_name, address, phone, email)
select distinct customer_first, customer_last, customer_address, customer_phone, customer_email
from temp_tiny_theatre;

select * from customer;

select distinct date, `show`
from temp_tiny_theatre;

insert into `show` (show_date, show_title, theatre_id)
select distinct date, `show`, t.theatre_id
from temp_tiny_theatre tt
join theatre t on tt.theater = t.name;

select * from `show`;

select distinct seat, ticket_price
from temp_tiny_theatre;

insert into ticket (seat, ticket_price, show_id, customer_id)
select distinct seat, ticket_price, s.show_id, c.customer_id
from temp_tiny_theatre tt
join `show` s on tt.`show` = s.show_title
join customer c on tt.customer_email = c.email;

select * from ticket;






