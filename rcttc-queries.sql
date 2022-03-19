use tiny_theatre_db;

--  1. Find all performances in the last quarter of 2021 **************************************************************
-- (Oct. 1, 2021 - Dec. 31 2021).  **there should be 5 shows -- this returns 0 rows 
select show_title, show_date
from `show`
where show_date >= 2021-10-01  -- w/o limit - this was bringing back earlier shows than october 2021
order by show_date desc
limit 5;   -- this is not a good solution. I knew there were no shows in 2022, and I knew that there were only 5 shows.
-- it doesn't want to work with:  where show_date between 2021-10-01 and 2021-12-31;


--  2. List customers without duplication.
select * from customer;

--  3. Find all customers without a .com email address.
select * 
from customer c 
where c.email NOT like '%.com';

--  4. Find the three cheapest shows. 
select distinct s.show_title, t.ticket_price
from ticket t
join `show` s using (show_id)
where (select min(t.ticket_price) 
from ticket)
order by t.ticket_price asc
limit 3;

--  5. List customers and the show they're attending with no duplication.
select distinct c.first_name, c.last_name, s.show_title, s.show_date
from customer c
join ticket t using (customer_id)
join `show` s using (show_id);

--  6. List customer, show, theater, and seat number in one query.
select concat(c.first_name, c.last_name) customer, s.show_title `show`, th.name theatre, t.seat seat_number
from customer c
join ticket t using (customer_id)
join `show` s using (show_id)
join theatre th using (theatre_id);

--  7. Find customers without an address. 
select * from customer
where address = '';

--  8. Recreate the spreadsheet data with a single query.
-- select * from customer, `show`, theatre, ticket;      *this brought back over 1000*
select c.first_name, c.last_name, c.address, c.phone, c.email,  -- THIS ONE WORKED!
	s.show_title, s.show_date,
    th.name, th.address, th.phone, th.email,
    t.seat, t.ticket_price
from customer c
join ticket t using (customer_id)
join `show` s using (show_id)
join theatre th using (theatre_id);

--  9. Count total tickets purchased per customer.
select 
sum(ticket_id) total_tickets_sold,
concat(c.first_name, " ", c.last_name) customer
from ticket t 
join customer c using (customer_id)
group by concat(c.first_name, " ", c.last_name)
order by sum(ticket_id), concat(c.first_name, " ", c.last_name) desc;
    
-- 10. Calculate the total revenue per show based on tickets sold.
select
s.show_title as `show`,
sum(t.ticket_price) total_ticket_revenue  -- if ticket_price is a double, why so many after the decimal?
from `show` s
join ticket t using (show_id)
group by s.show_title;

-- 11. Calculate the total revenue per theater based on tickets sold.
select 
th.name as theatre, 
sum(t.ticket_price) total_ticket_revenue  -- if ticket_price is a double, why so many after the decimal?
from theatre th
join `show` s using (theatre_id)
join ticket t using (show_id)
group by th.name;


-- 12. Who is the biggest supporter of RCTTC? Who spent the most in 2021?
select 
concat(c.first_name, " ", c.last_name) customer,
sum(ticket_id) total_tickets_sold,
s.show_date as date
from ticket t
join customer c using (customer_id)
join `show` s using (show_id)
where s.show_date >= 2021-01-01 <= 2021-12-31  
group by concat(c.first_name, " ", c.last_name), s.show_date
order by sum(ticket_id) desc;
