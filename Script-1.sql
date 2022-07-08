-- 1 Selezionare tutte le nazioni il cui nome inizia con la P e la cui  area è maggiore di 1000 km
select *
from `countries`
where `name` like 'P%' and `area`>1000;

-- 2 Selezionare le nazioni il cui national day è avvenuto più di  100 anni fa 
select *
from `countries`
where timestampdiff(year,national_day,curdate()) >100;

-- 3 Selezionare il nome delle regioni del continente europeo, in ordine alfabetico
select r.name
from `regions`r
inner join `continents`c
on r.continent_id =c.continent_id
where c.continent_id=4
order by r.name ;

-- 4  Contare quante lingue sono parlate in Italia
SELECT COUNT(l.language_id) as num_lingue
FROM `languages` l
INNER JOIN `country_languages` c_l
ON l.language_id = c_l.language_id 
INNER JOIN `countries` c
ON c.country_id = c_l.country_id 
WHERE c.name = 'Italy';

-- 5. Selezionare quali nazioni non hanno un national day 
select name as nazioni_senza_national_day
from countries c 
where national_day is NULL;

-- 6 Per ogni nazione selezionare il nome, la regione e il continente 
select c.name,r.name,con.name
from `countries`c
inner join `regions` r 
on c.region_id =r.region_id 
inner join `continents`con
on r.continent_id =con.continent_id ;

-- 7  Modificare la nazione Italy, inserendo come national day il 2 giugno 1946
update countries c 
set c.national_day ='1946-06-02' 
where c.name='Italy';

-- 8 . Per ogni regione mostrare il valore dell'area totale

select sum(c.area) as area_totale,r.name
from `regions` r
inner join `countries` c 
on r.region_id =c.region_id 
group by r.name;

-- 9  Selezionare le lingue ufficiali dell'Albania

SELECT c.name, l.`language` 
FROM `countries` c
INNER JOIN `country_languages` c_l
ON c.country_id = c_l.country_id 
INNER JOIN `languages` l 
ON l.language_id = c_l.language_id 
WHERE c.name LIKE 'Albania' AND c_l.official IS TRUE;

-- 10  Selezionare il Gross domestic product (GDP) medio dello  United Kingdom tra il 2000 e il 2010

select avg(cs.gdp) as media_gdp
from country_stats cs 
inner join countries c 
on c.country_id =cs.country_id 
where c.name like 'United Kingdom' and cs.`year` between 2000 and 2010;

-- 11  Selezionare tutte le nazioni in cui si parla hindi, ordinate  dalla più estesa alla meno estesa 
select c.name, l.`language` 
from countries c 
inner join country_languages cl 
on c.country_id =cl.country_id 
inner join languages l 
on cl.language_id =l.language_id 
where l.`language` like 'Hindi'
order by c.area desc ;

-- 12  Per ogni continente, selezionare il numero di nazioni con area superiore ai 10.000 kmq ordinando i risultati a partire dal continente che ne ha di più

select c.name,(c2.country_id) as nazioni_area_superiore_10000
from continents c 
inner join regions r 
on c.continent_id = r.continent_id 
inner join countries c2 
on c2.region_id =r.region_id 
where c2.area > 10000
group by c.name 
order by nazioni_area_superiore_10000 desc;
