--SELECT * FROM PortfolioPorject..CovidDeaths
--where continent is not null
--ORDER BY 3,4

----SELECT * FROM PortfolioPorject..CovidDeaths
----ORDER BY 3,4-


---SELECT DATA TO BE USED
--SELECT location, date, total_cases, new_cases, total_deaths, population
--FROM PortfolioPorject..CovidDeaths
--order by 1,2

-- Total Cases Vs Total Deaths--
-- Likehood of dying if you catch covid
--SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
--FROM PortfolioPorject..CovidDeaths
--where location like '%states%'
--order by 1,2


--Total Cases Vs Population
-- % of population with covid
--SELECT location, date, total_cases, population, (total_cases/population) * 100 as PercentOfPopulationInfected
--FROM PortfolioPorject..CovidDeaths
--where location like '%Cana%'
--order by 1,2

---Infection rate by country
--SELECT location, MAx(total_cases) as HighestInfectionCount, population, MAX((total_cases/population)) * 100 as PercentOfPopulationInfected
--FROM PortfolioPorject..CovidDeaths
----where location like '%Cana%'
--Group by location, population
--order by PercentOfPopulationInfected desc


---Death count by country
--SELECT location, max(cast(total_deaths as int)) as TotalDeath
--FROM PortfolioPorject..CovidDeaths
----where location like '%Cana%'
--where continent is not null
--Group by location, population
--order by TotalDeath desc

----Death by Continent
--SELECT continent, max(cast(total_deaths as int)) as TotalDeath
--FROM PortfolioPorject..CovidDeaths
----where location like '%Cana%'
--where continent is not null
--Group by continent
--order by TotalDeath desc


--Global Numbers

----SELECT date, SUM(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
--FROM PortfolioPorject..CovidDeaths
--where continent is not null
--group by date
--order by 1,2


----Join Death and Vacinnation Tables
--Select *
--from PortfolioPorject..CovidDeaths dea
--Join PortfolioPorject..CovidVacination vac
--	on dea.location = vac.location
--	and dea.date = vac.date

----Total Population Vs Vaccination
--With PopVsVac (Continent, location, date, population, new_vaccination, RollingPeopleVaccinated) 
--as
--(
--Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
--SUM(cast(vac.new_vaccinations as int)) Over	 (partition by dea.location order by dea.location, dea.date)
--as RollingPeopleVaccinated
----, (RollingPeopleVaccinated/population)*100
--from PortfolioPorject..CovidDeaths dea
--Join PortfolioPorject..CovidVacination vac
--	on dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null
----order by 2,3
--)
--select * ,(RollingPeopleVaccinated/population)*100
--from PopVsVac

--Temp Table
--Drop table if exists #PercentPopulationVacinnated
--Create Table #PercentPopulationVacinnated
--(
--Continent nvarchar (255),
--Location nvarchar (255),
--Date datetime,
--Population numeric,
--New_vaccinations numeric,
--RollingPeopleVaccinated numeric
--)
--insert into #PercentPopulationVacinnated
--Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
--SUM(cast(vac.new_vaccinations as int)) Over	 (partition by dea.location order by dea.location, dea.date)
--as RollingPeopleVaccinated
----, (RollingPeopleVaccinated/population)*100
--from PortfolioPorject..CovidDeaths dea
--Join PortfolioPorject..CovidVacination vac
--	on dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null
----order by 2,3
--select * ,(RollingPeopleVaccinated/population)*100
--from #PErcentPopulationVacinnated

--creating view to store data


select * from 
PErcentPopulationVacinnated