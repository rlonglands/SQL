USE [AdventureWorks2019]
GO
/****** Object:  StoredProcedure [dbo].[OrdersAboveThreshold]    Script Date: 25/11/2022 12:26:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrdersAboveThreshold2] (@Threshold MONEY, @StartYear INT, @EndYear INT, @OrderType INT)

AS

BEGIN
	IF @OrderType = 1
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
	
	IF @OrderType = 2
		BEGIN
			SELECT
			[PurchaseOrderID],
			OrderYear = YEAR([OrderDate]),
			[TotalDue]

			FROM 
			[Purchasing].[PurchaseOrderHeader]

			WHERE [TotalDue] > @Threshold
			AND YEAR([OrderDate]) BETWEEN @StartYear AND @EndYear		
		END

	ELSE
		BEGIN
		CREATE TABLE #orders
			(
			OrderID INT,
			OrderYear INT,
			TotalDue MONEY,
			OrderType VARCHAR(20)
			)
		INSERT INTO #orders
			SELECT 
				OrderID = a.[SalesOrderID],
				OrderYear = YEAR(a.[OrderDate]),
				[TotalDue] = a.[TotalDue],
				OrderType = 'Sales' 

			FROM 
				[Sales].[SalesOrderHeader]a

		INSERT INTO #orders
			SELECT 
				OrderID = b.[PurchaseOrderID],
				OrderYear = YEAR(b.[OrderDate]),
				[TotalDue] = b.[TotalDue],
				OrderType = 'Purchase'
			FROM 
				[Purchasing].[PurchaseOrderHeader] b

		SELECT * from #ORDERS

		END

END