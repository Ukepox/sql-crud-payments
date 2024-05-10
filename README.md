# sql-crud-payments

## Acerca de cómo preparar la base de datos y cómo ejecutar los procedimientos

Los .sqls fueron desarrollados en Microsoft SQL Server, por lo que se recomienda correrlos en dicho sql flavor

El orden en el cual se deberían de correr los .sqls es el siguiente:

1. create_tables.sql
2. insert_procedures.sql
3. update_procedures.sql
4. delete_procedures.sql
5. read_procedures.sql
6. executions.sql

## Acerca de la base de datos creada

La base de datos consiste de 7 tablas :
- 1 tabla operativa llamada payments
- 5 tablas dimensionales: payment_methods, short_descriptions, cities, states, y users
- 1 tabla bitácora llamada logtable

Pueden ver como se relacionan todas las tablas a excepción de la tabla de bitácora en el diagrama entidad-relación encontrada en [lucidchart](https://lucid.app/lucidchart/c8a0c62e-617b-4e43-ae38-e6953d4df93d/edit?viewport_loc=-438%2C-223%2C2509%2C1250%2C0_0&invitationId=inv_b15feb98-04cc-43f5-9c59-d170c275b5aa)


Las tablas que se muestran en el diagrama de entidad relación anterior cumplen la tercera forma de normalización (3NF). La primera forma se cumple ya que no hay campos con múltiples valores y no hay registros duplicados. Si se intenta insertar un registro ya establecido en una de las tablas dimensionales con los procedimientos de insersión no quedará registrado. La segunda forma de normalización se cumple autamáticamente ya que no hay tablas con múltiples campos como parte de su llave primaria. Y finalmente, la tercera forma de normalizacion se cumple ya no hay campos que definen el valor de otro campo en las tablas. De hecho, esta base de datos está normalizada más allá de los criterios del 3NF ya que se crearon las tablas de users y short_descriptions que ayudan a evitar redundancia dentro de la tabla operativa.


La tabla bitácora captura el tiempo en la cual se hizo una modificación, la tabla modificada, el tipo de modificación (CREATE, INSERT, UPDATE, DELETE) y el renglón de la tabla que fue afectada por dicha modificación si existe (en CREATE no se altera ninguna fila, entonces aparece como NULL)

## Acerca de los procedimientos

Por cada uno de los elementos del CRUD y el INSERT se tiene su respectivo .sql para crear sus procedimientos.

Cuando se corre el procedimiento relacionado al DELETE se hace una alteración a una variable invisible llamada delted y no se despliega cuando se corre el procedimiento de lectura. Esto es un borrado lógico y se pueden seguir consultado estos registros pero solamente si se hacen consultas fuera del procedimiento read_table.

Se recomienda revisar el código en executions.sql para aprender de cómo funcionan dichos proedimientos en su ejecución y si se quiere saber cómo funcionan revisar el .sql respectivo según el trabajo del procedimiento.

## Áreas de mejora

La solución presentada cumple con los requisitos, sin embargo hay algunas áreas de mejora que se podrían implementar:

1. No se puede actualizar el tiempo de un pago previo con los procedimientos establecidos, para lograr esto se tendría que correr directamente un UPDATE SET WHERE
2. La manera en que se están insertando valores a la tabla de logtable es muy tedioso por cada vez que se quiera desarrollar un nuevo procedimiento. Se podría utilizar una tabla de bitácora construida naturalmente en la base de datos como la tabla FN_DBLOG(NULL,NULL)