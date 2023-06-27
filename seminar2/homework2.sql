
USE homework2;

-- 1. Используя операторы языка SQL, создайте таблицу “sales”. Заполните ее данными.
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
id SERIAL PRIMARY KEY,
order_date DATE,
bucket INT
);

INSERT INTO sales (order_date, bucket)
VALUES ('2021-01-01', 256), 
       ('2021-01-02', 105), 
       ('2021-01-03', 57), 
       ('2021-01-04', 120), 
       ('2021-01-05', 310);
       
SELECT * FROM sales;

-- 2 Разделите значения поля “bucket” на 3 сегмента: меньше 100(“Маленький заказ”), 100-300(“Средний заказ”) и больше 300 (“Большой заказ”).
SELECT id, bucket,
CASE 
	WHEN bucket < 100 THEN 'Маленький заказ'
    WHEN bucket > 100 AND bucket <= 300 THEN 'Средний заказ'
    WHEN bucket > 300 THEN 'Большой заказ'
    ELSE 'FAIL'
END as class
FROM sales;


-- 3 Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE.
CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
employee_id VARCHAR(3),
amount DECIMAL(5,2),
order_status VARCHAR(10)
);

INSERT INTO orders (employee_id, amount, order_status)
VALUES ('e03', 15.00, 'OPEN'), 
       ('e01', 25.50, 'OPEN'), 
       ('e05', 100.70, 'CLOSED'), 
       ('e02', 22.18, 'OPEN'), 
       ('e04', 9.50, 'CANCELLED'),
       ('e04', 99.99, 'OPEN');

SELECT * FROM orders;

SELECT order_id, order_status,
CASE 
	WHEN order_status = 'OPEN' THEN 'Order is in open state'
    WHEN order_status = 'CLOSED' THEN 'Order is closed'
    WHEN order_status = 'CANCELLED'THEN 'Order is cancelled'
END as order_summary
FROM orders;


-- 4 Чем 0 отличается от NULL?
/*
0 - это целочисленное значение, т.е можно совершать логические и арифметические операции. 
NULL – это не число, а «вставка» для значения данных, которое не указано или неизвестно.
*/

