-- Exploratory Data Analysis

-- 1. Regarder les données globales pour comprendre l'étendue des licenciements

Select *
from layoffs_staging_2;

select MAX(total_laid_off), MAX(percentage_laid_off)
from layoffs_staging_2;

-- 2. Identifier les entreprises qui ont fermé complètement (100% de licenciements)
-- et les classer par volume et par fonds levés pour voir si la taille de l'entreprise
-- influence la probabilité de faillite.

Select *
from layoffs_staging_2
where percentage_laid_off = 1
order by total_laid_off DESC;


Select *
from layoffs_staging_2
where percentage_laid_off = 1
order by funds_raised_millions DESC;

Select company, SUM(total_laid_off)
from layoffs_staging_2
Group by company
Order by 2 DESC;

Select Min(`date`), MAX(`date`)
from layoffs_staging_2;

Select industry, SUM(total_laid_off)
from layoffs_staging_2
Group by industry
Order by 2 DESC;

Select country, SUM(total_laid_off)
from layoffs_staging_2
Group by country
Order by 2 DESC;

Select YEAR(`date`), SUM(total_laid_off)
from layoffs_staging_2
Group by YEAR(`date`)
Order by 1 DESC;

Select stage, SUM(total_laid_off)
from layoffs_staging_2
Group by stage
Order by 2 DESC;


select substring(`date`,1,7) as `month`, sum(total_laid_off)
from layoffs_staging_2
Where substring(`date`,1,7) is not null
Group by `month`
order by 1 ASC;

with rolling_total as (select substring(`date`,1,7) as `month`, sum(total_laid_off) as total_off
from layoffs_staging_2
Where substring(`date`,1,7) is not null
Group by `month`
order by 1 ASC)
select `month`, total_off,
sum(total_off) over(order by `month`) as Rolling_Total
from rolling_total;

Select company, SUM(total_laid_off)
from layoffs_staging_2
Group by company
Order by 2 DESC;

Select company, YEAR(`date`), SUM(total_laid_off)
from layoffs_staging_2
Group by company, YEAR(`date`)
Order by 3 DESC;

WITH company_Year (company, years, total_laid_off) AS
(Select company, YEAR(`date`), SUM(total_laid_off)
from layoffs_staging_2
Group by company, YEAR(`date`)
), Company_Year_Rank AS
(
Select *, dense_rank() Over(Partition by years order by total_laid_off DESC) AS Ranking
from company_Year
where years IS NOT NULL
Order by Ranking ASC
)
Select *
From Company_Year_Rank
where Ranking <= 5;