# sql-crud-payments

# About the project

This is project made in SQL server that creates a databse that captures users' payments using CRUD (create, read, update, delete) executions.

## How to prepare the daabase and the procedures

The .sqls were created using Microsoft SQL Server, so if you want to test out the database you should use that SQL flavor.

The .sqls should be run in the following order:

1. create_tables.sql
2. insert_procedures.sql
3. update_procedures.sql
4. delete_procedures.sql
5. read_procedures.sql
6. executions.sql

## About the database 

The database holds 7 tables:
- 1 fact table called payments
- 5 dimensional tables: payment_methods, short_descriptions, cities, states, y users
- 1 log table called logtable

You can see how these tables are connected with the ERD diagram found in [lucidchart](https://lucid.app/lucidchart/c8a0c62e-617b-4e43-ae38-e6953d4df93d/edit?viewport_loc=-438%2C-223%2C2509%2C1250%2C0_0&invitationId=inv_b15feb98-04cc-43f5-9c59-d170c275b5aa)



The database satisfies the third form of normalization (3NF). The first form of normalizationis satisfied since there are no fields that contains multiple values and there is no duplicate rows. In fact, if you try to insert an already existing row using the corresponding insert executions, the row will not be inserted into the table. The second form of normalization is satisfied since there is no primary keys that consist of more than one column, all primary keys are composed of a single column. The third form of normalization is satisfied since there is no field in any table that defines a value of another field in the same table.


The logtable captures when a table is created or modified, the type of modification (CREATE, INSERT, UPDATE, DELETE) and the row that has been modified (in case of CREATE, the row will be NULL since no row is being modfied)

## About the procedures

For every element of CRUD plus the INSERT there exit a corresponding .sql file that creates procedures for that functionality.

Cuando se corre el procedimiento relacionado al DELETE se hace una alteración a una variable invisible llamada delted y no se despliega cuando se corre el procedimiento de lectura. Esto es un borrado lógico y se pueden seguir consultado estos registros pero solamente si se hacen consultas fuera del procedimiento read_table.

When delete procedures are executed, the data is soft deleted in table. Every table has a 'deleted' field which by default is 0, when the delete procedure is executed this value is modified to 1 and respective rows with this value are not shown when executing the read_table procedure.

The proedure are executed in the executions.sql file and if you want to know how each of them work you can read the respective .sql file to know how the proedure works.
