CREATE OR ALTER PROCEDURE delete_payment (@id INT) AS
BEGIN
	UPDATE payments
	SET deleted = 1
	WHERE id = @id

	INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
	VALUES (GETDATE(), 'payments', 'DELETE', @id)
END;
GO

CREATE OR ALTER PROCEDURE delete_city (@city_id INT) AS
BEGIN
	UPDATE cities
	SET deleted = 1
	WHERE city_id = @city_id

	INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
	VALUES (GETDATE(), 'cities', 'DELETE', @city_id)
END;
GO

CREATE OR ALTER PROCEDURE delete_state (@state_id INT) AS
BEGIN
	UPDATE states
	SET deleted = 1
	WHERE state_id = @state_id

	INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
	VALUES (GETDATE(), 'states', 'DELETE', @state_id)
END;
GO

CREATE OR ALTER PROCEDURE delete_payment_method (@payment_method_id INT) AS
BEGIN
	UPDATE payment_methods
	SET deleted = 1
	WHERE payment_method_id = @payment_method_id

	INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
	VALUES (GETDATE(), 'payment_methods', 'DELETE', @payment_method_id)
END;
GO

CREATE OR ALTER PROCEDURE delete_user (@user_id INT) AS
BEGIN
	UPDATE users
	SET deleted = 1
	WHERE user_id = @user_id

	INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
	VALUES (GETDATE(), 'users', 'DELETE', @user_id)
END;
GO

CREATE OR ALTER PROCEDURE delete_short_description (@short_description_id INT) AS
BEGIN
	UPDATE short_descriptions
	SET deleted = 1
	WHERE short_description_id = @short_description_id

	INSERT INTO logtable (log_time, table_modified, modification_type, row_modified)
	VALUES (GETDATE(), 'short_descriptions', 'DELETE', @short_description_id)
END;
GO

