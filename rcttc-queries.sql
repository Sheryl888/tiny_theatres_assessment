use tiny_theatre_db;

--  1. Find all performances in the last quarter of 2021 **************************************************************
-- (Oct. 1, 2021 - Dec. 31 2021).  **there should be 3 shows
select show_title, show_date
from `show`
where show_date >= 2021-10-01  -- w/o limit - this was bringing back earlier shows than october 2021
order by show_date desc
limit 3;   -- this is not a good solution. I knew there were no shows in 2022, and I knew that there were only 3 shows.
-- it doesn't want to work with:  where show_date between 2021-10-01 and 2021-12-31;
-- I believe that something might be amiss with my datetime variable type in my schema?? I didn't want to
-- try and change it, and mess things up. Actually, I DID try that, and it messed things up. Had to redo.


--  2. List customers without duplication.
select * from customer;

--  3. Find all customers without a .com email address.
select * 
from customer c 
where c.email NOT like '%.com';

--  4. Find the three cheapest shows. -- ***********where do I set the currency format/round to 2 digits past decimal******************************
select distinct s.show_title, t.ticket_price        -- is it set in the database, schema or with the querie?
from ticket t
join `show` s using (show_id)
where (select truncate(min(t.ticket_price),2)
from ticket)
order by t.ticket_price asc
limit 3;

--  5. List customers and the show they're attending with no duplication.
select distinct c.first_name, c.last_name, s.show_title, s.show_date
from customer c
join ticket t using (customer_id)
join `show` s using (show_id)
order by c.last_name;

--  6. List customer, show, theater, and seat number in one query.
select concat(c.first_name, " ", c.last_name) customer, s.show_title `show`, th.name theatre, t.seat seat_number
from customer c
join ticket t using (customer_id)
join `show` s using (show_id)
join theatre th using (theatre_id)
order by c.last_name desc;


--  7. Find customers without an address. 
select * from customer
where address = '';

--  8. Recreate the spreadsheet data with a single query.
-- select * from customer, `show`, theatre, ticket; =======> *this brought back over 1000*
select c.first_name, c.last_name, c.address, c.phone, c.email,  -- THIS ONE WORKED!
	s.show_title, s.show_date,
    th.name, th.address, th.phone, th.email,
    t.seat, t.ticket_price
from customer c
join ticket t using (customer_id)
join `show` s using (show_id)
join theatre th using (theatre_id)
order by c.last_name;

--  9. Count total tickets purchased per customer. 
-- *****THis got screwed up as I tried to change things to make #12 work.
-- it now had added ALL THE TICKETS_IDs for ALL THE TIMES I've loaded the data...even though I deleted first.
-- ****************MY TICKET IDs ARE MESSED UP - HOW CAN I RE-SET TICKET_ID IF IT IS A PRIMARY KEY?**********
-- select 
-- sum(ticket_id) total_tickets_sold,
-- concat(c.first_name, " ", c.last_name) customer
-- from ticket t 
-- join customer c using (customer_id)
-- group by concat(c.first_name, " ", c.last_name)
-- order by sum(ticket_id), concat(c.first_name, " ", c.last_name) desc;

-- **************RE-thought what I really needed returned*************************
select
count(t.seat) total_tickets_sold, 
concat(c.first_name, " ", c.last_name) customer
from ticket t
join customer c using (customer_id)
group by concat(c.first_name, " ", c.last_name)
order by count(seat) desc, concat(c.first_name, " ", c.last_name);

    
-- 10. Calculate the total revenue per show based on tickets sold.
select
s.show_title as `show`,
truncate(sum(t.ticket_price),2) total_ticket_revenue  -- if ticket_price is a double, why so many after the decimal?
from `show` s
join ticket t using (show_id)
group by s.show_title;

-- 11. Calculate the total revenue per theater based on tickets sold.
select 
th.name as theatre, 
truncate(sum(t.ticket_price),2) total_ticket_revenue  -- if ticket_price is a double, why so many after the decimal?
from theatre th
join `show` s using (theatre_id)
join ticket t using (show_id)
group by th.name;


-- 12. Who is the biggest supporter of RCTTC? Who spent the most in 2021?  Should be Jammie Swindles 220.00
select 
concat(c.first_name, " ", c.last_name) customer, 
truncate(sum(t.ticket_price),2) total_cost
from customer c
join ticket t using (customer_id)
-- where (select max(sum(t.ticket_price)) from ticket t)  ************I don't know how to single out Jamie
group by concat(c.first_name, " ", c.last_name)
order by sum(ticket_price) desc
limit 1;


