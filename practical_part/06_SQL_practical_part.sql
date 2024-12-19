-- Запрос №6
-- Отберите 10 пользователей, которые поставили больше всего голосов типа Close. 
-- Отобразите таблицу из двух полей: идентификатором пользователя и количеством голосов. 
-- Отсортируйте данные сначала по убыванию количества голосов, потом по убыванию значения идентификатора пользователя.
SELECT
	v.user_id,
	COUNT(vt.id) AS vote_count
FROM stackoverflow.vote_types AS vt
INNER JOIN stackoverflow.votes AS v ON v.vote_type_id = vt.id
WHERE vt.name = 'Close'
ORDER BY vote_count DESC, v.user_id DESC
LIMIT 10;