
--INSERTING CITIES USING PROCEDURES
EXEC insert_city @city = 'Monterrey', @state_name = 'Nuevo Leon'
EXEC insert_city @city = 'Puerto Vallarta', @state_name = 'Jalisco'
EXEC insert_city @city = 'Santa Catarina', @state_name = 'Nuevo Leon';
EXEC insert_city @city = 'Cancun', @state_name = 'Yucatan';
EXEC insert_city @city = 'Guadalajara', @state_name = 'Jalisco';
EXEC insert_city @city = 'Cumbres', @state_name = 'Nuevo Leon';

--INSERTING PAYMENT_METHODS USING PROCEDURES
EXEC insert_payment_method @payment_method = 'Efectivo';
EXEC insert_payment_method @payment_method = 'Tarjeta de Credito';
EXEC insert_payment_method @payment_method = 'Tarjeta de Debito';
EXEC insert_payment_method @payment_method = 'Cheque';

SELECT *
FROM payment_methods;



EXEC insert_payment 
	@value = 42,
	@city_name = 'Cancun',
	@payment_method_name = 'Tarjeta de Debito',
	@payment_date = '2024-05-07',
	@short_description_name = 'prueba',
	@user = 'Julio'
;

EXEC insert_payment 
	@value = 21,
	@city_name = 'Monterrey',
	@payment_method_name = 'Tarjeta de Credito',
	@payment_date = '2024-06-07',
	@short_description_name = 'prueba',
	@user = 'Erick'
;
SELECT *
FROM payments;

