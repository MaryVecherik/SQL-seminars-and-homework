/*
1.	Получить список с информацией обо всех студентах
2. 	Получить список всех студентов с именем “Антон”(или любого существующего студента)
3. 	Вывести имя и телефон из таблички "Студент"
4.	Выбрать студентов, имена которых начинаются с буквы «А».
Добавьте в таблицу со студентами столбец с стипендией.
5.  Выбрать студентов, у которых стипендия оказалась выше 6000
6.  Показать всех студентов, кроме “Антона”(или любого существующего студента)
*/

USE seminar1; -- подключаем схему

-- 1 
SELECT * FROM student;

-- 2
SELECT * FROM student
WHERE name = 'Антон';

-- 3
SELECT name, phone
FROM student;
-- 3.1
SELECT name, phone
FROM student
WHERE name IN ('Нина', 'Максим');

-- Like
-- '%' - любая подсторка или ничего;
--  Galaxy S7, Galaxy S10, Galaxy A5
-- Like 'Galaxy S%' -> Galaxy S7, Galaxy S10

-- '_' - один символ;
--  Galaxy S7, Galaxy S10, Galaxy A5
-- Like 'Galaxy S_' -> Galaxy S7

-- 4
SELECT *
FROM student
WHERE name LIKE 'А%';

-- 5
SELECT * FROM student
WHERE stip > 6000;

-- SELECT stip * idstudent, idstudent, stip
-- FROM student;

-- 6
SELECT * FROM student
WHERE name != 'Антон';

SELECT * FROM student
WHERE NOT (name = 'Антон');



