-- Запрос №2
-- Выведите имена самых активных пользователей, которые в первый месяц после регистрации 
-- (включая день регистрации) дали больше 100 ответов. 
-- Вопросы, которые задавали пользователи, не учитывайте. 
-- Для каждого имени пользователя выведите количество уникальных значений user_id. 
-- Отсортируйте результат по полю с именами в лексикографическом порядке.

WITH
-- Выбираем пользователей и их даты регистрации
users_with_creation_date AS (
    SELECT 
        id AS user_id,
        creation_date,
        display_name
    FROM stackoverflow.users
),
-- Фильтруем посты только с ответами
answers_within_first_month AS (
    SELECT 
        p.user_id,
        COUNT(p.id) AS answers_count
    FROM stackoverflow.posts AS p
    INNER JOIN stackoverflow.post_types AS pt ON p.post_type_id = pt.id
    WHERE pt.type = 'Answer' 
        AND p.creation_date <= users_with_creation_date.creation_date + INTERVAL '1 MONTH'
    GROUP BY p.user_id
),
-- Отбираем только тех, кто дал больше 100 ответов
active_users AS (
    SELECT 
        u.display_name,
        COUNT(DISTINCT u.id) AS unique_users
    FROM answers_within_first_month AS awm
    INNER JOIN users_with_creation_date AS u ON awm.user_id = u.user_id
    WHERE awm.answers_count > 100
    GROUP BY u.display_name
)

-- Выводим результат
SELECT 
    display_name,
    unique_users
FROM active_users
ORDER BY display_name;
