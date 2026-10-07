-- Original analytical SQL source work.
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths$
ORDER BY 1,2

-- Total cases vs total deaths
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths$
ORDER BY 1,2

-- Total cases vs population
SELECT Location, date, total_cases, population, (total_cases/population) * 100 AS ContractedPercentage
FROM PortfolioProject..CovidDeaths$
ORDER BY 1,2

-- Highest infection rate compared with population
SELECT Location, population, MAX(total_cases) AS HighestInfectionCount, (MAX(total_cases)/population)*100 AS ContractedPercentage
FROM PortfolioProject..CovidDeaths$
GROUP BY location,population
ORDER BY ContractedPercentage DESC

-- Highest death count
SELECT Location, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC

-- Continent summary
SELECT continent, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- Global death percentages by date
SELECT date, SUM(new_cases) AS TotalCases, SUM(CAST(new_deaths AS int)) AS TotalDeaths,
       SUM(CAST(new_deaths AS int))/SUM(new_cases) * 100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2

-- Population vs vaccinations with rolling window
SELECT D.continent, D.location, D.date, D.population, V.new_vaccinations,
       SUM(CONVERT(bigint,V.new_vaccinations)) OVER (PARTITION BY D.location ORDER BY D.Location, D.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidVaccinations$ V
JOIN PortfolioProject..CovidDeaths$ D
  ON V.location = D.location AND V.date = D.date
WHERE D.continent IS NOT NULL
ORDER BY 2,3

-- CTE
WITH PopVsVac (Continent, location, date, population, new_vaccinations, RollingPeopleVaccinated) AS (
    SELECT D.continent, D.location, D.date, D.population, V.new_vaccinations,
           SUM(CONVERT(bigint,V.new_vaccinations)) OVER (PARTITION BY D.location ORDER BY D.Location, D.date) AS RollingPeopleVaccinated
    FROM PortfolioProject..CovidVaccinations$ V
    JOIN PortfolioProject..CovidDeaths$ D
      ON V.location = D.location AND V.date = D.date
    WHERE D.continent IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated/population) * 100
FROM PopVsVac

-- Temp table
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated (
    Continent nvarchar(255), Location nvarchar(255), Date datetime,
    Population numeric, New_Vaccinations numeric, RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT D.continent, D.location, D.date, D.population, V.new_vaccinations,
       SUM(CONVERT(bigint,V.new_vaccinations)) OVER (PARTITION BY D.location ORDER BY D.Location, D.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidVaccinations$ V
JOIN PortfolioProject..CovidDeaths$ D
  ON V.location = D.location AND V.date = D.date
WHERE D.continent IS NOT NULL

SELECT *, (RollingPeopleVaccinated/population) * 100
FROM #PercentPopulationVaccinated

-- Reusable view for later visualizations
CREATE VIEW PercentPopulationVaccinated AS
SELECT D.continent, D.location, D.date, D.population, V.new_vaccinations,
       SUM(CONVERT(bigint,V.new_vaccinations)) OVER (PARTITION BY D.location ORDER BY D.Location, D.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidVaccinations$ V
JOIN PortfolioProject..CovidDeaths$ D
  ON V.location = D.location AND V.date = D.date
WHERE D.continent IS NOT NULL
