-- Запрос №5
-- Выгрузите все поля таблицы vote_types. 
-- Добавьте к таблице поле rank, в которое войдут номера записей в обратном порядке. 
-- Таблица должна быть отсортирована по полю id.
SELECT vt.*,
	ROW_NUMBER() OVER(ORDER BY id DESC) AS rank
FROM stackoverflow.vote_types AS vt
ORDER BY id;
 