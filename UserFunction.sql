USE AdventureWorks2019

GO

CREATE FUNCTION dbo.ufnpercent(@num1 INT, @num2 INT)

RETURNS VARCHAR(50)

BEGIN
RETURN
(
SELECT FORMAT(@num1 * 100.0 / @num2, 'N2')
)
END

SELECT dbo.ufnpercent(30, 10)