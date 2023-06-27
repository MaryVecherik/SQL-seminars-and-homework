
/*
1.	Создайте таблицу с мобильными телефонами, используя графический интерфейс. Заполните БД данными.
2. 	Выведите название, производителя и цену для товаров, количество которых превышает 2 
3. 	Выведите весь ассортимент товаров марки “Samsung”
4.	Выведите информацию о телефонах, где суммарный чек больше 100 000 и меньше 145 000**

4.*** С помощью регулярных выражений найти (можно использовать операторы “LIKE”, “RLIKE” для 4.3 ):
	4.1. Товары, в которых есть упоминание "Iphone"
	4.2. "Galaxy"
	4.3.  Товары, в которых есть ЦИФРЫ
	4.4.  Товары, в которых есть ЦИФРА "8"  
*/

USE homework1; -- подключаем схему

-- 1 
CREATE TABLE homework1.mobile_phones (
    Id INT PRIMARY KEY,
    ProductName VARCHAR(25),
    Manufacturer VARCHAR(25),
    ProductCount INT,
    Price INT
);

INSERT INTO mobile_phones (Id, ProductName, Manufacturer, ProductCount, Price)
VALUES (1, 'iPhone X', 'Apple', 3, 76000),
       (2, 'iPhone 8', 'Apple', 2, 51000),
       (3, 'Galaxy S9', 'Samsung', 2, 56000),
       (4, 'Galaxy S8', 'Samsung', 1, 41000),
       (5, 'P20 Pro', 'Huawei', 5, 36000);
       
-- вывод базы данных mobile_phones
SELECT * FROM homework1.mobile_phones;

-- 2 
SELECT ProductName, Manufacturer, Price
FROM mobile_phones
WHERE ProductCount > 2;

-- 3
SELECT *
FROM mobile_phones
WHERE Manufacturer LIKE 'S%';
-- 3.1
SELECT *
FROM mobile_phones
WHERE Manufacturer = 'Samsung';

-- 4 
SELECT *
FROM mobile_phones
WHERE Price*ProductCount > 100000 AND Price*ProductCount < 145000;
-- 4.1
SELECT *
FROM mobile_phones
WHERE Price*ProductCount BETWEEN 100000 AND 145000;

-- 4*
-- 4.1
SELECT *
FROM mobile_phones
WHERE ProductName  LIKE '%Iphone%';

-- 4.2
SELECT *
FROM mobile_phones
WHERE ProductName  LIKE '%Galaxy%';

-- 4.3
SELECT *
FROM mobile_phones
WHERE ProductName REGEXP '[0-9]';
-- 4.3.1
SELECT *
FROM mobile_phones
WHERE ProductName IN(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);

-- 4.4
SELECT *
FROM mobile_phones
WHERE ProductName  LIKE '%8%';

