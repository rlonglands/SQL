--Starter code:
DECLARE @MaxVacHours INT
SET @MaxVacHours = (SELECT MAX(VacationHours) FROM AdventureWorks2019.HumanResources.Employee)



SELECT
	   BusinessEntityID
      ,JobTitle
      ,VacationHours
	  ,MaxVacationHours = @MaxVacHours
	  ,PercentOfMaxVacationHours = (VacationHours * 1.0) / @MaxVacHours
	  ,[TODAY] = dbo.ufnCurrentDate()
FROM AdventureWorks2019.HumanResources.Employee

WHERE (VacationHours * 1.0) / @MaxVacHours >= 0.8

