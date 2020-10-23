SELECT *
FROM play_store_apps
WHERE category LIKE 'GAME';

SELECT *
FROM app_store_apps
WHERE primary_genre LIKE 'Games'
AND 

SELECT INITCAP(lower(category)), COUNT(*) as num_apps, ROUND(AVG(rating::numeric),2), AVG(trim(install_count, '+', ',')::numeric)
FROM play_store_apps
WHERE price < '1.00'
GROUP BY category
ORDER BY COUNT(*) DESC;

DROP TABLE IF EXISTS matching;
CREATE TEMP TABLE matching AS
WITH app_store AS (SELECT name, rating, review_count
				  FROM app_store_apps
				  WHERE price <= '1.00'),
	play_store AS (SELECT name, rating, review_count
					FROM play_store_apps
					WHERE trim(price, '$')::numeric <= '1.00')
					SELECT name
					FROM app_store
					INTERSECT
					SELECT name
					FROM play_store;
					
SELECT DISTINCT(name)
FROM matching
INNER JOIN app_store_apps as a
USING (name)
INNER JOIN play_store_apps as p
USING(name);
DROP TABLE IF EXISTS best_apps;
CREATE TEMP TABLE best_apps AS
SELECT name, a.primary_genre, a.rating as app_rating, a.review_count as app_rc, p.category, p.rating as play_rating, p.review_count as play_rc
FROM matching
INNER JOIN app_store_apps as a
USING (name)
INNER JOIN play_store_apps as p
USING(name);
SELECT DISTINCT(name), primary_genre, app_rating, app_rc, category, play_rating, play_rc
FROM best_apps
WHERE app_rating >=4.5
AND play_rating >= 4.5
ORDER BY app_rating DESC;


WITH app_store AS (SELECT name, rating, review_count
				  FROM app_store_apps
				  WHERE price <= '1.00'),
	play_store AS (SELECT name, rating, review_count
					FROM play_store_apps
					WHERE trim(price, '$')::numeric <= '1.00'),
	matching AS (SELECT name
					FROM app_store
					INTERSECT
					SELECT name
					FROM play_store),
	best_apps AS (SELECT name, a.primary_genre, a.rating as app_rating, a.review_count as app_rc, p.category, p.rating as play_rating, p.review_count as play_rc
					FROM matching
					INNER JOIN app_store_apps as a
					USING (name)
					INNER JOIN play_store_apps as p
					USING(name))	
					
SELECT DISTINCT(name), *
FROM best_apps
WHERE play_rating > 4.5
AND app_rating > 4.5
ORDER BY name DESC;
