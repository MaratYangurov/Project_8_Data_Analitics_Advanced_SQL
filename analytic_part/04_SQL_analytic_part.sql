-- Запрос №4
-- Используя данные о постах, выведите несколько полей:

-- идентификатор пользователя, который написал пост;
-- дата создания поста;
-- количество просмотров у текущего поста;
-- сумма просмотров постов автора с накоплением.

-- Данные в таблице должны быть отсортированы по возрастанию идентификаторов пользователей, 
-- а данные об одном и том же пользователе — по возрастанию даты создания поста.

SELECT
	p.user_id,
	p.creation_date,
	p.views_count,
	SUM(views_count) OVER(PARTITION BY user_id ORDER BY creation_date)
FROM stackoverflow.posts AS p
ORDER BY p.user_id, p.creation_date;
