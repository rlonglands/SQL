SELECT *

FROM 
(
SELECT
		[VacationHours]
		,[JobTitle] 

FROM [HumanResources].[Employee]
) A

PIVOT (
SUM([VacationHours])
FOR [JobTitle] IN ([Sales Representative], Buyer, Janitor)
) B


