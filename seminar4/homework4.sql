USE homework4;

DROP TABLE IF EXISTS AUTO;
CREATE TABLE AUTO 
(       
	REGNUM VARCHAR(10) PRIMARY KEY, 
	MARK VARCHAR(10), 
	COLOR VARCHAR(15),
	RELEASEDT DATE, 
	PHONENUM VARCHAR(15)
);

INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM)
VALUES
(111114,'LADA', 'КРАСНЫЙ', DATE'2008-01-01', '9152222221'),
(111115,'VOLVO', 'КРАСНЫЙ', DATE'2013-01-01', '9173333334'),
(111116,'BMW', 'СИНИЙ', DATE'2015-01-01', '9173333334'),
(111121,'AUDI', 'СИНИЙ', DATE'2009-01-01', '9173333332'),
(111122,'AUDI', 'СИНИЙ', DATE'2011-01-01', '9213333336'),
(111113,'BMW', 'ЗЕЛЕНЫЙ', DATE'2007-01-01', '9214444444'),
(111126,'LADA', 'ЗЕЛЕНЫЙ', DATE'2005-01-01', NULL),
(111117,'BMW', 'СИНИЙ', DATE'2005-01-01', NULL),
(111119,'LADA', 'СИНИЙ', DATE'2017-01-01', 9213333331);

SELECT * FROM AUTO;

/*
Задание 1
Вывести на экран, сколько машин каждого цвета для машин марок BMW и LADA
*/ 

SELECT MARK, COLOR, COUNT(COLOR) as count
FROM AUTO
WHERE MARK IN ('BMW', 'LADA')
GROUP BY COLOR, MARK;

SELECT MARK, COLOR, COUNT(COLOR) as count
FROM AUTO
GROUP BY COLOR, MARK
HAVING MARK IN ('BMW', 'LADA');

/*
Задание 2
Вывести на экран марку авто(количество) и количество авто не этой марки.
100 машин, их них 20 - BMW и 80 машин другой марки ,  AUDI - 30 и 70 машин другой марки, LADA - 15, 85 авто другой марки
*/ 

SELECT MARK, COUNT(*) as count, (SELECT COUNT(*) FROM AUTO) - COUNT(*) as other
FROM AUTO
GROUP BY MARK;


-- Задание 3

DROP TABLE IF EXISTS test_a;
create table test_a (id INT, test varchar(10));

DROP TABLE IF EXISTS test_b;
create table test_b (id INT);

insert into test_a(id, test) values
(10, 'A'),
(20, 'A'),
(30, 'F'),
(40, 'D'),
(50, 'C');

insert into test_b(id) values
(10),
(30),
(50);

SELECT * FROM test_a;
SELECT * FROM test_b;

/*
Напишите запрос, который вернет строки из таблицы test_a, id которых нет в таблице test_b, НЕ используя ключевого слова NOT.
*/

SELECT * FROM test_a
LEFT JOIN test_b 
USING(id)
WHERE test_b.id is NULL;

