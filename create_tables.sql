DROP TABLE payments;
DROP TABLE cities;
DROP TABLE states;
DROP TABLE payment_methods;
DROP TABLE users;
DROP TABLE short_descriptions;

CREATE TABLE payments (
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	value FLOAT,
	city_id INT, 
	payment_method_id INT,
	payment_time DATETIME,
	short_description_id INT,
	user_id INT,
	deleted TINYINT DEFAULT 0
);

CREATE TABLE cities (
	city_id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	city varchar(100),
	state_id INT,
	deleted TINYINT DEFAULT 0
);

CREATE TABLE states (
	state_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	country_state VARCHAR(100),
	deleted INT DEFAULT 0
); 

CREATE TABLE payment_methods (
	payment_method_id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	payment_method varchar(20),
	deleted TINYINT DEFAULT 0
);
CREATE TABLE users (
	user_id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	username varchar(100),
	deleted TINYINT DEFAULT 0

);
CREATE TABLE short_descriptions (
	short_description_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	short_description VARCHAR(100),
	deleted TINYINT DEFAULT 0
);

