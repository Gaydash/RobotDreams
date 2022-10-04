/*
1.
Вивести кількість фільмів в кожній категорії.
Результат відсортувати за спаданням.
*/

select count(film_id) as amount_of_films, category_id
from public.film_category
group by category_id
order by 1 desc; 

-- or

select count(fc.film_id) as amount_of_films, c.name as category_of_film
from public.film_category as fc join public.category as c on fc.category_id = c.category_id 
group by 2 
order by 1 desc;

/*
2.
Вивести 10 акторів, чиї фільми брали на прокат найбільше.
Результат відсортувати за спаданням.
*/

select a.last_name, max(a.first_name), count(r.rental_id)
from public.rental as r left join public.inventory i on r.inventory_id = i.inventory_id 
						left join public.film_actor fa on fa.film_id = i.film_id
						left join public.actor a on a.actor_id = fa.actor_id 
group by 1
order by 3 desc
limit 10;

/*
3.
Вивести категорія фільмів, на яку було витрачено найбільше грошей
в прокаті
*/

select sum(p.amount) as amount_of_money, c.name as category_name
from 
public.payment as p left join public.rental as r on p.rental_id = r.rental_id
					left join public.inventory i on r.inventory_id = i.inventory_id 
					left join public.film_category as fc on fc.film_id = i.film_id 
					left join public.category as c on fc.category_id = c.category_id 
group by 2
order by 1 desc
limit 1;
					
/*
4.
Вивести назви фільмів, яких не має в inventory.
Запит має бути без оператора IN
*/
select f.title as film_name
from public.film f left join public.inventory i on f.film_id = i.film_id
where i.inventory_id is null;

/*
5.
Вивести топ 3 актори, які найбільше зʼявлялись в категорії фільмів “Children”.
*/

select a.last_name as actor_last_name, count(fc.film_id) 
from public.film_category as fc left join public.category as c on fc.category_id = c.category_id
			left join public.film_actor as fa on fc.film_id = fa.film_id
			left join public.actor as a on fa.actor_id = a.actor_id
where c."name" = 'Children'
group by 1 
order by 2 desc 
limit 3;


/*
6.
Вивести міста з кількістю активних та неактивних клієнтів
(в активних customer.active = 1).
Результат відсортувати за кількістю неактивних клієнтів за спаданням.
*/

select *
from 
(select c2.city as city, count(c.customer_id) as amount_inactive_customers
from public.customer as c left join public.address a on c.address_id = a.address_id 
					left join public.city c2 on a.city_id = c2.city_id 
where c.active = 0
group by 1) as inactive  
full outer join 
(select c2.city as city, count(*) as amount_active_customers
from public.customer as c left join public.address a on c.address_id = a.address_id 
					left join public.city c2 on a.city_id = c2.city_id 
where c.active = 1
group by 1) as active on active.city = inactive.city 
order by 2 desc



