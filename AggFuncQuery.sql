SELECT
A.[Name],
[Total Sales] = SUM (B.[LineTotal]),
[Number of Sales] = COUNT(*)

FROM [Production].[Product] A
JOIN [Purchasing].[PurchaseOrderDetail] B 
ON A.[ProductID] = B.[ProductID]

GROUP BY A.[Name]

HAVING SUM (B.[LineTotal]) < 10000

ORDER BY [Total Sales]