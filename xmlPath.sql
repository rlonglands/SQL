SELECT	SubcategoryName = a.[Name]
		,Products = STUFF(
		(
		SELECT
		';' + [Name]
		FROM [Production].[Product] b
		WHERE a.[ProductSubcategoryID] = b.[ProductSubcategoryID]
		FOR XML PATH('')
		),
		1,1,'')


FROM [Production].[ProductSubcategory] a
