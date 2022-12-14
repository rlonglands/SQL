USE [AdventureWorks2019]
GO
/****** Object:  StoredProcedure [dbo].[OrdersAboveThreshold]    Script Date: 25/11/2022 12:26:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[OrdersAboveThreshold] (@Threshold MONEY, @StartYear INT, @EndYear INT, @OrderType INT)

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
	
	ELSE
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

END