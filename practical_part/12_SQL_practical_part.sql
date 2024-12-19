-- Запрос №12
-- Посчитайте ежедневный прирост новых пользователей в ноябре 2008 года. 
-- Сформируйте таблицу с полями:

-- номер дня;
-- число пользователей, зарегистрированных в этот день;
-- сумму пользователей с накоплением.
WITH
dat AS (
	SELECT 
		CAST(creation_date AS date) AS day_of_the_month,
	    COUNT(*) AS count_user
	FROM stackoverflow.users
	WHERE CAST(creation_date AS DATE) BETWEEN '2008-11-01' AND '2008-11-30'
	GROUP BY CAST(creation_date AS DATE)
)

SELECT
	EXTRACT(DAY FROM day_of_the_month) AS day_of_the_month,
	count_user,
	SUM(count_user) OVER(ORDER BY day_of_the_month) AS cumulative_users
FROM dat
ORDER BY day_of_the_month;