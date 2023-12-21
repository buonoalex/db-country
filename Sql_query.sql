use country_exam;

-- (1) Selezionare tutte le nazioni il cui nome inizia con la P e la cui area è maggiore di 1000 kmq
select * 
from countries as c
where c.name like 'p%' AND c.area > 1000;

-- (2)  Contare quante nazioni sono presenti nel database
select count(*)
from countries as c;

-- (3) Selezionare il nome delle regioni del continente europeo, in ordine alfabetico
select * 
from continents as c 
join regions as r 
on r.continent_id = c.continent_id
where c.name = 'Europe';

-- (4) Contare quante regioni sono presenti nel continente Africa
select count(*)
from continents as c 
join regions as r 
on r.continent_id = c.continent_id
where c.name = 'Africa';

-- (5) Selezionare quali nazioni non hanno un national day
select *
from countries
where national_day is null;

-- (6) Per ogni nazione, in ordine alfabetico, selezionare il nome, la regione e il continente
select c.name , r.name ,c2.name 
from countries as c
join regions as r
on r.region_id = c.region_id
join continents as c2 
on c2.continent_id = r.continent_id
group by c.country_id
order by c.name;

-- (7) Selezionare le lingue ufficiali dell’Albania
select l.language
from countries as c 
join country_languages as cl 
on cl.country_id = c.country_id 
join languages as l 
on l.language_id = cl.language_id
where c.name = 'Albania' and cl.official > 0;

-- (8) Selezionare il Gross domestic product (GDP) medio dello United Kingdom tra il 2000 e il 2010
select AVG(cs.gdp) as Val_medio 
from countries as c 
join country_stats as cs 
on cs.country_id = c.country_id AND c.name = 'United Kingdom'
where cs.year between 2000 AND 2010 ;

-- (9) Selezionare tutte le nazioni in cui si parla hindi, ordinate dalla più estesa alla meno estesa
select c.country_id,c.name,c.area
from languages as l 
join country_languages as cl 
on cl.language_id = l.language_id AND l.language = 'hindi'
join countries as c 
on c.country_id = cl.country_id
order by c.area desc;

-- (10) Modificare la nazione di nome Italy, inserendo come national day il 2 giugno 1946
UPDATE countries as c 
SET c.national_day = '1946-06-02'
where c.name = 'Italy';

-- BONUS (1)  Selezionare le nazioni il cui national day è avvenuto prima del 1900, ordinate per national day dal più recente al meno recente
select *
from countries as c 
where YEAR(national_day) < 1900 
order by c.national_day DESC;

-- BONUS (2) Contare quante lingue sono parlate in Italia
select count(*)
from countries as c 
join country_languages as cl 
on cl.country_id = c.country_id AND c.name = 'Italy'
join languages as l 
on l.language_id = cl.language_id;

-- BONUS (3) Per la regione Antarctica mostrare il valore dell’area totale e dell’area media delle nazioni
select SUM(c.area) , AVG(c.area) , r.name
from regions as r
join countries as c
where c.region_id = r.region_id AND r.name = 'Antarctica'
group by r.region_id;
