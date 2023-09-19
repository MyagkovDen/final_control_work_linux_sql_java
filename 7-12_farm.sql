-- 7.  В подключенном MySQL репозитории создать базу данных “Друзья человека”
CREATE DATABASE human_friends;
USE human_friends;

-- 8.Создать таблицы с иерархией из диаграммы в БД
CREATE TABLE dogs 
( 
	id int PRIMARY KEY AUTO_INCREMENT,
	name varchar(25) NOT NULL,
	commands varchar(25) NOT NULL,
	birthdate date NOT null
);

CREATE TABLE cats 
( 
	id int PRIMARY KEY AUTO_INCREMENT,
	name varchar(25) NOT NULL,
	commands varchar(25) NOT NULL,
	birthdate date NOT null
);

CREATE TABLE hamsters 
( 
	id int PRIMARY KEY AUTO_INCREMENT,
	name varchar(25) NOT NULL,
	commands varchar(25) NOT NULL,
	birthdate date NOT null
);

CREATE TABLE horses 
( 
	id int PRIMARY KEY AUTO_INCREMENT,
	name varchar(25) NOT NULL,
	commands varchar(25) NOT NULL,
	birthdate date NOT null
);

CREATE TABLE camels 
( 
	id int PRIMARY KEY AUTO_INCREMENT,
	name varchar(25) NOT NULL,
	commands varchar(25) NOT NULL,
	birthdate date NOT null
);

CREATE TABLE donkeys 
( 
	id int PRIMARY KEY AUTO_INCREMENT,
	name varchar(25) NOT NULL,
	commands varchar(25) NOT NULL,
	birthdate date NOT null
);

-- 9. Заполнить низкоуровневые таблицы именами(животных), командами, которые они выполняют и датами рождения
INSERT INTO dogs (name, commands, birthdate)
VALUES ('jack', 'sit', '2006-05-12');
INSERT INTO dogs (name, commands, birthdate)
VALUES ('rex', 'stand', '2020-04-11');
INSERT INTO dogs (name, commands, birthdate)
VALUES ('chara', 'towards', '2017-01-25');

INSERT INTO cats (name, commands, birthdate)
VALUES ('kit', 'eat', '2005-12-25');
INSERT INTO cats (name, commands, birthdate)
VALUES ('barsik', 'lay', '2015-09-23');
INSERT INTO cats (name, commands, birthdate)
VALUES ('marsi', 'drink', '2010-11-14');

INSERT INTO hamsters (name, commands, birthdate)
VALUES ('archi', 'run', '2022-10-30');
INSERT INTO hamsters (name, commands, birthdate)
VALUES ('stella', 'stop', '2021-03-08');
INSERT INTO hamsters (name, commands, birthdate)
VALUES ('maris', 'jump', '2023--2-15');
SELECT * FROM hamsters c ;

INSERT INTO horses (name, commands, birthdate)
VALUES ('red', 'go', '2015-01-03');
INSERT INTO horses (name, commands, birthdate)
VALUES ('black', 'come on', '2017-07-11');
INSERT INTO horses (name, commands, birthdate)
VALUES ('white', 'come back', '2021-11-02');

INSERT INTO camels (name, commands, birthdate)
VALUES ('johar', 'sleep', '2003-12-10');
INSERT INTO camels (name, commands, birthdate)
VALUES ('mehmed', 'roll', '2008-08-09');
INSERT INTO camels (name, commands, birthdate)
VALUES ('husrev', 'walk', '2013-06-24');

INSERT INTO donkeys (name, commands, birthdate)
VALUES ('ass', 'stop', '2010-06-01');
INSERT INTO donkeys (name, commands, birthdate)
VALUES ('dump', 'go', '2011-09-06');
INSERT INTO donkeys (name, commands, birthdate)
VALUES ('wise', 'say', '2012-12-12');
SELECT * FROM horses_and_donkeys c    ;


-- 10. 	Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой питомник на зимовку. 
--		Объединить таблицы лошади, и ослы в одну таблицу.
TRUNCATE TABLE camels; 

CREATE TABLE horses_and_donkeys AS 
SELECT * FROM horses h 
UNION ALL
SELECT * FROM donkeys d ;

-- 11.Создать новую таблицу “молодые животные” в которую попадут все животные старше 1 года, 
-- но младше 3 лет и в отдельном столбце с точностью до месяца подсчитать возраст животных в новой таблице

CREATE TABLE young_animals 
( 
	id int PRIMARY KEY AUTO_INCREMENT,
	name varchar(25) NOT NULL,
	commands varchar(25) NOT NULL,
	birthdate date NOT NULL,
	age varchar(25)
);

INSERT INTO young_animals (name, commands, birthdate)
SELECT t.name, t.commands, t.birthdate
FROM dogs AS t
WHERE (DATEDIFF(CURDATE(), t.birthdate) BETWEEN 365 AND (365 * 3));

INSERT INTO young_animals (name, commands, birthdate)
SELECT t.name, t.commands, t.birthdate
FROM cats AS t
WHERE (DATEDIFF(CURDATE(), t.birthdate) BETWEEN 365 AND (365 * 3));

INSERT INTO young_animals (name, commands, birthdate)
SELECT t.name, t.commands, t.birthdate
FROM hamsters AS t
WHERE (DATEDIFF(CURDATE(), t.birthdate) BETWEEN 365 AND (365 * 3));


INSERT INTO young_animals (name, commands, birthdate)
SELECT t.name, t.commands, t.birthdate
FROM horses AS t
WHERE (DATEDIFF(CURDATE(), t.birthdate) BETWEEN 365 AND (365 * 3));


INSERT INTO young_animals (name, commands, birthdate)
SELECT t.name, t.commands, t.birthdate
FROM donkeys AS t
WHERE (DATEDIFF(CURDATE(), t.birthdate) BETWEEN 365 AND (365 * 3));

delimiter $$
CREATE FUNCTION get_age_in_years_and_months (birthdate date) RETURNS varchar(25) DETERMINISTIC
BEGIN 
	DECLARE age varchar(25); 
	SELECT CONCAT(
    FLOOR(DATEDIFF(CURDATE() , birthdate) / 365), ' years, ',
    MOD(FLOOR(DATEDIFF(CURDATE() , birthdate) / 30.44), 12), ' months')
   	INTO age;
   	RETURN age;
END $$
delimiter

delimiter $$
CREATE PROCEDURE fill_age_in_young_animals () 
BEGIN 
	DECLARE i int DEFAULT 1;
	DECLARE day_of_birth date;
	WHILE i <= (SELECT max(id) FROM young_animals) do 
		SELECT birthdate FROM young_animals WHERE id = i INTO day_of_birth;
		UPDATE young_animals 
		SET age = (SELECT get_age_in_years_and_months (day_of_birth))
		WHERE id = i;
	 	SELECT (i + 1) INTO i;
	END WHILE;
END $$
delimiter

CALL fill_age_in_young_animals();

-- 12. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую принадлежность к старым таблицам.

CREATE TABLE all_animals as
SELECT * FROM horses_and_donkeys 
UNION ALL
SELECT * FROM dogs
UNION ALL
SELECT * FROM cats 
UNION ALL
SELECT * FROM hamsters;

SELECT * FROM all_animals;






