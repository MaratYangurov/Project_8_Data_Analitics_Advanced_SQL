-- Запрос №3
-- Сколько пользователей получили значки сразу в день регистрации? 
-- Выведите количество уникальных пользователей.
SELECT COUNT(DISTINCT u.id)
FROM stackoverflow.badges AS b
INNER JOIN stackoverflow.users AS u ON b.user_id = u.id
WHERE CAST(u.creation_date AS DATE) = CAST(b.creation_date AS DATE);