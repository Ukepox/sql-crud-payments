
--INSERTING CITIES USING PROCEDURES
EXEC insert_city @city = 'Monterrey', @state_name = 'Nuevo Leon'
EXEC insert_city @city = 'Puerto Vallarta', @state_name = 'Jalisco'
EXEC insert_city @city = 'Santa Catarina', @state_name = 'Nuevo Leon';
EXEC insert_city @city = 'Cancun', @state_name = 'Yucatan';
EXEC insert_city @city = 'Guadalajara', @state_name = 'Jalisco';
EXEC insert_city @city = 'Cumbres', @state_name = 'Nuevo Leon';
EXEC insert_city @city = 'Cumbres', @state_name = 'Nuevo Leon';

EXEC read_table @table = 'cities';

--INSERTING PAYMENT_METHODS USING PROCEDURES
EXEC insert_payment_method @payment_method = 'Efectivo';
EXEC insert_payment_method @payment_method = 'Tarjeta de Credito';
EXEC insert_payment_method @payment_method = 'Tarjeta de Debito';
EXEC insert_payment_method @payment_method = 'Cheque';

EXEC read_table @table = 'payment_methods';



EXEC insert_payment 
	@value = 42,
	@city_name = 'Cancun',
	@payment_method_name = 'Tarjeta de Debito',
	@short_description_name = 'prueba',
	@user = 'Julio'
;

EXEC insert_payment 
	@value = 21,
	@city_name = 'Monterrey',
	@payment_method_name = 'Tarjeta de Credito',
	@short_description_name = 'prueba',
	@user = 'Erick'
;

EXEC update_user
	@user_id = 2,
	@username = 'Eric'
EXEC update_payment
	@id = 2,
	@value = 2.1,
	@city_name = 'Cumbres',
	@payment_method = 'Efectivo',
	@short_description = 'Primera compra',
	@user = 'Eric';

EXEC read_table @table = 'payments';

EXEC read_logtable;
