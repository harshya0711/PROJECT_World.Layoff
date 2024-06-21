CREATE TABLE layoff_staging2 like layoffs;

select * from layoff_staging2;

INSERT layoff_staging2 SELECT * 
FROM layoffs;

select *FROM layoffs;

select * ,
ROW_NUMBER() OVER(
partition by company, location, industry, total_laid_off, percentage_laid_off,
 `date`, stage, country, funds_raised_millions) as Row_num
from layoff_staging;

with duplicate_cte as
(
select * ,
ROW_NUMBER() OVER(
partition by company, location, industry, total_laid_off, percentage_laid_off,
 `date`, stage, country, funds_raised_millions) as Row_num
from layoff_staging
)
select * from duplicate_cte 
where row_num > 1;


create TABLE `layoff_staging3`(
`company` text,
`loction` text,
`industry` text,
`total_laid_off` int DEFAULT NULL,
`percentage_laid_off` text,
`date` text,
`stage` text,
`country` text,
`funds_raised_millions` int DEFAULT NULL,
`row_num` INT 
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci; 

select * from layoff_staging3;

insert into layoff_staging3
select *,
ROW_NUMBER() OVER(
partition by company, location, industry, total_laid_off, percentage_laid_off,
 `date`, stage, country, funds_raised_millions) as Row_num
from layoff_staging;

select * from layoff_staging3
where row_num > 1
;

delete from layoff_staging3
where row_num > 1
;

select * from layoff_staging3
;

--- Standardizing Data 

select company, trim(company)
from layoff_staging3;

update layoff_staging3
set company = trim(company);

select distinct industry
from layoff_staging3;

update layoff_staging3
set industry = 'crypto'
where industry like 'crypto%';

select distinct country, trim(trailing '.' from country)
from layoff_staging3
order by 1;

update layoff_staging3
set country = trim(trailing '.' from country)
where industry like 'United States%';

select `date` ,
str_to_date(`date`, '%m/%d/%Y')
from layoff_staging3 ;

update layoff_staging3
set `date` = str_to_date(`date`, '%m/%d/%Y');

ALTER TABLE layoff_staging3
MODIFY COLUMN `date` dATE;

select * from layoff_staging3 
WHERE total_laid_off is null 
and percentage_laid_off is null;

select * from layoff_staging3 
WHERE industry is null or industry = '';

delete from layoff_staging3 
WHERE total_laid_off is null 
and percentage_laid_off is null;

select * from layoff_staging3;

ALTER TABLE layoff_staging3
drop column row_num;
