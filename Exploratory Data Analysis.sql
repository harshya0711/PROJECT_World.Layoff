 -- Exploratory Data Analysis --
 
 select * from layoff_staging3 ;
 
 select max( total_laid_off), max( percentage_laid_off )
    from layoff_staging3 ;
    
select * from layoff_staging3 
where percentage_laid_off = 1 
order by funds_raised_millions desc ;

select company, sum( total_laid_off )
 from layoff_staging3
 group by company
 order by 2 Desc ;
 
 select min(`date`), max(`date`)
 from layoff_staging3 ;
 
 select industry, sum( total_laid_off )
 from layoff_staging3
 group by industry
 order by 2 Desc ;
 
  select country, sum( total_laid_off )
 from layoff_staging3
 group by country
 order by 2 Desc ;
 
  select year(`date`), sum( total_laid_off )
 from layoff_staging3
 group by year(`date`)
 order by 2 Desc ;
 
  select substring( `date` , 1,7) as `month` , 
         sum( total_laid_off) 
         from layoff_staging3
 where substring( `date` , 1,7) is not null
 group by `month` 
 order by 1 asc ;
 
 select company, year(`date`),
        sum( total_laid_off) 
	from layoff_staging3 
group by company, year(`date`)
order by 3 desc ;

with company_year ( company, years, total_laid_off) as 
(
        select company, year(`date`),
        sum( total_laid_off) 
	from layoff_staging3 
group by company, year(`date`)
)
select * , dense_rank() over (partition by Years
     order by total_laid_off Desc) as dense_ranks
from company_year
where years is not null
order by dense_ranks asc ;
 
 
 
 
 
 
 