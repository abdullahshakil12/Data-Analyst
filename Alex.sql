/* select * , DISTINCT, COUNT, MAX, MIN, AVG, AS*/

SELECT *
FROM employeedemographics;
SELECT *
FROM employeesalary;
SELECT distinct( EmployeeID)
From employeesalary;
select COUNT(LastName) AS LastName_Count
FROM employeedemographics;
SELECT MAX(Salary)
From employeesalary;
SELECT MIN(Salary)
From employeesalary;
SELECT AVG(Salary) AS Average_Salary
From EmployeeSalary;
/* WHERE = , <>,<,>, AND, OR, LIKE, IS NULL, IS NOT NULL, IN */
SELECT *
FROM employeedemographics
WHERE LastName = 'Shakil';
SELECT *
FROM employeedemographics
WHERE LastName<> 'Shakil';
SELECT *
FROM employeedemographics
WHERE Age >= 30;
SELECT *
FROM employeedemographics
WHERE Age <= 30;
SELECT *
FROM employeedemographics
WHERE Age >=30 and Gender = 'Male';
SELECT *
FROM employeedemographics
WHERE Age >=30 or Gender = 'Male';
SELECT *
FROM employeedemographics
WHERE FirstName like '%A';
 
SELECT *
FROM employeedemographics
WHERE FirstName like 'A%';
SELECT *
FROM employeedemographics
WHERE FirstName like '%A%';
SELECT *
FROM employeedemographics
WHERE FirstName like 'A%b%d%';
SELECT *
FROM employeedemographics
WHERE FirstName IS NULL;
SELECT *
FROM employeedemographics
WHERE FirstName IS NOt NULL;
SELECT *
FROM employeedemographics
WHERE FirstName IN('Abdullah' , 'John', 'Jane');
/* GROUP BY, ORDER BY*/
SELECT Gender, Age, COUNT(Gender) AS Gender_Count
From employeedemographics
Where Age >30
GROUP BY Gender, Age
ORDER BY Gender DESC, Age DESC;
SELECT Gender, Age, COUNT(Gender) AS Gender_Count
From employeedemographics
WHERE Age > 30
Group by 1 , 2
ORDER BY 1 ASC, 2 DESC;
/* INNER JOIN,Full/Left/Right OUTER JOIN */
SELECT employeedemographics.FirstName, employeesalary.JobTitle, employeesalary.Salary 
From employeedemographics
join employeesalary
On employeedemographics.EmployeeID = employeesalary.EmployeeID;
SELECT employeedemographics.FirstName, employeesalary.JobTitle, employeesalary.Salary 
From employeedemographics
Left Join employeesalary
On employeedemographics.EmployeeID = employeesalary.EmployeeID;
SELECT *
From employeedemographics
Left Join employeesalary
On employeedemographics.EmployeeID = employeesalary.EmployeeID;
SELECT *
From employeedemographics
Right Join employeesalary
On employeedemographics.EmployeeID = employeesalary.EmployeeID;
SELECT employeedemographics.FirstName, employeesalary.JobTitle, employeesalary.Salary  
FROM employeedemographics 
LEFT JOIN employeesalary ON employeedemographics.EmployeeID = employeesalary.EmployeeID
UNION
SELECT employeedemographics.FirstName, employeesalary.JobTitle, employeesalary.Salary  
FROM employeedemographics 
RIGHT JOIN employeesalary ON employeedemographics.EmployeeID = employeesalary.EmployeeID;
SELECT employeedemographics.FirstName, JobTitle, Avg(Salary)
From employeedemographics
join employeesalary
ON employeedemographics.EmployeeID = employeesalary.EmployeeID
WHERE JobTitle <> 'Manager'
group by employeedemographics.FirstName, JobTitle, Salary
order by avg(Salary) desc ;
/* UNION, UNION ALL (Union means combine the table whether 
it is duplicate and Union All means combine the table even duplicate entity. 
no. of columns should be same */
select EmployeeID, FirstName
From employeedemographics
UNION 
select EmployeeID, Salary
From employeesalary
group by EmployeeID, Salary;
select EmployeeID, FirstName
From employeedemographics
UNION All
select EmployeeID, Salary
From employeesalary
group by EmployeeID, Salary;
/* Case Statement*/
SELECT 
    FirstName, LastName, JobTitle, Salary,
    CASE 
        WHEN JobTitle = 'Manager' THEN Salary + (Salary * 0.10)
        ELSE Salary + (Salary * 0.5)
    END AS Increament
FROM 
    employeedemographics
JOIN 
    employeesalary ON employeedemographics.EmployeeID = employeesalary.EmployeeID;
SELECT 
    FirstName, LastName, Age,
    CASE 
		When Age = 38 then 'Stanley'
        WHEN Age > 30 then 'Old'
        Else 'Young'
    END As Category
FROM 
    employeedemographics
JOIN 
    employeesalary ON employeedemographics.EmployeeID = employeesalary.EmployeeID;
/*Having clause*/
Select JobTitle, count(Jobtitle)
From employeesalary
group by JobTitle
Having count(JobTitle) = 1;
Select JobTitle, Avg(Salary)
From employeesalary
group by JobTitle
Having Avg(Salary) > 1000
order by Avg(Salary);

/*   Update/ Delete    */

Update employeesalary
SET JobTitle = 'Manager'
Where EmployeeID = 1011 and Salary = 1000;
Delete
From employeedemographics
Where EmployeeID = 1014;

/* Aliasing */

Select demo.FirstName, demo.LastName, sal.Salary
From employeedemographics demo
Join employeesalary sal
On demo.EmployeeID = sal.EmployeeID;

/* Partition by */

Select FirstName, LastName, JobTitle, Gender, count(Gender) over (Partition By Gender) as TotalGender
From employeedemographics demo
join employeesalary sal
On demo.EmployeeID = sal.EmployeeID;

/* CTEs (common table expression) (temporary table) */

With CTE_EMPLOYEE as 
( Select FirstName, LastName, JobTitle, 
Gender, count(Gender) over (Partition By Gender) as TotalGender,
Salary, Avg(Salary) over ( Partition By Gender) as AvgSalary
From employeedemographics demo
join employeesalary sal
On demo.EmployeeID = sal.EmployeeID
WHERE SALARY > 1500
)
 select *
From CTE_EMPLOYEE;
SELECT *
From CTE_EMPLOYEE;

/* Temp table (temporary table just like cte but only 
difference we can use multiple times temp table, but CTE can only use one time) */

CREATE TEMPORARY TABLE temp_Employee (
    EmployeeID INT,
    JobTitle VARCHAR(100),
    Salary INT
);
INSERT temp_Employee values
('1001', 'Manager', '2500');
SELECT *
From temp_Employee;





