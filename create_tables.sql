/*
DROP TABLE payments;
DROP TABLE cities;
DROP TABLE states;
DROP TABLE payment_methods;
DROP TABLE users;
DROP TABLE short_descriptions;
DROP TABLE logtable;
*/

CREATE TABLE logtable (
	log_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	log_time DATETIME NOT NULL,
	table_modified VARCHAR(100) NOT NULL,
	modification_type VARCHAR(100) NOT NULL, --CREATE, INSERT, UPDATE, DELETE
	row_modified INT,
	INDEX log_index (log_time)
);

CREATE TABLE states (
	state_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	country_state VARCHAR(100),
	deleted INT DEFAULT 0
); 

INSERT INTO logtable (log_time, table_modified, modification_type)
VALUES (GETDATE(), 'states', 'CREATE');

CREATE TABLE cities (
	city_id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	city varchar(100),
	state_id INT,
	deleted TINYINT DEFAULT 0,
	FOREIGN KEY (state_id) REFERENCES states(state_id)
);

INSERT INTO logtable (log_time, table_modified, modification_type)
VALUES (GETDATE(), 'cities', 'CREATE');

CREATE TABLE payment_methods (
	payment_method_id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	payment_method varchar(20),
	deleted TINYINT DEFAULT 0
);

INSERT INTO logtable (log_time, table_modified, modification_type)
VALUES (GETDATE(), 'payment_methods', 'CREATE');

CREATE TABLE users (
	user_id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	username varchar(100),
	deleted TINYINT DEFAULT 0

);

INSERT INTO logtable (log_time, table_modified, modification_type)
VALUES (GETDATE(), 'users', 'CREATE');

CREATE TABLE short_descriptions (
	short_description_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	short_description VARCHAR(100),
	deleted TINYINT DEFAULT 0
);

INSERT INTO logtable (log_time, table_modified, modification_type)
VALUES (GETDATE(), 'short_description', 'CREATE');

CREATE TABLE payments (
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	value FLOAT,
	city_id INT, 
	payment_method_id INT,
	payment_time DATETIME,
	short_description_id INT,
	user_id INT,
	deleted TINYINT DEFAULT 0
	INDEX payment_index (payment_time, city_id)
	FOREIGN KEY (city_id) REFERENCES cities(city_id),
	FOREIGN KEY (payment_method_id) REFERENCES payment_methods(payment_method_id),
	FOREIGN KEY (short_description_id) REFERENCES short_descriptions(short_description_id),
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO logtable (log_time, table_modified, modification_type)
VALUES (GETDATE(), 'payments', 'CREATE');