CREATE OR ALTER PROCEDURE insert_payment (
	@value FLOAT,
	@city_name VARCHAR(100),
	@payment_method_name VARCHAR(100),
	@short_description_name VARCHAR(100),
	@user VARCHAR(100))
AS 
BEGIN
	-- GETTING CITY ID --
	--Values that are not found in the cities table will be returned as nulls

	DECLARE @city_id INT
	SET @city_id = (
		SELECT city_id
		FROM cities
		WHERE city = @city_name
		)
	-- GETTING PAYMENT_METHOD ID --
	--Values that are not found in the payment_methods table will be returned as nulls

	DECLARE @payment_method_id INT
	SET @payment_method_id = (
		SELECT payment_method_id
		FROM payment_methods
		WHERE payment_method = @payment_method_name
	)

	-- GETTING USER ID --
	--Users that are not found in the users table will be added to the users table

	--checking if the payment's user is already registered
	IF @user NOT IN (
		SELECT DISTINCT username
		FROM users
	)
	--If it does not exist, it will be added to the users table
	BEGIN
		EXEC insert_user @username = @user
	END
	--getting the user_id given the @user variable from the users table
	DECLARE @user_id INT
	SET @user_id = (
		SELECT user_id
		FROM users
		WHERE username = @user
		)

	--GETTING SHORT DESCRIPTION ID
	--Values not found in the short_descriptions table will be added to the short_descriptions table
	--checking if the payment's short description is already registered
	IF @short_description_name NOT IN (
		SELECT DISTINCT short_description
		FROM short_descriptions
	)
	--If it does not exist, it will be added to the short_descriptions table
	BEGIN
		EXEC insert_short_description @short_description = @short_description_name
	END
	--getting the user_id given the @user variable from the users table
	DECLARE @short_description_id INT
	SET @short_description_id = (
		SELECT short_description_id
		FROM short_descriptions
		WHERE short_description = @short_description_name
		)
		INSERT INTO payments (value, city_id, payment_method_id, payment_time, short_description_id, user_id)
		VALUES (@value, @city_id, @payment_method_id, GETDATE(), @short_description_id, @user_id)

		DECLARE @payment_id INT
		SET @payment_id = (
			SELECT MAX(id)
			FROM payments
		)
		INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
		VALUES (GETDATE(), 'payments', 'INSERT', @payment_id)
END;
GO


CREATE OR ALTER PROCEDURE insert_city (@city VARCHAR(100), @state_name VARCHAR(100)) AS
BEGIN
	--Checking if @city is actually not found in the cities table (want to avoid duplicates)
	IF @city NOT IN (
		SELECT DISTINCT city
		FROM cities
	)
	BEGIN
		--Checking if @state_name is in the states table
		IF @state_name NOT IN (
			SELECT DISTINCT country_state
			FROM states
		)
		--If it does not exist, it will be added to the states table
		BEGIN
			EXEC insert_state @country_state = @state_name
		END
		--getting the state_id given the @state_name variable from the states table
		DECLARE @state_id INT
		SET @state_id = (
			SELECT state_id
			FROM states
			WHERE country_state = @state_name
		)
		INSERT INTO cities (city, state_id)
		VALUES (@city, @state_id)

		DECLARE @city_id INT
		SET @city_id = (
			SELECT city_id
			FROM cities
			WHERE city = @city
		)
		INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
		VALUES (GETDATE(), 'cities', 'INSERT', @city_id)
	END

END;
GO

CREATE OR ALTER PROCEDURE insert_state (@country_state VARCHAR(100)) AS
BEGIN
	IF @country_state NOT IN (
		SELECT DISTINCT country_state
		FROM states
	)
	BEGIN
		INSERT INTO states (country_state)
		VALUES (@country_state)

		DECLARE @state_id INT
		SET @state_id = (
			SELECT state_id
			FROM states
			WHERE country_state = @country_state
		)
		INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
		VALUES (GETDATE(), 'states', 'INSERT', @state_id)
	END
END;
GO

CREATE OR ALTER PROCEDURE insert_payment_method (@payment_method VARCHAR(100)) AS
BEGIN
	IF @payment_method NOT IN (
		SELECT payment_method
		FROM payment_methods
	)
	BEGIN
		INSERT INTO payment_methods (payment_method)
		VALUES (@payment_method)

		DECLARE @payment_method_id INT
		SET @payment_method_id = (
			SELECT payment_method_id
			FROM payment_methods
			WHERE payment_method = @payment_method
		)
		INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
		VALUES (GETDATE(), 'payment_methods', 'INSERT', @payment_method_id)
	END
END;
GO

CREATE OR ALTER PROCEDURE insert_short_description (@short_description VARCHAR(100)) AS
BEGIN
	IF @short_description NOT IN (
		SELECT short_description
		FROM short_descriptions
	)
	BEGIN
		INSERT INTO short_descriptions (short_description)
		VALUES (@short_description)
		
		DECLARE @short_description_id INT
		SET @short_description_id = (
			SELECT short_description_id
			FROM short_descriptions
			WHERE short_description = @short_description
		)
		INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
		VALUES (GETDATE(), 'short_descriptions', 'INSERT', @short_description_id)
	END
END;
GO

CREATE OR ALTER PROCEDURE insert_user (@username varchar(100)) AS
BEGIN
	IF @username NOT IN (
		SELECT username
		FROM users
	)
	BEGIN
		INSERT INTO users (username)
		VALUES (@username)

		DECLARE @user_id INT
		SET @user_id = (
			SELECT user_id
			FROM users
			WHERE username = @username
		)
		INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
		VALUES (GETDATE(), 'users', 'INSERT', @user_id)
	END
END;
GO