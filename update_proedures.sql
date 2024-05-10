CREATE OR ALTER PROCEDURE update_payment (
	@id INT,
	@value FLOAT,
	@city_name VARCHAR(100),
	@payment_method VARCHAR(100),
	@short_description VARCHAR(100),
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
		WHERE payment_method = @payment_method
	)

	-- GETTING USER ID --
	--Values that are not found in the users table will be added to the users table

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
	IF @short_description NOT IN (
		SELECT DISTINCT short_description
		FROM short_descriptions
	)
	--If it does not exist, it will be added to the short_descriptions table
	BEGIN
		EXEC insert_short_description @short_description = @short_description
	END
	--getting the user_id given the @user variable from the users table
	DECLARE @short_description_id INT
	SET @short_description_id = (
		SELECT short_description_id
		FROM short_descriptions
		WHERE short_description = @short_description
		)
		UPDATE payments
		SET value = @value, city_id = @city_id, payment_method_id = @payment_method_id, short_description_id = @short_description_id, user_id = @user_id
		WHERE id = @id

		INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
		VALUES (GETDATE(), 'payments', 'UPDATE', @id)
END;
GO


CREATE OR ALTER PROCEDURE update_city (@city_id INT, @city VARCHAR(100), @state_name VARCHAR(100)) AS
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
		UPDATE cities
		SET city = @city, state_id = @state_id
		WHERE city_id = @city_id

		INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
		VALUES (GETDATE(), 'cities', 'UPDATE', @city_id)
	END

END;
GO

CREATE OR ALTER PROCEDURE update_state (@state_id INT, @country_state VARCHAR(100)) AS
BEGIN
	UPDATE states
	SET country_state = @country_state
	WHERE state_id = @state_id

	INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
	VALUES (GETDATE(), 'states', 'UPDATE', @state_id)
END;
GO

CREATE OR ALTER PROCEDURE update_payment_method (@payment_method_id INT, @payment_method VARCHAR(100)) AS
BEGIN
	UPDATE payment_methods
	SET payment_method = @payment_method
	WHERE payment_method_id = @payment_method_id

	INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
	VALUES (GETDATE(), 'payment_methods', 'UPDATE', @payment_method_id)
END;
GO

CREATE OR ALTER PROCEDURE update_short_description (@short_description_id INT, @short_description VARCHAR(100)) AS
BEGIN
	UPDATE short_descriptions
	SET short_description = @short_description
	WHERE short_description_id = @short_description_id

	INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
	VALUES (GETDATE(), 'short_descriptions', 'UPDATE', @short_description_id)
END;
GO

CREATE OR ALTER PROCEDURE update_user (@user_id INT, @username varchar(100)) AS
BEGIN
	UPDATE users
	SET username = @username
	WHERE user_id = @user_id

	INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
	VALUES (GETDATE(), 'users', 'UPDATE', @user_id)
END;
GO