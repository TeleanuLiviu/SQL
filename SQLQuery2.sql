USE [SQLTUTORIAL]
GO
/****** Object:  StoredProcedure [dbo].[Temp_Employee]    Script Date: 8/6/2023 9:38:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Temp_Employee]
@JobTitle nvarchar(100)
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
where JobTitle = @JobTitle
group by JobTitle

Select * from #temp_Employee2