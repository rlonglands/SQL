CREATE PROCEDURE dbo.OrdersAboveThreshold (@Threshold MONEY, @StartYear INT, @EndYear INT)

AS

BEGIN
	SELECT
	[SalesOrderID],
	OrderYear = YEAR([OrderDate]),
	[TotalDue]

	FROM 
	[Sales].[SalesOrderHeader]

	WHERE [TotalDue] > @Threshold
	AND YEAR([OrderDate]) BETWEEN @StartYear AND @EndYear

END



EXEC dbo.OrdersAboveThreshold 100000, 2011, 2014