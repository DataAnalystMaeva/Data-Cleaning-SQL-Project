-- 1. REINITIALISATION
DROP TABLE IF EXISTS layoffs_staging;
DROP TABLE IF EXISTS layoffs_staging_2;

CREATE TABLE layoffs_staging LIKE layoffs;
INSERT INTO layoffs_staging SELECT * FROM layoffs;

-- 2. CRÉATION DE LA TABLE DE NETTOYAGE
CREATE TABLE `layoffs_staging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 3. INSERTION ET DÉDOUBLONNAGE
INSERT INTO layoffs_staging_2
SELECT *, ROW_NUMBER() OVER(
    PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
) as row_num
FROM layoffs_staging;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM layoffs_staging_2 
WHERE row_num > 1;

-- 4. NORMALISATION TEXTE
UPDATE layoffs_staging_2 
SET company = TRIM(company);

UPDATE layoffs_staging_2 
SET industry = 'Crypto' 
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging_2 
SET country = TRIM(TRAILING '.' FROM country) 
WHERE country LIKE 'United States%';

-- 5. RÉPARATION DES DATES (Format US %m/%d/%Y)
UPDATE layoffs_staging_2 
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging_2 MODIFY COLUMN `date` DATE;

-- 6. VÉRIFICATION FINALE
SELECT * FROM layoffs_staging_2;

select *
from layoffs_staging_2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging_2
where industry is null
or industry = '';

update layoffs_staging_2
set industry = null
where industry = '';

select *
from layoffs_staging_2
where company = 'Airbnb';

select *
from layoffs_staging_2 t1
join layoffs_staging_2 t2
	on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging_2 t1
join layoffs_staging_2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

-- données non fiables

delete
from layoffs_staging_2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging_2;

alter table layoffs_staging_2
drop column row_num;
