-- Запрос №6
-- На сколько процентов менялось количество постов ежемесячно с 1 сентября по 31 декабря 2008 года? 

-- Отобразите таблицу со следующими полями:
-- Номер месяца.
-- Количество постов за месяц.
-- Процент, который показывает, насколько изменилось количество постов в текущем месяце по сравнению с предыдущим.

-- Если постов стало меньше, значение процента должно быть отрицательным, если больше — положительным. 
-- Округлите значение процента до двух знаков после запятой.

-- Напомним, что при делении одного целого числа на другое в PostgreSQL в результате получится целое число, 
-- округлённое до ближайшего целого вниз. 
-- Чтобы этого избежать, переведите делимое в тип numeric.

WITH 
monthly_posts AS (
    SELECT
        EXTRACT(MONTH FROM p.creation_date) AS month_number,
        COUNT(*) AS posts_count
    FROM stackoverflow.posts AS p
    WHERE p.creation_date BETWEEN '2008-09-01' AND '2008-12-31'
    GROUP BY EXTRACT(MONTH FROM p.creation_date)
    ORDER BY month_number
),
monthly_changes AS (
    SELECT
        month_number,
        posts_count,
        ROUND(
            (posts_count - LAG(posts_count) OVER (ORDER BY month_number))::NUMERIC 
            / NULLIF(LAG(posts_count) OVER (ORDER BY month_number), 0) * 100, 
            2
        ) AS percent_change
    FROM monthly_posts
)

SELECT 
    month_number,
    posts_count,
    COALESCE(percent_change, 0) AS percent_change -- Для первого месяца изменения нет
FROM monthly_changes;
