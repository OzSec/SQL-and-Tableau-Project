-- Data in this project downloaded from https://ourworldindata.org/covid-deaths and it belongs to 2020 and 2021 years.

-- Let's see the Covid Deaths data.
SELECT *
FROM PortfolioProject..CovidDeaths
Where continent is not null
order by 3,4;

-- Select the data that's going to be used.
SELECT Location, date, total_cases, new_cases, total_deaths, new_deaths, population
FROM PortfolioProject..CovidDeaths
order by 1,2;

-- Total Cases vs Total Deaths. Shows the likehood of dying if you contact with Covid-19 in Turkey.

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location like '%Turkey%'
order by 1,2;

-- Total Cases vs Population. Shows what percentage of population got Covid-19 in Turkey.

SELECT Location, date, Population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE location like '%Turkey%'
order by 1,2;

-- Countries with highest infection rate compared to the population.

SELECT Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
GROUP by Location, Population
order by PercentPopulationInfected desc;

-- Showing countries with highest death count per population.

SELECT Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
Where continent is not null
GROUP by Location
order by TotalDeathCount desc;

-- Now for the visualization process I'm going to use the following data and import them into Tableau Public. Link to Tableau Dashboard is down below at the end.

-- 1. Global Numbers 

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null 
order by 1,2;

-- 2. Total Deaths Per Continent

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc;

-- 3. Percent Population Infected Per Country

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Group by Location, Population
order by PercentPopulationInfected desc;

-- 4. Percent Population Infected

Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc;

-- Link to Tableau Dashboard: https://public.tableau.com/app/profile/oz.sec/viz/Covid-19DashboardFrom20-21/Dashboard1