-- Запрос №9
-- Отобразите заголовки постов, которые были написаны пользователями, получившими более 1000 значков. 
-- Посты без заголовков не должны попасть в список.

SELECT
	p.title
FROM stackoverflow.posts AS p
INNER JOIN stackoverflow.users AS u ON u.id = p.user_id
WHERE p.title IS NOT NULL 
	AND u.id IN (
		SELECT
			b.user_id
		FROM stackoverflow.badges AS b
		GROUP BY b.user_id
		HAVING COUNT(b.id) > 1000
	);

