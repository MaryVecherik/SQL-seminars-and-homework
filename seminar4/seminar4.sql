USE seminar4;


DROP TABLE IF EXISTS members;
CREATE TABLE members (
		member_id INT AUTO_INCREMENT,
        name VARCHAR (100),
        PRIMARY KEY (member_id)
);

DROP TABLE IF EXISTS committees;
CREATE TABLE committees (
	   committee_id INT AUTO_INCREMENT,
       name VARCHAR (100),
       PRIMARY KEY (committee_id)
);

INSERT INTO members (name)
VALUES("John"), ("Jane"), ("wary"), ("David"), ("2melia");
INSERT INTO committees (name)
VALUES ("John"), ("Mary"), ("Amelial"), ("Joe");

SELECT * FROM members;
SELECT * FROM committees;

-- INNER JOIN
/*
Выведите участников, которые также являются членами комитета, 
используйте INNER JOIN (пересечение 2 таблиц по имени);
*/

SELECT * FROM members m
INNER JOIN committees c
ON m.name = c.name;


-- LEFT JOIN
/*
1. Выведите участников, которые являются членами комитета (Используя LEFT JOIN, выполните соединение двух таблиц  по полю “Имя”)
2. Выведите участников, которые не являются членами комитета
*/

-- 1
SELECT * FROM members m
LEFT JOIN committees c
ON m.name = c.name;

-- 1.1
SELECT * FROM members m
LEFT JOIN committees c
USING(name);

-- 2
SELECT * FROM members m
LEFT JOIN committees c
ON m.name = c.name
WHERE c.name is NULL;


-- RIGHT JOIN
/*
1. 	Найти членов комитета, которых нет в members с помощью RIGHT JOIN
2.	Выполнить RIGHT JOIN между 2 таблицами по полю “Имя”
*/

-- 1
SELECT * FROM members m
RIGHT JOIN committees c
USING(name)
WHERE m.member_id IS NULL;

-- 2
SELECT * FROM members m
RIGHT JOIN committees c
USING(name);


-- CROSS JOIN
/*
1. Выведите перекрестное произведение таблиц members - committees
*/

SELECT * FROM members m
CROSS JOIN committees c;

-- ---------------------------------------------------------------------------------------

DROP TABLE IF EXISTS users;
create table users
(
    id int auto_increment primary key,
    login varchar(255) null,
    pass varchar(255) null,
    male tinyint null
);

DROP TABLE IF EXISTS clients;
create table clients
(
    id int auto_increment primary key,
    login varchar(255) null,
    pass varchar(255) null,
    male tinyint null
);

INSERT INTO users (login, pass, male) VALUES ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO users (login, pass, male) VALUES ('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO users (login, pass, male) VALUES ('Olia', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2);
INSERT INTO users (login, pass, male) VALUES ('Tom', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1);
INSERT INTO users (login, pass, male) VALUES ('Margaret', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2);
INSERT INTO users (login, pass, male) VALUES ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);

INSERT INTO clients (login, pass, male) VALUES ('alexander', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Olia', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2);
INSERT INTO clients (login, pass, male) VALUES ('Dmitry', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Margaret', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2);
INSERT INTO clients (login, pass, male) VALUES ('Leonid', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Olga', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2);
INSERT INTO clients (login, pass, male) VALUES ('Tom', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Masha', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2);
INSERT INTO clients (login, pass, male) VALUES ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);

SELECT * FROM users;
SELECT * FROM clients;

-- UNION и UNION ALL
/*
Таблица users и clients
1. Получить список пользователей и клиентов, удалив одинаковых клиентов и пользователей
2. Получить список пользователей и клиентов. Дубликаты удалять не нужно
*/

-- 1
SELECT * FROM users
UNION
SELECT * FROM clients;

-- 2
SELECT * FROM users
UNION ALL
SELECT * FROM clients;

-- преобразование в разные типы 
SELECT id FROM users
UNION ALL
SELECT pass FROM clients;


-- Оператор IN
/*
1. Проверьте, присутствует ли буква “А” в последовательности 'A', 'B', 'C', 'D' 
2. Проверьте, присутствует ли буква “Z” в последовательности 'A', 'B', 'C', 'D' 
3. Получить столбцы из таблицы “clients” , в которых первое имя является набором значений. К примепу взяли 'Mikle' и 'Tom'
4. Выберите все логины из таблицы “users”, кроме “Mikle”.
*/

-- 1
SELECT 'A' IN ('A', 'B', 'C', 'D');

-- 2
SELECT 'Z' IN ('A', 'B', 'C', 'D');

-- 3
SELECT * 
FROM clients
WHERE login IN ('Mikle', 'Tom');

-- 4
SELECT login
FROM users
WHERE login NOT IN ('Mikle');

-- -----------------------------------------------------------------------------

DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
  Id INT PRIMARY KEY,
  Name VARCHAR(45) NOT NULL,
  Department VARCHAR(45) NOT NULL,
  Salary FLOAT NOT NULL,
  Gender VARCHAR(45) NOT NULL,
  Age INT NOT NULL,
  City VARCHAR(45) NOT NULL
);
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1001, 'John Doe', 'IT', 35000, 'Male', 25, 'London');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1002, 'Mary Smith', 'HR', 45000, 'Female', 27, 'London');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1003, 'James Brown', 'Finance', 50000, 'Male', 28, 'London');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1004, 'Mike Walker', 'Finance', 50000, 'Male', 28, 'London');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1005, 'Linda Jones', 'HR', 75000, 'Female', 26, 'London');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1006, 'Anurag Mohanty', 'IT', 35000, 'Male', 25, 'Mumbai');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1007, 'Priyanla Dewangan', 'HR', 45000, 'Female', 27, 'Mumbai');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1008, 'Sambit Mohanty', 'IT', 50000, 'Male', 28, 'Mumbai');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1009, 'Pranaya Kumar', 'IT', 50000, 'Male', 28, 'Mumbai');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1010, 'Hina Sharma', 'HR', 75000, 'Female', 26, 'Mumbai');

DROP TABLE IF EXISTS Projects;
CREATE TABLE Projects (
   ProjectId INT PRIMARY KEY AUTO_INCREMENT,
   Title VARCHAR(200) NOT NULL,
   ClientId INT,
   EmployeeId INT,
   StartDate DATETIME,
   EndDate DATETIME
);
INSERT INTO Projects (Title, ClientId, EmployeeId, StartDate, EndDate) 
VALUES 
('Develop ecommerse website from scratch', 1, 1003, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY)),
('WordPress website for our company', 1, 1002, NOW(), DATE_ADD(NOW(), INTERVAL 45 DAY)),
('Manage our company servers', 2, 1007, NOW(), DATE_ADD(NOW(), INTERVAL 45 DAY)),
('Hosting account is not working', 3, 1009, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY)),
('MySQL database from my desktop application', 4, 1010, NOW(), DATE_ADD(NOW(), INTERVAL 15 DAY)),
('Develop new WordPress plugin for my business website', 2, NULL, NOW(), DATE_ADD(NOW(), INTERVAL 10 DAY)),
('Migrate web application and database to new server', 2, NULL, NOW(), DATE_ADD(NOW(), INTERVAL 5 DAY)),
('Android Application development', 4, 1004, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY)
);

SELECT * FROM Employee;
SELECT * FROM Projects;

-- Оператор EXISTS
/*
1.	Получите из таблицы "Сотрудники" только тех сотрудников, которые в данный момент работают над любым из активных проектов.
2.	Проверьте, существует ли сотрудник с идентификатором 1004 в таблице сотрудников или нет.
*/

-- 1
SELECT *
FROM Employee e
WHERE EXISTS (SELECT * FROM Projects p WHERE e.Id = p.EmployeeId);

-- 2
SELECT EXISTS (SELECT * FROM Employee WHERE Id = 1004) res;


