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

SELECT first_name AS NameActorAndActress -- Aqui seleccionamos el nombre de los actores y actrices y le damos un nombre a la columna
FROM actor;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
SELECT *
FROM actor; -- Aqui buscamos en la tabla actor donde podemos encontrar el apellido de los actores y actrices
SELECT CONCAT(first_name," ", last_name) AS FullName  -- Aqui juntamos la columna nombre y la apellido para verlos juntos
FROM actor
WHERE last_name LIKE "Gibson"; -- Aqui le decimos que nos busque dentro de apellido "Gibson"

-- 7.Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
SELECT *
FROM actor; -- Aqui buscamos en la tabla actor donde podemos encontrar el apellido de los actores y actrices

SELECT actor_id AS IDActor, first_name AS Name -- Queremos que nos muestre los ID y los nombres
FROM actor
WHERE actor_id BETWEEN 10 AND 20;  -- Dentro de la columna actor_id le pedimos los que estre entre 10 y 20

-- 8.Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
SELECT *
FROM film; -- Aqui buscamos en la tabla film para buscar la informacion que nos pide el ejercicio

SELECT title AS Title, rating AS Rating -- Seleccionamos la columna de titulo y la de clasificacion
FROM film
WHERE rating NOT IN  ("PG-13","R") -- Decimos que se queden fuera las clasificaciones "R" y "PG-13"
ORDER BY rating; -- Aqui se le pide que se ordene por clasificacion para darle un orden a la tabla

-- 9.Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento
SELECT *
FROM film;  -- Aqui buscamos en la tabla film para buscar la informacion que nos pide el ejercicio

SELECT COUNT(film_id) AS TotalFilms, rating AS Rating -- Se hace un count del id parap oder hacer un recuento de todas las peliculas
FROM film
GROUP BY rating -- Se agrupa por las clasificaciones
ORDER BY TotalFilms DESC; -- Se ordena de mayor a menor para ver las clasificaciones con más y menos peliculas


/* 10.Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto 
con la cantidad de películas alquiladas.*/
SELECT *
FROM customer;  -- Aqui buscamos en la tabla customer y luego rental para buscar la informacion que nos pide el ejercicio
SELECT *
FROM rental;
SELECT cu.customer_id AS IDClient, COUNT(re.rental_id) AS RentedFilm , CONCAT(cu.first_name," ", cu.last_name) AS ClientfULLnAME
FROM customer AS cu
INNER JOIN rental AS re  -- Se hace un INNER JOIN para unir las dos tablas a travez de las PK y FK de ambas
ON cu.customer_id  = re.customer_id
GROUP BY IDClient -- Lo agrupamos por el ID del Cliente
ORDER BY RentedFilm DESC; -- Lo ordenamos por el numero de peliculas alquiladas

/* 11.Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto 
con el recuento de alquileres. */
SELECT *
FROM category;
SELECT * 
FROM film_category;
SELECT * 
FROM inventory;
SELECT *
FROM rental; -- Primero  miramos todas las tablas de donde vamos a sacar la informacion y cómo unirlas a traves de PK y FK

SELECT COUNT(re.rental_id) AS RentedFilm , ca.name AS Category -- Luego agrupamos la informacion que quereoms en la table, en este caso las pelicuals alquiladas y las categorias y contamos las peliculas alquiladas por sus categorias
FROM category AS ca
INNER JOIN film_category AS f -- Vamos a hacer 3 INNER JOIN para poder unir las peliculas alquiladas, que estan en la tabla rental, hasta las cagorias de cada pelicula que esta en la tabla category
ON ca.category_id= f.category_id
INNER JOIN inventory AS inv
ON f.film_id = inv.film_id
INNER JOIN rental AS re
ON re.inventory_id = inv.inventory_id
GROUP BY Category -- Se agrupan por las categorias pues es lo que queremos ver
ORDER BY RentedFilm DESC; -- Ordenamos por peliculas alquiladas y así es más comoda ver qué cateogria es más alquilada a la que menos


/*12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la
clasificación junto con el promedio de duración.*/
SELECT * -- Miramos la tabla film para ver los elementos que tenemos que seleccionar
FROM film;

SELECT rating AS Rating , ROUND(AVG(length),2) AS Lenght -- Se calcula el promedio de las peliuclas y rodeamos a 2 decimales
FROM film
GROUP BY rating; -- Agrupamos por Clasificacion

/* 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".*/
SELECT *
FROM film;
SELECT *
FROM film_actor;
SELECT *
FROM actor;
SELECT f.title AS Title, CONCAT(ac.first_name , " ", ac.last_name)AS FullNameActor -- Seleccionamos los elementos que queremos que aparezcan en la tabla y agrupamos el nombre y apellido para que quede en una parte
FROM film AS f
INNER JOIN film_actor AS fa  -- Hacemos 3 INNER JOIN para poder conectar los elemtos que se nos piden
ON f.film_id = fa.film_id
INNER JOIN actor AS ac
ON fa.actor_id = ac.actor_id
WHERE f.title LIKE 'Indian Love' -- Ponemos el LIKE para que nos localice el titulo de la pelicula que queremos ver
GROUP BY f.title, ac.actor_id, FullNameActor; -- Agrupamos por los 3 elementos


/* 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.*/
SELECT *
FROM film; -- Miramos todos los elementos que estan en la tabla film para traerlos
SELECT title AS Title, description AS Description -- Seleccionamos qué queremos que aparezca en la tabla
FROM film
WHERE description LIKE "%dog%"OR description LIKE "%cat%"; -- Le pedimos que en la discripcion salga, en cualquier orden, o al palabra"dog" o la palabra "cat"

/*15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.*/
SELECT*
FROM film_actor;  -- Seleccionamos la tabla film_actor para ver toda la informacion que nos puede proporcionar

SELECT actor_id, CONCAT(first_name, " ", last_name) AS FullNameActor -- Seleccionamos qué queremos que aparezca en la nueva tabla según lo que nos pide el ejercicio
FROM actor
WHERE actor_id NOT IN (SELECT actor_id FROM film_actor);  -- Le pedimos que nos busque los actores que no aparezcan en ninguna pelicula 

/*16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.*/
SELECT * 
FROM film; -- Miramos la tabla film

SELECT title AS Title, release_year AS ReleaseYear
FROM film
WHERE release_year BETWEEN 2005 AND 2010; -- Pedimos con el BETWEEN que nos diga lo que hay entre esas dos fechas
 
 /* 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".*/
SELECT f.title AS Title, ca.name AS Category
FROM category AS ca
INNER JOIN film_category AS fc   -- Para conectar titulo y categoria vamos a necesitar 2 INNER JOINS aunque sólo cojamos informacion de una tabla pero necesitamos la tabla film_category para que nos haga de puente entre ambas tablas que si tienen la informacion que requerimos
ON ca.category_id = fc.category_id
INNER JOIN film AS f
ON fc.film_id = f.film_id
WHERE ca.name = "Family" -- Le ponemos que nos seleccione solo las categorias que se llamen Family
GROUP BY f.title,ca.name; -- Agrupamos por los dos elementos que nos pide

/*18.Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.*/
SELECT CONCAT(a.first_name , " ", a.last_name) AS FullName, COUNT(film_id) AS Film  -- Unimos los nombre y apellidos y contamos las id_ de cada pelicula para
FROM actor AS a
INNER JOIN film_actor as fa -- Hacemos un INNER JOIN para unir dos tablas
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id -- agrupamos por las id de los actores pues hay dos actores que se llaman igual
HAVING COUNT(fa.film_id) > 10 -- Sobre los rsultados agregados, le pedimos que de las peliculas que ha contado nos ponga las que sea más de 10
ORDER BY Film DESC; -- Ordenamos por peliculas para que uqede un resultado más interesante a la hora de hacer una analisis de por ejemplo quien sale más y quien menos

/*19.Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.*/
SELECT *
FROM film;v-- miramos la informacion de la tabla film

SELECT title AS Title
FROM film
WHERE rating = "R" AND `length` > 120; -- Le pedimos que se den esas dos condiciones para en las peliculas
 
/*20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el
nombre de la categoría junto con el promedio de duración.*/
SELECT*
FROM film; -- Miramos las tablas de film , de category y vemos que se pueden contectar por category_film

SELECT ca.name AS CategoryFilm, ROUND(AVG(f.length),2) AS AvgLength -- Aqui mostramos la informacion que nos pide el enunciado calculando la media de duracion de la pelicula y le redondeamos a 2 decimales
FROM category AS ca
INNER JOIN film_category AS fc     -- para conectar los dos elementos que nos piden ya sabemos que  necesitamos la film_category para unir a traves  de 2 INNER JOIN
ON ca.category_id = fc.category_id
INNER JOIN film AS f
ON fc.film_id = f.film_id
GROUP BY ca.category_id, ca.name -- Agrupamos
HAVING AVG(f.length) > 120; -- Le pedimos que nos de con HAVING las peliculas que de media tiene maás de 120



/*21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la
cantidad de películas en las que han actuado.*/
SELECT COUNT(fa.film_id) AS CountFilm, CONCAT(ac.first_name, " ",ac.last_name) AS FullNameActorActress -- Contamos las peliculas y juntamos nombre y apellidos de actores para que quede más presentable
FROM actor AS ac
INNER JOIN film_actor AS fa -- Hacemos un INNER JOIN 
ON ac.actor_id = fa.actor_id
GROUP BY  ac.actor_id
HAVING CountFilm > 5 -- Para saber que han actuada en más de 5 peliculas lo ponemos en HAVING
ORDER BY CountFilm DESC; -- Lo odenamos para que quede más lejible la tabla

/*22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para
encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.*/
SELECT f.title AS Title, DATEDIFF(r.return_date, r.rental_date) AS DayRent -- Cuantos días han estado alquiladas hacemos un DATADIFF restandole a la fecha que fue devuelta la pelicula con la que fue alquilada
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


