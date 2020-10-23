/*app_store*/
SELECT name, price, CAST(review_count as INT), rating, primary_genre
FROM app_store_apps
WHERE rating 
ORDER BY review_count DESC
LIMIT 20;

SELECT name, CAST(price as INT), review_count, rating, genres
FROM play_store_apps
WHERE price < 0.99
AND rating > 4.6
ORDER BY review_count DESC;

SELECT name, price, review_count, rating, content_rating, primary_genre
FROM app_store_apps
WHERE rating > 4.6
ORDER BY CAST(review_count as numeric) DESC
LIMIT 50;


/*play_store*/

SELECT name
FROM play_store_apps
UNION ALL
SELECT name
FROM app_store_apps;

SELECT name, price, review_count, rating, content_rating, genres
FROM play_store_apps
WHERE rating > 4.6
ORDER BY review_count DESC
LIMIT 50;


SELECT name, price, review_count, rating, genre
FROM play_store_apps
WHERE rating =5
ORDER BY review_count DESC
LIMIT 20;

/*combined_table*/

SELECT COUNT (name), rating
FROM app_store_apps
UNION ALL
SELECT COUNT(name), rating
FROM play_store_apps
GROUP BY rating
ORDER BY name;

/*full_tables*/

SELECT name, CAST(price as NUMERIC), CAST(review_count AS NUMERIC), rating, primary_genre
FROM app_store_apps
WHERE price < 0.99
AND rating >4.6
ORDER BY review_count DESC;




SELECT*
FROM play_store_apps