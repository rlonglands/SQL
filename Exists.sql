SELECT *
			   
FROM [Purchasing].[PurchaseOrderHeader] a

WHERE EXISTS
(
SELECT 1
FROM [Purchasing].[PurchaseOrderDetail] b
WHERE a.[PurchaseOrderID] = b.[PurchaseOrderID]
AND [OrderQty] > 500
AND [UnitPrice] > 50
)



