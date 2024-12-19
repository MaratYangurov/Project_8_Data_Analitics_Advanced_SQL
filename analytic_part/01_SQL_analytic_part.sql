-- Запрос №1
-- Выведите общую сумму просмотров у постов, опубликованных в каждый месяц 2008 года. 
-- Если данных за какой-либо месяц в базе нет, такой месяц можно пропустить. 
-- Результат отсортируйте по убыванию общего количества просмотров.

SELECT
	EXTRACT(MONTH FROM p.creation_date) AS month,
	SUM(p.views_count)  AS total_views
FROM stackoverflow.posts AS p
WHERE CAST(creation_date AS DATE) BETWEEN '2008-01-01' AND '2008-12-31'
GROUP BY EXTRACT(MONTH FROM p.creation_date)
ORDER BY total_views DESC;
