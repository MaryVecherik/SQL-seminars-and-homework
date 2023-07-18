USE seminar5;

-- -----------------------------------------------------
DROP TABLE IF EXISTS users;
CREATE TABLE users 
(
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(50) NOT NULL,
    status VARCHAR(10) NOT NULL
);

DROP TABLE IF EXISTS users_profile;
CREATE TABLE users_profile 
(
    username VARCHAR(50) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE
);

INSERT INTO users values
('admin' , '7856', 'Active'),
('staff' , '90802', 'Active'),
('manager' , '35462', 'Inactive');

INSERT INTO users_profile values
('admin', 'Administrator' , 'Dhanmondi', 'admin@test.com' ) ,
('staff', 'Jakir Nayek' , 'Mirpur', 'zakir@test.com' ),
('manager', 'Mehr Afroz' , 'Eskaton', 'mehr@test.com' );

SELECT * FROM users;
SELECT * FROM users_profile;

-- СТЕ (Common Table Expressions)
/*
1. Используя СТЕ, выведите всех пользователей из таблицы users_profile
2. Используя СТЕ, подсчитайте количество активных пользователей. Задайте псевдоним результирующему окну.
3. С помощью СТЕ реализуйте таблицу квадратов чисел от 1 до 10: (пример для чисел от 1 до 3)
*/

-- 1
WITH cte1 AS (
SELECT username 
FROM users_profile
)
SELECT * FROM cte1;

-- 2
WITH cte2 AS (
SELECT status, COUNT(*) as kol
FROM users
GROUP BY status  
)
SELECT kol FROM cte2
WHERE status = 'Active';

-- 3
WITH RECURSIVE cte3 AS (
SELECT 1 as n, 1 as res
UNION ALL
SELECT n + 1, POW(n+1, 2) FROM cte3 
WHERE n < 10
)
SELECT * FROM cte3;

-- -----------------------------------------------------------------------

-- Рекурсивные СТЕ

-- Пример: генерация набора от 1 до 10
WITH RECURSIVE cte AS (
SELECT 1 as a
UNION ALL
SELECT a + 1 FROM cte
WHERE a < 10
)
SELECT * FROM cte;

-- ------------------------------------------------------------------------

-- Оконные функции

-- задача 1
DROP TABLE t1;
CREATE TABLE t1 (
  id INT NOT NULL AUTO_INCREMENT,
  tb VARCHAR(45) NULL,
  id_client INT,
  id_dog INT,
  osz INT,
  procent_rate INT,
  rating INT,
  segment VARCHAR(45),
  PRIMARY KEY (id)
  );

INSERT INTO t1 (tb, id_client, id_dog, osz, procent_rate, rating, segment) 
VALUES ('A', 1, 111, 100, 6, 10, 'SREDN'),
       ('A', 1, 222, 150, 6, 10, 'SREDN'),
       ('A', 2, 333, 50, 9, 15, 'MMB'),
       ('B', 1, 444, 200, 7, 10, 'SREDN'),
       ('B', 3, 555, 1000, 5, 16, 'CIB'),
       ('B', 4, 666, 500, 10, 20, 'CIB'),
       ('B', 4, 777, 10, 12, 17, 'MMB'),
       ('C', 5, 888, 20, 11, 21, 'MMB'),
       ('C', 5, 999, 200, 9, 13, 'SREDN');

SELECT * FROM t1;

/*
Собрать дэшборд, в котором содержится информация о максимальной задолженности
 в каждом банке, а также средний размер процентной ставки в каждом банке в зависимости
 от сегмента и количество договоров всего всем банкам
*/

SELECT *,
MAX(osz) OVER(PARTITION BY tb) as 'максимальной задолженности',
AVG(procent_rate) OVER(PARTITION BY tb, segment) as 'средний размер процентной ставки',
COUNT(id_dog) OVER() as 'количество договоров'
FROM t1;


-- задача 2
DROP TABLE bank_table;
CREATE TABLE bank_table (
  id_bank INT NOT NULL,
  tb VARCHAR(45) NULL,
  dep VARCHAR(45) NULL,
  count_revisions INT NULL,
  PRIMARY KEY (id_bank)
  );

INSERT INTO bank_table (id_bank, tb, dep, count_revisions) 
VALUES ('1', 'A', 'Corp', 100),
       ('2', 'A', 'Rozn', 47),
       ('3', 'A', 'IT', 86),
       ('4', 'B', 'Corp', 70),
       ('5', 'B', 'Rozn', 65),
       ('6', 'B', 'IT', 58),
       ('7', 'C', 'Corp', 42),
       ('8', 'C', 'Rozn', 40),
       ('9', 'C', 'IT', 63),
       ('10', 'D', 'Corp', 95),
       ('11', 'D', 'Rozn', 120),
       ('12', 'D', 'IT', 85),
       ('13', 'E', 'Corp', 70),
       ('14', 'E', 'Rozn', 72),
       ('15', 'E', 'IT', 80),
       ('16', 'F', 'Corp', 66),
       ('17', 'F', 'Rozn', 111),
       ('18', 'F', 'IT', 33);

SELECT * FROM bank_table;

/* 
Проранжируем таблицу по убыванию количества ревизий:
*/

SELECT * , 
ROW_NUMBER() OVER(ORDER BY count_revisions desc) as 'row_number', 
Rank() OVER(ORDER BY count_revisions desc) as 'rank', 
DENSE_RANK() OVER(ORDER BY count_revisions desc) as 'dense_rank', 
NTILE(3) OVER(ORDER BY count_revisions desc) as 'ntile'
FROM bank_table;


-- задача 3
/*
Найти второй отдел во всех банках по количеству ревизий
*/

WITH cte3 AS
(
	SELECT *,
    DENSE_RANK() OVER(PARTITION BY tb ORDER BY count_revisions DESC) as ds
    FROM bank_table
)
SELECT * FROM cte3
WHERE ds = 2;



-- Оконные функции смещения

DROP TABLE IF EXISTS tasks;
CREATE TABLE tasks (
  id_tasks INT NOT NULL,
  event VARCHAR(45) NOT NULL,
  date_event DATETIME NOT NULL
  );
  
  INSERT INTO tasks (id_tasks, event, date_event) 
  VALUES (1, 'Open', '2020-02-01'),
         (1, 'To_1_Line', '2020-02-02'),
         (1, 'To_2_Line', '2020-02-03'),
         (1, 'Successful', '2020-02-04'),
         (1, 'Close', '2020-02-05'),
         (2, 'Open', '2020-03-01'),
         (2, 'To_1_Line', '2020-03-02'),
         (2, 'Denied', '2020-03-03'),
         (3, 'Open', '2020-04-01'),
         (3, 'To_1_Line', '2020-04-02'),
         (3, 'To_2_Line', '2020-04-03');

SELECT * FROM tasks;

SELECT *,
LEAD(event, 1, 'end') OVER (PARTITION BY id_tasks ORDER BY date_event) as 'next_event',
LEAD(date_event, 1, '2099-01-01') OVER (PARTITION BY id_tasks ORDER BY date_event) as 'next_date'
FROM tasks;



