
USE homework5;

-- --------------------------------------------
DROP TABLE IF EXISTS Cars;
CREATE TABLE Cars (       
	Id SERIAL PRIMARY KEY, 
	Name VARCHAR(20), 
    Cost INT
);

INSERT INTO Cars (Name,	Cost)
VALUES ('Audi', 52642),
       ('Mercedes', 57127),
       ('Skoda', 9000),
       ('Volvo', 29000),
       ('Bentley', 350000),
       ('Citroen', 21000),
       ('Hummer', 41400),
       ('Volkswagen', 21600);

SELECT * FROM Cars;

/* 
1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
*/

CREATE VIEW cte AS 
SELECT * FROM Cars
WHERE Cost < 25000;

SELECT * FROM cte;

/* 
2. Изменить в существующем представлении порог для стоимости: 
пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 
*/

ALTER VIEW cte AS 
SELECT * FROM Cars
WHERE Cost < 30000;

SELECT * FROM cte;

/* 
3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” 
*/

CREATE VIEW cte2 AS 
SELECT * FROM Cars
WHERE Name IN ('Skoda', 'Audi');

SELECT * FROM cte2;

-- -----------------------------------------------
DROP TABLE IF EXISTS Grop;
CREATE TABLE Grop (       
	gr_id INT AUTO_INCREMENT PRIMARY KEY, 
	gr_name VARCHAR(10), 
    gr_temp INT
);

INSERT INTO Grop (gr_name, gr_temp)
VALUES ("A", 15),
       ("B", 10),
       ("C", 5);

SELECT * FROM Grop;

DROP TABLE IF EXISTS Analysis;
CREATE TABLE Analysis (       
	an_id INT AUTO_INCREMENT PRIMARY KEY, 
	an_name VARCHAR(100), 
    an_cost INT,
    an_price INT,
    an_group INT, 
    FOREIGN KEY (an_group) REFERENCES Grop(gr_id)
);

INSERT INTO Analysis (an_name, an_cost, an_price, an_group)
VALUES ('клинический (общий) анализ крови', 300, 800, 1),
       ('биохимический анализ крови', 250, 600, 1),
       ('иммунологический анализ крови', 400, 800, 1),
       ('общий анализ мочи', 200, 500, 2),
       ('общий анализ кала', 230, 650, 2),
       ('тест на COVID-19', 330, 700, 3);

SELECT * FROM Analysis;

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (       
	ord_id INT AUTO_INCREMENT PRIMARY KEY, 
	ord_datetime DATE, 
    ord_an INT,
    FOREIGN KEY (ord_an) REFERENCES Analysis(an_id)
);

INSERT INTO Orders (ord_datetime, ord_an)
VALUES ('2020-01-25', 1),
       ('2020-01-29', 2),
       ('2020-02-01', 3),
       ('2020-02-05', 4),
       ('2020-02-08', 5),
       ('2020-02-09', 6),
       ('2020-02-11', 1),
       ('2020-02-12', 2),
       ('2020-02-13', 3),
       ('2020-02-14', 4),
       ('2020-02-15', 5);

SELECT * FROM Orders;

/* 
4. Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 
и всю следующую неделю.
*/

-- 4.1
SELECT an_name, an_price, ord_datetime
FROM Analysis 
JOIN Orders
ON Orders.ord_an = Analysis.an_id
WHERE Orders.ord_datetime BETWEEN '2020-02-05' AND TIMESTAMPADD(DAY, 7, '2020-02-05');

-- 4.2
SELECT an_name, an_price, ord_datetime
FROM Analysis 
JOIN Orders
ON Orders.ord_an = Analysis.an_id
WHERE Orders.ord_datetime >= '2020-02-05' AND Orders.ord_datetime <= DATE_ADD('2020-02-05', INTERVAL 1 WEEK);

-- -----------------------------------------------------------
DROP TABLE IF EXISTS t;
CREATE TABLE t (
  train_id INT,
  station VARCHAR(20),
  station_time TIME
);

INSERT t (train_id, station, station_time)
VALUES (110, 'San Francisco', '10:00:00'),
	   (110, 'Redwood City', '10:54:00'),
       (110, 'Palo Alto', '11:02:00'),
       (110, 'San Jose', '12:35:00'),
       (120, 'San Francisco', '11:00:00'),
       (120, 'Palo Alto', '12:49:00'),
       (120, 'San Jose', '13:30:00');
    
SELECT * FROM t;

/*
5. Добавьте новый столбец под названием «время до следующей станции». Чтобы получить это значение, мы вычитаем время станций для пар смежных станций. 
Мы можем вычислить это значение без использования оконной функции SQL, но это может быть очень сложно. Проще это сделать с помощью оконной функции LEAD. 
Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат. 
В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.
*/

-- 5.1
SELECT *,
TIMEDIFF(LEAD(station_time) OVER (PARTITION BY train_id ORDER BY station_time), station_time) as time_to_next_station
FROM t;

-- 5.2
SELECT *,
SUBTIME(LEAD(station_time) OVER (PARTITION BY train_id ORDER BY station_time), station_time) as time_to_next_station
FROM t;