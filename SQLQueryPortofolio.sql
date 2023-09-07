
-- Simple Data Queries
SELECT Location, date, total_cases,new_cases,total_deaths,population
from Deaths
order by 1,2

SELECT *
from Deaths
where continent is not null

SELECT top 3*
from Deaths
where continent is not null
--Total Cases vs Total Deaths
SELECT Location, date, total_cases,new_cases,total_deaths,(cast(total_deaths as numeric)/cast(total_cases as numeric))*100 as DeathPercentageOverCases,
(cast(total_deaths as numeric)/population)*100 as DeathPercentageOverPopulation
from Deaths
order by 1,2

--Highest InfectionRate

SELECT Location,Population,  max(total_cases) as BighestInfectionCount, max(cast(total_cases as numeric)/population)*100 as PopulationInfectedPercent
from Deaths
group by Location,Population
order by 4 desc


SELECT Location,Population,  max(total_cases) as BighestInfectionCount, max(cast(total_cases as numeric)/population)*100 as PopulationInfectedPercent
from Deaths
group by Location,Population
Having Location like 'rom%'
order by 4 desc


--Countries with most deaths by population

SELECT Location,Population,  max(cast(total_deaths as numeric)) as TotalDeathCount
from Deaths
where continent is not null
group by Location,Population
order by TotalDeathCount desc

-- Delete unwanted countries
Select  * from Deaths
where continent is  null


Delete from Deaths
where continent is  null

-- Break down by continent
--Total Death by continent

SELECT continent, max(cast(total_deaths as numeric)) as TotalDeathCount , Population
from Deaths
where continent is not null
group by continent,Population
order by continent, TotalDeathCount desc

SELECT continent,date, max(cast(total_deaths as numeric)) as TotalDeathCount , sum(Population) over (partition by continent, date) as TotalPopulation
from Deaths
where continent is not null  and Population is not null
group by continent,Population,date
order by continent,TotalDeathCount desc

--GLOBAL NUMBERS

Select date, sum(new_cases) as AllCases, sum(new_deaths) as AllDeaths , sum(new_deaths)/sum(new_cases) as 'Death/Cases'
from Deaths
where continent is not null
group by date
having sum(new_cases)>0 and sum(new_deaths)>0
order by 1,2

--Total Population vs Vactinations
--USE CTE
WITH PopvsVAC(continent,location,date,population,new_vaccinations,RollingPeopleVaccinated)
as(
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as numeric)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from Deaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null and vac.new_vaccinations is not null
--order by 2,3
)
select * , (RollingPeopleVaccinated/population)*100 as PopVsVaccination
from PopvsVAC

--USE TEMP TABLE

CREATE TABLE #PopvsVAC_Temp
(Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric)

INSERT INTO #PopvsVAC_Temp
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as numeric)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from Deaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null and vac.new_vaccinations is not null


select * , (RollingPeopleVaccinated/population)*100 as PopVsVaccination
from #PopvsVAC_Temp

--Creating View to store data for later visualizations

Create View PopvsVAC as 
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as numeric)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from Deaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null and vac.new_vaccinations is not null


Select * from PopvsVAC