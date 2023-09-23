--Data Exploration

--To ensure the table has been imported

--Select Data that we are going to be using

SELECT *
FROM IBM_HR_Analytics.dbo.IBMHR

-- Great. It seems all good

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- As it takes a long time to return large amount of data, we can select top 10% rows to check out what we have in the table.

SELECT TOP 10 PERCENT *
FROM IBM_HR_Analytics.dbo.IBMHR

-- Yes, we have age, attrition, department, education and so on.
-- Let's look at some demographic information in IBM.

----------------------------------------------------------------------------------------------------------------------------------------------
-- Let's look at the age

SELECT age, COUNT(EmployeeNumber) AS number_of_employee_in_age
FROM IBM_HR_Analytics.dbo.IBMHR
GROUP BY age
ORDER BY number_of_employee_in_age DESC

-- Woof! We count the number of employee in age.
-- We get the top 10 is in the age range between 29-40

-- We can explore more later by grouping them into age group.
----------------------------------------------------------------------------------------------------------------------------------------------
-- Let's look at the gender

SELECT Gender, COUNT(EmployeeNumber) AS number_of_employee_in_gender
FROM IBM_HR_Analytics.dbo.IBMHR
GROUP BY gender
ORDER BY number_of_employee_in_gender DESC

-- It shows there are more male employees.
----------------------------------------------------------------------------------------------------------------------------------------------
-- Let's look at the department

SELECT department, COUNT(EmployeeNumber) AS number_of_employee_in_dept
FROM IBM_HR_Analytics.dbo.IBMHR
GROUP BY department
ORDER BY number_of_employee_in_dept DESC

--We count the number of employees in department.
--It shows the reponses was collected in three department including Research & Development, Sales and Human Resources

----------------------------------------------------------------------------------------------------------------------------------------------
-- Let's look at the education

SELECT education, COUNT(EmployeeNumber) AS number_of_employee_in_edu
FROM IBM_HR_Analytics.dbo.IBMHR
GROUP BY education
ORDER BY number_of_employee_in_edu DESC

-- Most of employees have Bachelor degree or Master degree

----------------------------------------------------------------------------------------------------------------------------------------------
-- Let's look at the MonthlyIncome

-- Let's check the minimum monthly income

SELECT MIN (MonthlyIncome) 
FROM IBM_HR_Analytics.dbo.IBMHR

-- It shows the minimum monthly income is 1009 

SELECT MAX (MonthlyIncome) 
FROM IBM_HR_Analytics.dbo.IBMHR

-- It shows the maximum monthly income is 19999

SELECT AVG (MonthlyIncome) 
FROM IBM_HR_Analytics.dbo.IBMHR

-- It shows the average of monthly income is 6502.93

-- We can explore more later by grouping them into group.

----------------------------------------------------------------------------------------------------------------------------------------------
-- Let's look at the Hourly Rate

---- Let's check the minimum hourly rate

SELECT MIN (HourlyRate) 
FROM IBM_HR_Analytics.dbo.IBMHR

---- It shows the minimum hourly rate is 30

SELECT MAX (HourlyRate) 
FROM IBM_HR_Analytics.dbo.IBMHR

---- It shows the maximum hourly rate is 100

SELECT AVG (HourlyRate) 
FROM IBM_HR_Analytics.dbo.IBMHR

-- It shows the average of hourly rate is 65.89

-- We can explore more later by grouping them into group.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Let's look at the employee behavior in job.

-- Regarding to behavior, we will look at job involvement, performance rating and work life balance.

SELECT JobInvolvement, COUNT(EmployeeNumber) AS number_of_employee_in_jobinv
FROM IBM_HR_Analytics.dbo.IBMHR
GROUP BY JobInvolvement
ORDER BY number_of_employee_in_jobinv DESC

SELECT PerformanceRating, COUNT(EmployeeNumber) AS number_of_employee_in_perrating
FROM IBM_HR_Analytics.dbo.IBMHR
GROUP BY PerformanceRating
ORDER BY number_of_employee_in_perrating DESC

SELECT WorkLifeBalance, COUNT(EmployeeNumber) AS number_of_employee_in_wlbalance
FROM IBM_HR_Analytics.dbo.IBMHR
GROUP BY WorkLifeBalance
ORDER BY number_of_employee_in_wlbalance DESC

-- In overall, the majority of employees show great job involvement, with high performance rating and work life balance.

-- Other than performance, let's check out how many employee have to work overtime.

SELECT OverTime, COUNT(EmployeeNumber) AS number_of_employee_in_overtime
FROM IBM_HR_Analytics.dbo.IBMHR
GROUP BY OverTime
ORDER BY number_of_employee_in_overtime DESC

--It shows only few employees have to work overtime.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- After checking out the demographic informaiton, Let's look at satisfaction level.

-- Let's look at the job satisfaction, environment satisfaction and relationship satisfaction.

SELECT JobSatisfaction, COUNT(EmployeeNumber) AS number_of_employee_in_jobsat
FROM IBM_HR_Analytics.dbo.IBMHR
GROUP BY JobSatisfaction
ORDER BY number_of_employee_in_jobsat DESC

SELECT EnvironmentSatisfaction, COUNT(EmployeeNumber) AS number_of_employee_in_envsat
FROM IBM_HR_Analytics.dbo.IBMHR
GROUP BY EnvironmentSatisfaction
ORDER BY number_of_employee_in_envsat DESC

SELECT RelationshipSatisfaction, COUNT(EmployeeNumber) AS number_of_employee_in_relsat
FROM IBM_HR_Analytics.dbo.IBMHR
GROUP BY RelationshipSatisfaction
ORDER BY number_of_employee_in_relsat DESC

--It shows marjority of the employees show greater satisfaction including in job, environment and relationship.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Data Cleaning

--Group Age into Age Range

--One column named Age Range will be added to group the age range.
ALTER TABLE IBMHR
ADD AgeRange varchar(250);

-- The information is going to update to the new column AgeRange.

UPDATE IBMHR
SET AgeRange = 	CASE 
		WHEN Age BETWEEN 18 AND 19 THEN '18-19'
		WHEN Age BETWEEN 20 AND 29 THEN '20-29'
		WHEN Age BETWEEN 30 AND 39 THEN '30-39'
		WHEN Age BETWEEN 40 AND 49 THEN '40-49'
		WHEN Age BETWEEN 50 AND 59 THEN '50-59'
		WHEN Age BETWEEN 60 AND 65 THEN '60-65'
		ELSE '65+'
END
FROM IBM_HR_Analytics.dbo.IBMHR

--Done. We group into 7 age group, 18-19, 20-29, 30-39, 40-49, 50-59, 60-65 and 65+.

SELECT DISTINCT AgeRange, COUNT(EmployeeNumber) AS number_of_employee_in_agerange
FROM IBM_HR_Analytics.dbo.IBMHR
GROUP BY AgeRange
ORDER BY AgeRange

--It show most of employees are in age of 30-39 and there is no employee age over 65.
----------------------------------------------------------------------------------------------------------------------------------------------
--Group Monthly income into a range

--One column named MonthlyIncomeRange will be added to group the MonthlyIncome.

ALTER TABLE IBMHR
ADD MonthlyIncomeRange varchar(250);

-- The information is going to update to the new column MonthlyIncomeRange.

UPDATE IBMHR
SET MonthlyIncomeRange = 	CASE 
		WHEN MonthlyIncome < 1000 THEN 'Below 1000'
		WHEN MonthlyIncome BETWEEN 1000 AND 3999 THEN '1000-3999'
		WHEN MonthlyIncome BETWEEN 4000 AND 6999 THEN '4000-6999'
		WHEN MonthlyIncome BETWEEN 7000 AND 9999 THEN '7000-9999'
		WHEN MonthlyIncome BETWEEN 10000 AND 12999 THEN '10000-12999'
		WHEN MonthlyIncome BETWEEN 13000 AND 15999 THEN '13000-15999'
		WHEN MonthlyIncome BETWEEN 16000 AND 18999 THEN '16000-18999'
		ELSE '18999+'
END
FROM IBM_HR_Analytics.dbo.IBMHR

--Done. We group into 8 Monthly Income Range, Below 1000, 1000-3999, 4000-6999, 7000-9999, 10000-12999, 13000-15999, 16000-18999.

SELECT DISTINCT MonthlyIncomeRange, COUNT(EmployeeNumber) AS number_of_employee_in_MonIncRange
FROM IBM_HR_Analytics.dbo.IBMHR
GROUP BY MonthlyIncomeRange
ORDER BY number_of_employee_in_MonIncRange

--It show most of employees are having 1000-3900 and 4000-6999 in monthly income and no one earn less than 1000.
----------------------------------------------------------------------------------------------------------------------------------------------
--Hourly rate

ALTER TABLE IBMHR
ADD HourlyRateRange varchar(250);

----The information is going to update to the new column HourlyRateRange.

UPDATE IBMHR
SET HourlyRateRange = 	CASE 
		WHEN HourlyRate < 30 THEN 'Below 30'
		WHEN HourlyRate BETWEEN 30 AND 39 THEN '30-39'
		WHEN HourlyRate BETWEEN 40 AND 49 THEN '40-49'
		WHEN HourlyRate BETWEEN 50 AND 59 THEN '50-59'
		WHEN HourlyRate BETWEEN 60 AND 69 THEN '60-69'
		WHEN HourlyRate BETWEEN 70 AND 79 THEN '70-79'
		WHEN HourlyRate BETWEEN 80 AND 89 THEN '80-89'
		WHEN HourlyRate BETWEEN 90 AND 99 THEN '90-99'
		ELSE '99+'
END
FROM IBM_HR_Analytics.dbo.IBMHR

----Done. We group into 5 Hourly Rate Range, Below 30, 30-49, 50-69, 70-99 and 99+.

SELECT DISTINCT HourlyRateRange, COUNT(EmployeeNumber) AS number_of_employee_in_houratrange
FROM IBM_HR_Analytics.dbo.IBMHR
GROUP BY HourlyRateRange
ORDER BY number_of_employee_in_houratrange

--It shows only a few employee have 99+ Hourly Rate.
----------------------------------------------------------------------------------------------------------------------------------------------
--Check missing data

SELECT * 
FROM IBM_HR_Analytics.dbo.IBMHR
WHERE age IS NULL

--When we do the data exploration, we have count the number of employee in column we need and there is no null in those column.

--Remove duplicate data

--ROW_NUMBER() and PARTITION BY are used to check if there is duplicate data

SELECT *,
	ROW_NUMBER() OVER(
	PARTITION BY Age,
				Gender,
				Department,
				Education,
				MonthlyIncome
				ORDER BY
				EmployeeNumber)row_num
FROM IBM_HR_Analytics.dbo.IBMHR
ORDER BY EmployeeNumber

--we can see all the row_num is 1 and no duplicate data.
----------------------------------------------------------------------------------------------------------------------------------------------
--Delete Unused Columns

--For Demographic information
-- This time we only look at Age, Gender, Department, Education, MonthlyIncome, HourlyRate.

--For Employee behavior
--This time we only look at JobInvolvement, PerformanceRating, WorkLifeBalance and OverTime

--For Satisfaction Level
--This time we only look at job satisfaction, environment satisfaction and relationship satisfaction.

SELECT * 
FROM IBM_HR_Analytics.dbo.IBMHR

--so we will delete all unused columns.

ALTER TABLE IBMHR
DROP COLUMN Attrition, Business Travel, DailyRate, DistanceFromHome, EducationField, EmployeeCount

ALTER TABLE IBMHR
DROP COLUMN Joblevel, JobRole, MaritalStatus, MonthlyRate, NumCompaniesWorked, Over18, PercentSalaryHike

ALTER TABLE IBMHR
DROP COLUMN StandardHours, StockOptionLevel, TotalWorkingYears, TrainingTimesLastYear, YearsAtCompany, YearsInCurrentRole, YearsSinceLastPromotion, YearsWithCurrManager