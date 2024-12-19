-- Запрос №13
-- Для каждого пользователя, который написал хотя бы один пост, найдите интервал между регистрацией и временем создания первого поста. 
--Отобразите:

-- идентификатор пользователя;
-- разницу во времени между регистрацией и первым постом.

WITH
first_post_dates  AS (
	SELECT
		p.user_id,
		MIN(p.creation_date) AS first_post_date 
	FROM stackoverflow.posts AS p
	GROUP BY p.user_id
)

SELECT
	u.id AS user_id,
	first_post_dates.first_post_date - u.creation_date AS time_interval
FROM stackoverflow.users AS u
INNER JOIN first_post_dates ON u.id = first_post_dates.user_id;