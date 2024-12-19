-- Запрос №11
-- Дополните предыдущий запрос. 
-- Отобразите лидеров каждой группы — пользователей, которые набрали максимальное число просмотров в своей группе. 
-- Выведите поля с идентификатором пользователя, группой и количеством просмотров. 
-- Отсортируйте таблицу по убыванию просмотров, а затем по возрастанию значения идентификатора.

WITH
grouped_users AS (
	SELECT 
		u.id,
		u.views,
		CASE
	        WHEN u.views >= 350 THEN 1
	        WHEN u.views >= 100 THEN 2
	        WHEN u.views > 0 THEN 3
		END AS type_group
	FROM stackoverflow.users AS u
	WHERE u.location = 'Canada'
		AND u.views > 0
),
ranked_users AS (
    SELECT 
        id,
        views,
        type_group,
        RANK() OVER (PARTITION BY type_group ORDER BY views DESC, id ASC) AS rank
    FROM grouped_users
)
SELECT 
    id,
    type_group,
    views
FROM ranked_users
WHERE rank = 1
ORDER BY views DESC, id ASC;
