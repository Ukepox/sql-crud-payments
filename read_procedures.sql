CREATE OR ALTER PROCEDURE read_table @table NVARCHAR(100) AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    DECLARE @column_list NVARCHAR(MAX);

    SELECT @column_list = STRING_AGG(QUOTENAME(name), ', ')
    FROM sys.columns                            
    WHERE object_id = OBJECT_ID(@table) AND name != 'deleted';

    SET @sql = N'SELECT ' + @column_list + N' FROM ' + QUOTENAME(@table) + N'WHERE deleted = 0';

    EXEC sp_executesql @sql;
END