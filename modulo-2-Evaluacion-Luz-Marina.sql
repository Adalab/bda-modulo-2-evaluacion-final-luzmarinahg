USE sakila; -- Lo primero que hacemos es llamar a la BBDD que vamos a utilizar, en este caso sakila

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
SELECT *
FROM film; -- Así podemos ver todos los elementos dentro de la tabla "film" que elementos tiene y encontar dónde estan los títulos

SELECT DISTINCT title AS Title  -- Usamos DISTINCT para que elimine los duplicados
FROM film;  

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
SELECT * -- Así podemos ver todos los elementos dentro de la tabla "film" que elementos tiene y encontar dónde estan las clasificaciones o "rating"
FROM film;

SELECT title AS Title, rating AS Rating
FROM film
WHERE rating = "PG-13"; -- Aqui le decimos que dentro de la columna rating, solo queremos que nos muestre las clasificaciones PG-13

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
SELECT * -- Así podemos ver todos los elementos dentro de la tabla "film" que elementos tiene y encontar dónde estan las descripciones
FROM film;

SELECT title AS Title, description AS Description /* Queremos ver las descipciones y las peliculas a las que pertenecen*/
FROM film
WHERE description LIKE "%amazing%"; /* Para encontrar dentro de la columna de descripcion la palabra amazing entre varias palabras dentro de la propia descripción*/

-- 4.Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
SELECT *  -- -- Así podemos ver todos los elementos dentro de la tabla "film" que elementos tiene y encontar dónde estan la longitud de la pelicula por minutos
FROM film;

SELECT title AS Title -- Ponemos los titulos para verlos
FROM film
WHERE `length` > 120 -- Aqui buscamos que en la columna donde nos marca la longitud de la pelicula sea mayor a 120 con un >
ORDER BY `length` DESC; -- Para que quede más ordenada  y podamos ver las películas de más larga a más corta pero siempre superior a 120 se ordena con desc

-- 5.Recupera los nombres de todos los actores.
SELECT *
FROM actor; -- Aqui buscamos en la tabla actor donde podemos encontrar el nombre de los actores

SELECT first_name AS NameActorAndActress -- Aqui seleccionamos el nombre de los nombres y actrices y le damos un nombre a la columna
FROM actor;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
SELECT *
FROM actor; -- Aqui buscamos en la tabla actor donde podemos encontrar el apellido de los actores
SELECT CONCAT(first_name," ", last_name) AS FullName  -- Aqui juntamos la columna nombre y la apellido para verlos juntos
FROM actor
WHERE last_name LIKE "Gibson"; -- Aqui le decimos que nos

-- 7.Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
SELECT *
FROM actor;

SELECT actor_id AS IDActor, first_name AS Nombre
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

-- 8.Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
SELECT *
FROM film;

SELECT title AS Title, rating AS Rating
FROM film
WHERE rating NOT IN  ("PG-13","R")
ORDER BY rating;

-- 9.Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento
SELECT *
FROM film;

SELECT COUNT(film_id) AS TotalFilms, rating AS Rating
FROM film
GROUP BY rating
ORDER BY TotalFilms DESC; -- para ver de .-....alter


-- 10.Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y 
-- apellido junto con la cantidad de películas alquiladas.
SELECT cu.customer_id AS IDCliente, COUNT(re.rental_id) AS PeliculasAlquiladas , CONCAT(cu.first_name," ", cu.last_name) AS Cliente
FROM customer AS cu
LEFT JOIN rental AS re
ON cu.customer_id  = re.customer_id
GROUP BY IDCliente
ORDER BY PeliculasAlquiladas DESC;

/* 11.Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto 
con el recuento de alquileres. */
ca.category_id, ca.name  -- category
f.film_id, f.category_id -- film_category
inv.film_id, inv.inventory_id -- inventory
COUNT(re.rental_id), re.film_id -- rental
SELECT COUNT(re.rental_id) AS PeliculasAlquiladas , ca.name AS CategoriaPelicula
FROM category AS ca
INNER JOIN film_category AS f
ON ca.category_id= f.category_id
INNER JOIN inventory AS inv
ON f.film_id = inv.film_id
INNER JOIN rental AS re
ON re.inventory_id = inv.inventory_id
GROUP BY CategoriaPelicula
ORDER BY PeliculasAlquiladas DESC;


/*12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la
clasificación junto con el promedio de duración.*/

SELECT rating AS Clasificacion , ROUND(AVG(length),2) AS DuracionMinutos
FROM film
GROUP BY rating;

/* 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".*/

SELECT f.title AS Title, CONCAT(ac.first_name , " ", ac.last_name)AS NombreActoresActrices
FROM film AS f
INNER JOIN film_actor AS fa
ON f.film_id = fa.film_id
INNER JOIN actor AS ac
ON fa.actor_id = ac.actor_id
WHERE f.title LIKE 'Indian Love'
GROUP BY f.title, ac.actor_id, NombreActoresActrices;


/* 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.*/

SELECT title AS Title, description AS Description
FROM film
WHERE description LIKE "%dog%"OR description LIKE "%cat%";

/*15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.*/
SELECT*
FROM film_actor;

SELECT actor_id, CONCAT(first_name, " ", last_name) AS NombreActores
FROM actor
WHERE actor_id NOT IN (SELECT actor_id FROM film_actor);

/*16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.*/
SELECT * 
FROM film;

SELECT title AS Title, release_year AS ReleaseYear
FROM film
WHERE release_year BETWEEN 2005 AND 2010;
 
 /* 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".*/
SELECT f.title AS Title, ca.name AS Category
FROM category AS ca
INNER JOIN film_category AS fc
ON ca.category_id = fc.category_id
INNER JOIN film AS f
ON fc.film_id = f.film_id
WHERE ca.name = "Family"
GROUP BY f.title,ca.name;

/*18.Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.*/
SELECT CONCAT(a.first_name , " ", a.last_name) AS FullName, COUNT(film_id) AS Film
FROM actor AS a
LEFT JOIN film_actor as fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING COUNT(fa.film_id) > 10
ORDER BY Film DESC;

/*19.Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.*/
SELECT *
FROM film;

SELECT title AS Title
FROM film
WHERE rating = "R" AND `length` > 120;
 
/*20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el
nombre de la categoría junto con el promedio de duración.*/
SELECT*
FROM film;

SELECT ca.name AS CategoryFilm, ROUND(AVG(f.length),2) AS AvgLength
FROM category AS ca
INNER JOIN film_category AS fc        
ON ca.category_id = fc.category_id
INNER JOIN film AS f
ON fc.film_id = f.film_id
GROUP BY ca.category_id, ca.name
HAVING AVG(f.length) > 120; 



/*21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la
cantidad de películas en las que han actuado.*/
SELECT COUNT(fa.film_id) AS CountFilm, CONCAT(ac.first_name, " ",ac.last_name) AS FullNameActorActress
FROM actor AS ac
INNER JOIN film_actor AS fa
ON ac.actor_id = fa.actor_id
GROUP BY  ac.actor_id
HAVING CountFilm > 5
ORDER BY CountFilm DESC;

/*22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para
encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.*/
SELECT f.title AS Title, DATEDIFF(r.return_date, r.rental_date) AS DayRent
FROM film AS f
LEFT JOIN inventory AS i
ON f.film_id = i.film_id
INNER JOIN rental as r
ON i.inventory_id = r.inventory_id
WHERE r.rental_id IN (SELECT rental_id
				   FROM rental AS rd
				   WHERE  DATEDIFF(return_date, rental_date) >5 AND rd.rental_id = r.rental_id)
GROUP BY f.title, DayRent
ORDER BY DayRent ASC;


/* 23.Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror".
Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego
exclúyelos de la lista de actores.*/

SELECT CONCAT(a.first_name, " ", a.last_name) AS FullName
FROM actor AS a
WHERE a.actor_id NOT IN( 
							SELECT a.actor_id	
							FROM actor AS a
							LEFT JOIN film_actor AS fa
							ON a.actor_id = fa.actor_id
							INNER JOIN film AS f
							ON fa.film_id = f.film_id
							INNER JOIN film_category AS fc
							ON f.film_id = fc.film_id
							INNER JOIN category AS ca
							ON fc.category_id = ca.category_id
							WHERE ca.name = "Horror");
                            
/*24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la
tabla film.*/
SELECT f.title AS Title
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS ca
ON fc.category_id = ca.category_id
WHERE ca.name = "Comedy" AND length > 180;

/*25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe
mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.*/
SELECT *
FROM actor;
SELECT *
FROM film_actor;




SELECT  a.actor_id, a.first_name, a.last_name, GROUP_CONCAT(a.first_name, " ", a.last_name) AS FullName, COUNT(fa.film_id) AS FilmCount, fa.film_id
FROM film_actor AS fa
INNER JOIN actor AS a
ON fa.actor_id = a.actor_id
INNER JOIN film AS f
ON fa.film_id = f.film_id
GROUP BY fa.film_id;


