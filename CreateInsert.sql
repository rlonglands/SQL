CREATE TABLE #Orders
(
	OrderDate DATE,
	OrderMonth DATE,
	OrderType VARCHAR(32),
	TotalDue MONEY,
	OrderRank INT
)

INSERT INTO #Orders
(
OrderDate,
OrderMonth,
OrderType,
TotalDue,
OrderRank
)

SELECT 
       OrderDate
	  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
	  ,OrderType = 'Sales'
      ,TotalDue
	  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)

FROM AdventureWorks2019.Sales.SalesOrderHeader

CREATE TABLE #OrdersMinusTop10
(
OrderMonth DATE,
OrderType VARCHAR(32),
TotalOrders MONEY,
)

INSERT INTO #OrdersMinusTop10
(
OrderMonth,
OrderType,
TotalOrders
)

SELECT
OrderMonth,
OrderType = 'Sales',
TotalSales = SUM(TotalDue)

FROM #Orders
WHERE OrderRank > 10
GROUP BY OrderMonth

SELECT * FROM #OrdersMinusTop10

TRUNCATE TABLE #Orders

INSERT INTO #Orders
(
OrderDate,
OrderMonth,
OrderType,
TotalDue,
OrderRank
)

SELECT 
       OrderDate
	  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
	  ,OrderType = 'Purchase'
      ,TotalDue
	  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)

FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader

SELECT *FROM #Orders

INSERT INTO #OrdersMinusTop10
(
OrderMonth,
OrderType,
TotalOrders
)

SELECT
OrderMonth,
OrderType = 'Purchases',
TotalOrders = SUM(TotalDue)

FROM #Orders
WHERE OrderRank > 10
GROUP BY OrderMonth


INSERT INTO #OrdersMinusTop10


SELECT
A.OrderMonth,
TotalSales = A.TotalOrders,
TotalPurchases = B.TotalOrders

FROM #OrdersMinusTop10 A
	JOIN #OrdersMinusTop10 B
		ON A.OrderMonth = B.OrderMonth
			--AND B.OrderType = 'Sales'

--WHERE A.OrderType = 'Purchase'

ORDER BY 1


SELECT * FROM #OrdersMinusTop10

DROP TABLE #Orders
DROP TABLE #OrdersMinusTop10
