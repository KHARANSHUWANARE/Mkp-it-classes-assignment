/*1.Retrieve the total revenue generated for each film category.*/

SELECT c.category_id, SUM(p.amount) AS total_revenue
FROM category c
JOIN film_category c2 ON c.category_id = c2.category_id
JOIN film f ON f.film_id = c2.film_id
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN payment p ON p.rental_id = r.rental_id
GROUP BY c.category_id;


/*2.Determine the count of rentals for each customer.*/
select c.first_name,count(rental_id)
from customer c
join rental r
on r.customer_id=c.customer_id
group by c.customer_id;

/*3.Calculate the average rental duration (in days) for each film.
*/
select f.film_id,avg(f.rental_duration)
from film as f
group by f.film_id;

/*4.Find the total revenue generated for each month.
*/
select date_format(payment_date,"%m") as month ,sum(amount)
from payment
group by month

/*5.Determine the total revenue generated by each store.
*/
select sum(p.amount) as totalpayment,s.store_id 
from payment p
join staff s 
on p.staff_id=s.staff_id
join store st
on st.store_id=s.store_id
group by s.store_id 

/*6.Calculate the count of rentals handled by each staff member*/

select r.staff_id,count(r.rental_id)
from staff s
join rental r
on r.staff_id=s.staff_id
group by r.staff_id;

/*7.Compute the average rental rate for each film category.
*/
/*This SQL query retrieves the average rental rate of films in each category. It joins the `category`, `film_category`, and `film` tables based on their respective IDs. The `AVG` function is used to calculate the average rental rate for each category, and the results are grouped by the category name.*/
SELECT
  c.name AS category,
  AVG(f.rental_rate) AS avg_rental_rate
FROM
  category c
  JOIN film_category fc ON c.category_id = fc.category_id
  JOIN film f ON fc.film_id = f.film_id
GROUP BY
  c.name;

/*8.Determine the count of rentals for each film.
*/
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
LEFT JOIN rental r ON f.film_id = r.inventory_id
GROUP BY f.title;

/*9.write a query in mysql for Retrieve the total revenue generated for each city. in sakila database of mysql
*/ 
SELECT sum(p.amount) ,c.city_id
from city c
join address a
on c.city_id=a.city_id
join staff s
on s.address_id=a.address_id
join payment p
on p.staff_id=s.staff_id
group by c.city_id;

/*10.Calculate the count of rentals for each film language.
*/
SELECT l.name, COUNT(r.rental_id) 
FROM language l
JOIN film f ON l.language_id = f.language_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY l.language_id, l.name;