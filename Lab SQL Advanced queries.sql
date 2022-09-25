-- Lab | SQL Advanced queries

use sakila;

-- 1. List each pair of actors that have worked together.
CREATE OR REPLACE VIEW actor_comb AS
    SELECT 
        fa1.actor_id AS actor_id1,
        fa2.actor_id AS actor_id2,
        fa1.film_id
    FROM
        film_actor fa1
            JOIN
        film_actor fa2 ON fa1.actor_id < fa2.actor_id
            AND fa1.film_id = fa2.film_id;

SELECT 
    actor_id1,
    a1.first_name,
    a1.last_name,
    actor_id2,
    a2.first_name,
    a2.last_name
FROM
    actor_comb
        JOIN
    actor a1 ON actor_id1 = a1.actor_id
        JOIN
    actor a2 ON actor_id2 = a2.actor_id
GROUP BY actor_id1 , actor_id2;

-- 2. For each film, list actor that has acted in more films.
CREATE OR REPLACE VIEW actor_film_comb AS
    SELECT 
        fa1.actor_id,
        fa1.film_id AS film_id1,
        fa2.film_id AS film_id2
    FROM
        film_actor fa1
            JOIN
        film_actor fa2 ON fa1.actor_id = fa2.actor_id
            AND fa1.film_id < fa2.film_id;

SELECT 
    f1.title, film_id1, actor_id
FROM
    actor_film_comb
        JOIN
    film f1 ON film_id1 = f1.film_id
GROUP BY actor_id
ORDER BY f1.title;