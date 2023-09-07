--CREATE TABLE EmployeeDemographics
--(EmployeeID int,
--FirstName varchar(50),
--LastName varchar(50),
--Age int,
--Gender varchar(50))

--CREATE TABLE EmployeeSalary
--(EmployeeID int,
--JobTitle varchar(50),
--salary int)

--insert into EmployeeDemographics values(1001,'Jim','Halpert',30,'Male')
--Insert into EmployeeDemographics VALUES
--(1002, 'Pam', 'Beasley', 30, 'Female'),
--(1003, 'Dwight', 'Schrute', 29, 'Male'),
--(1004, 'Angela', 'Martin', 31, 'Female'),
--(1005, 'Toby', 'Flenderson', 32, 'Male'),
--(1006, 'Michael', 'Scott', 35, 'Male'),
--(1007, 'Meredith', 'Palmer', 32, 'Female'),
--(1008, 'Stanley', 'Hudson', 38, 'Male'),
--(1009, 'Kevin', 'Malone', 31, 'Male')

--Insert Into EmployeeSalary VALUES
--(1001, 'Salesman', 45000),
--(1002, 'Receptionist', 36000),
--(1003, 'Salesman', 63000),
--(1004, 'Accountant', 47000),
--(1005, 'HR', 50000),
--(1006, 'Regional Manager', 65000),
--(1007, 'Supplier Relations', 41000),
--(1008, 'Salesman', 48000),
--(1009, 'Accountant', 42000)

--Insert into EmployeeDemographics VALUES
--(1011, 'Ryan', 'Howard', 26, 'Male'),
--(NULL, 'Holly', 'Flax', NULL, NULL),
--(1013, 'Darryl', 'Philbin', NULL, 'Male')

--Create Table WareHouseEmployeeDemographics 
--(EmployeeID int, 
--FirstName varchar(50), 
--LastName varchar(50), 
--Age int, 
--Gender varchar(50)
--)
--Insert into WareHouseEmployeeDemographics VALUES
--(1013, 'Darryl', 'Philbin', NULL, 'Male'),
--(1050, 'Roy', 'Anderson', 31, 'Male'),
--(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
--(1052, 'Val', 'Johnson', 31, 'Female')
--SELECT * 
--FROM EmployeeDemographics d
--full outer join EmployeeSalary s
--on d.employeeid = s.employeeid

/*
SELECT * 
FROM EmployeeDemographics 
inner join EmployeeSalary 
on EmployeeDemographics.employeeid = EmployeeSalary.employeeid

SELECT * 
FROM EmployeeDemographics 
left outer join EmployeeSalary 
on EmployeeDemographics.employeeid = EmployeeSalary.employeeid*/


/*CREATE TABLE #temp_Employee (
EmployeeID int,
JobTitle varchar(100),
Salary int)*/




/*insert into #temp_Employee values(
1001 , 'HR' , 4500)

INSERT INTO #temp_Employee 
select * from EmployeeSalary*/

/*select * FROM  #temp_Employee

create table #temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

insert into #temp_Employee2
SELECT JobTitle, Count(JobTitle), Avg(Age), Avg(Salary)
from EmployeeDemographics demo
join EmployeeSalary sal
on demo.EmployeeID = sal.EmployeeID
group by JobTitle

select * from #temp_Employee2*/

/*CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')*/


-- Using Trim, LTRIM, RTRIM

/*SELECT EmployeeID, TRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors*/

-- Using Replace

/*Select LastName , Replace(LastName, '- Fired' , '') as LastNmaeFIxed
from EmployeeErrors*/

--Using Substring

/*Select SUBSTRING(FirstName , 1 , 3)
from EmployeeErrors*/

/*select err.FirstName , demo.FirstName
from EmployeeErrors err
join EmployeeDemographics demo
on Substring(err.FirstName,1,3) = substring(demo.FirstName,1,3)*/

--Using Upper and lower

/*Select FirstName , Lower(FirstName)
from EmployeeErrors

Select FirstName , Lower(Substring(FirstName,1,2) 
from EmployeeErrors*/
/*
CREATE PROCEDURE TEST
AS 
SELECT *
FROM EmployeeDemographics

EXEC TEST

CREATE PROCEDURE Temp_Employee
AS 
create table #temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

insert into #temp_Employee2
SELECT JobTitle, Count(JobTitle), Avg(Age), Avg(Salary)
from EmployeeDemographics demo
join EmployeeSalary sal
on demo.EmployeeID = sal.EmployeeID
group by JobTitle

Select * from #temp_Employee2

exec Temp_Employee @JobTitle = 'Salesman'*/


SELECT EmployeeID
FROM EmployeeSalary

--Subquery in select

select employeeid, salary, (Select AVG(Salary) from EmployeeSalary) AllAvgSalary
from EmployeeSalary

