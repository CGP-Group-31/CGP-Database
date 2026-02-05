SELECT name
 FROM sys.tables;

CREATE PROCEDURE sp_DisplayAllTables
AS 
BEGIN
	SELECT name
	FROM sys.tables;
END;

EXEC sp_DisplayAllTables;

CREATE PROCEDURE sp_DisplayTable
	@Name SYSNAME
AS
BEGIN
	DECLARE @sql NVARCHAR(MAX);

	SET @sql = N'SELECT * FROM'+QUOTENAME(@Name);

	EXEC sp_executesql @sql;
END;

EXEC sp_DisplayAllTables;
EXEC sp_DisplayTable 'Roles';