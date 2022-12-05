SELECT ProductName = a.[Name]
	   ,a.[ListPrice]
	   ,ProductSubcategory = b.[Name]
	   ,ProductCategory = c.[Name]
	   ,PriceRank = RANK() OVER(ORDER BY a.[ListPrice] DESC)
	   ,CategoryPriceRank = RANK() OVER(PARTITION BY c.[Name] ORDER BY a.[ListPrice] DESC)
	   ,Top5PriceInCategory = 
			CASE 
			WHEN (RANK() OVER(PARTITION BY c.[Name] ORDER BY a.[ListPrice] DESC)) < 6 THEN 'YES'
			ELSE 'NO'			
			END	

FROM Production.Product a
JOIN [Production].[ProductSubcategory] b
ON a.[ProductSubcategoryID] = b.[ProductSubcategoryID]
JOIN [Production].[ProductCategory] c
ON b.[ProductCategoryID] = c.[ProductCategoryID]


