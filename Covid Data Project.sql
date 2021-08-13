--Alter Column data types for aggregation

ALTER TABLE dbo.Covid_Deaths
ALTER COLUMN total_cases numeric;

Select * 
from [Portfolio Project]..Covid_Deaths
where continent is not NULL
order by 3,4;

--Data that I use

Select location, date, population,total_cases,total_deaths
from [Portfolio Project]..Covid_Deaths
where continent is not NULL
order by 1,2;

--Looking at Total cases vs total deaths  (South Africa)

Select location, date,total_cases,total_deaths, (Total_deaths/Total_cases)*100 AS Death_Percetage
from [Portfolio Project]..Covid_Deaths
where continent is not NULL
where location like 'South Africa',
and continent is not NULL
order by 1,2;

--Looking at Total cases vs total deaths  (Africa)

Select location, date,total_cases,total_deaths, (Total_deaths/Total_cases)*100 AS Death_Percetage
from [Portfolio Project]..Covid_Deaths
where location like 'Africa'
and continent is not NULL


-- Looking at Total_cases vs Population

Select location, date,population,total_cases, (Total_cases/Population)*100 AS Population_Percetage
from [Portfolio Project]..Covid_Deaths
where continent is not NULL
order by 1,2;

-- Looking at Total_cases vs Population

Select location, date,population,total_cases, (Total_cases/Population)*100 AS Population_Percetage
from [Portfolio Project]..Covid_Deaths
where location like 'Africa'
order by 1,2;

-- Looking at Countries with highest infection rate compared to Population

Select location,population, MAX(total_cases) as Highest_infection_count, (MAX(total_cases)/Population)*100 AS Percent_infected
from [Portfolio Project]..Covid_Deaths
where continent is not NULL
group by location, population
order by Percent_infected desc

-- Showing the countries with highest death count per population

Select location,Max(total_deaths) AS Total_death_count
from [Portfolio Project]..Covid_Deaths
where continent is not NULL
group by location
order by Total_death_count desc


-- Showing the countries with highest death count per population (Africa)

Select location,Max(total_deaths) AS Total_death_count
from [Portfolio Project]..Covid_Deaths
where continent like 'Africa'
group by location
order by Total_death_count desc

-- Showing the countries with highest death count per population (Continent)

Select continent,Max(total_deaths) AS Total_death_count
from [Portfolio Project]..Covid_Deaths
where continent is not null
group by continent
order by Total_death_count desc

-- Global Numbers

ALTER TABLE dbo.Covid_Deaths
ALTER COLUMN new_cases numeric;

-- Total Worldwide cases per date

Select date, SUM(New_cases) AS New_cases_by_date
from [Portfolio Project]..Covid_Deaths
where continent is not null
Group by date
order by 1,2;

ALTER TABLE dbo.Covid_Deaths
ALTER COLUMN new_deaths numeric;

-- Total Worldwide new cases & new deaths by date

Select date, SUM(New_cases) AS Total_Cases,SUM(New_deaths) AS Total_deaths,
SUM(New_deaths)/SUM(New_cases)*100 as DeathPercentage
from [Portfolio Project]..Covid_Deaths
where continent is not null
group by date
order by 1,2;

-- Total Worldwide deaths by day (International)

Select SUM(New_cases) AS Total_Cases,SUM(New_deaths) AS Total_deaths,
SUM(New_deaths)/SUM(New_cases)*100 as DeathPercentage
from [Portfolio Project]..Covid_Deaths
where continent is not null
order by 1,2;

ALTER TABLE dbo.Covid_vaccination
ALTER COLUMN new_vaccinations numeric;

-- Total population vs total vaccination per day

Select dea.continent, dea.location, dea.date, dea. population, vac.new_vaccinations
, sum(vac.new_vaccinations) over (partition by dea.location order by dea.location,dea.date)
from [Portfolio Project]..Covid_Deaths dea
join [Portfolio Project]..Covid_Vaccination vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

--Use CTE

with POPvsVAC
as (Continent, Location, Date, Population,New_Vaccinations, RollingPeopleVaccination)

 Select dea.continent, dea.location, dea.date, dea. population, vac.new_vaccinations
, sum(vac.new_vaccinations) over (partition by dea.location order by dea.location,dea.date)
as RollingPeopleVaccination
from [Portfolio Project]..Covid_Deaths dea
join [Portfolio Project]..Covid_Vaccination vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null


select * 
from POPvsVAC;




 



 

 