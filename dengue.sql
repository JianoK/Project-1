USE PortfolioProject

select *
from PortfolioProject..[PH_dengue_cases2016-2020] as Deng


--Show the total cases & death for the Year 2019 -2020 with DeathPercentage


select Year, SUM(Dengue_Cases)TotalCases,SUM(Dengue_Deaths) TotalDeath,
(SUM(Dengue_Deaths)/SUM(Dengue_Cases))*100 as DeathPercentage
from PortfolioProject..[PH_dengue_cases2016-2020] as Deng
Group by Year


--Show the total cases & death for every Region with DeathPercentage


Select Region,SUM(Dengue_Cases)TotalCasesperRegion, 
SUM(Dengue_Deaths)TotalDeathperRegion,(SUM(Dengue_Deaths)/SUM(Dengue_Cases))*100 DP_Region
From [PH_dengue_cases2016-2020]
Group by Region
Order by TotalCasesperRegion


--Show the Average Dengue Cases & Death for the Year 2019 -2020 with DeathPercentage


Select (Year),AVG(Dengue_Cases)AVGCasesperYear, 
AVG(Dengue_Deaths)AVGDeathperYear
From [PH_dengue_cases2016-2020]
Group by Year


--Show the Average cases & death for every Region with DeathPercentage


Select (Year),AVG(Dengue_Cases)AVGCasesperYear, 
AVG(Dengue_Deaths)AVGDeathperYear
From [PH_dengue_cases2016-2020]
Group by Year


--Show the total cases & death for the 3 main island per Year


--Create a Distribution of all Regions to the 3 main island of the Philippines (Luzon, Visayas,Mindanao)


Alter table PortfolioProject..[PH_dengue_cases2016-2020]
Add RegionIsland nvarchar(100)


Update PortfolioProject..[PH_dengue_cases2016-2020]
Set RegionIsland =	Case
						When Region = 'BARMM' Then 'Mindanao'
						When Region = 'Region XIII ' Then 'Mindanao'
						When Region = 'Region XII ' Then 'Mindanao'
						When Region = 'Region XI ' Then 'Mindanao'
						When Region = 'Region X ' Then 'Mindanao'
						When Region = 'Region IX ' Then 'Mindanao'
						When Region = 'Region VIII' Then 'Visayas'
						When Region = 'Region VII' Then 'Visayas'
						When Region = 'Region VI' Then 'Visayas'
						Else 'Luzon'
						End;

Select *
From PortfolioProject..[PH_dengue_cases2016-2020]
						

-- Now we can See the TotalCases & Death for the 3 main island of the Philippines


Select RegionIsland,SUM (Dengue_Cases)TotalCasesperIsland,
SUM(Dengue_Deaths) TotalDeathperIsland,(SUM(Dengue_Deaths)/SUM(Dengue_Cases))*100 DP_Island
From [PH_dengue_cases2016-2020]
Group by RegionIsland


-- Now we can See the TotalCases & Death for the 3 main island of the Philippines


Select RegionIsland,AVG(Dengue_Cases)AVGCasesperIsland,
AVG(Dengue_Deaths) AVGDeathperIsland
From [PH_dengue_cases2016-2020]
Group by RegionIsland


--EXTRA 


--Random Ranking Query


--Find the top 10 Region,Month  and Year  where the Highest Dengue Cases was Listed 


Select Top 10 (Region),MAX(Dengue_Cases)MaxDengueCases,Month,YEAR,
Row_Number()over(Order by Dengue_Cases DESC) TopCasesRegion
From PortfolioProject..[PH_dengue_cases2016-2020]
Group by Region,Dengue_Cases,Month,YEAR
Order by Dengue_Cases DESC


--Find the top 10 Region,Month  and Year  where the Highest Death Count was Listed 


Select Top 10 (Region),MAX(Dengue_Deaths)MaxDeathCount,Month,YEAR,
Row_Number()over(Order by Dengue_Deaths DESC) TopDeathCasesRegion
From PortfolioProject..[PH_dengue_cases2016-2020]
Group by Region,Dengue_Deaths,Month,YEAR
Order by Dengue_Deaths DESC

