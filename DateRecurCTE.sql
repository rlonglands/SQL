WITH DateSeries AS
(
SELECT 1 AS MyDate

UNION All

SELECT
MyDate +2
From DateSeries
WHERE MyDate < 100
)

SELECT
MyDate
FROM DateSeries
OPTION(MAXRECURSION 365)
