SELECT 
    *
FROM
    season_champs_motogp;

CREATE TABLE stg_season_champs_motogp LIKE season_champs_motogp;

SELECT 
    *
FROM
    stg_season_champs_motogp;

Alter table stg_season_champs_motogp
drop column `MyUnknownColumn_[0]`;


insert into stg_season_champs_motogp
select * from season_champs_motogp;

SELECT 
    *
FROM
    stg_season_champs_motogp
WHERE
    constructor LIKE '%/%';



SELECT 
    *,
    CASE
        WHEN `year` = '2007' THEN 'Ducati'
        ELSE 'Honda'
    END AS CPP
FROM
    stg_season_champs_motogp
WHERE
    rider = 'Casey Stoner';

UPDATE stg_season_champs_motogp 
SET 
    constructor = CASE
        WHEN `year` = '2007' THEN 'Ducati'
        ELSE 'Honda'
    END
WHERE
    rider = 'Casey Stoner';

SELECT 
    *
FROM
    stg_season_champs_motogp;

Alter table stg_season_champs_motogp
change column MyUnknownColumn Rider_Country text;



alter table stg_season_champs_motog;

Alter table stg_season_champs_motogp
change column MyUnknownColumn emp text;

DESCRIBE stg_season_champs_motogp;

SELECT 
    `MyUnknownColumn_[0]`
FROM
    stg_season_champs_motogp;

Alter table stg_season_champs_motogp
drop column `MyUnknownColumn_[0]`;

SELECT 
    *
FROM
    stg_season_champs_motogp;

SELECT 
    Rider_country, TRIM(SUBSTRING_INDEX(Rider_country, ' ', 1))
FROM
    stg_season_champs_motogp
WHERE
    TRIM(SUBSTRING_INDEX(Rider_country, ' ', 1)) = TRIM(SUBSTRING_INDEX(Rider_country, ' ', - 1));
 
UPDATE stg_season_champs_motogp 
SET 
    Rider_country = TRIM(SUBSTRING_INDEX(Rider_country, ' ', - 1))
WHERE
    TRIM(SUBSTRING_INDEX(Rider_country, ' ', 1)) = TRIM(SUBSTRING_INDEX(Rider_country, ' ', - 1));
 
UPDATE stg_season_champs_motogp 
SET 
    Rider_country = TRIM(SUBSTRING_INDEX(Rider_country, ' ', - 1))
WHERE
    TRIM(SUBSTRING_INDEX(Rider_country, ' ', 1)) = TRIM(SUBSTRING_INDEX(Rider_country, ' ', - 1));
 
SELECT DISTINCT
    (Rider)
FROM
    stg_season_champs_motogp;
 
SELECT 
    *
FROM
    stg_season_champs_motogp
ORDER BY 1;
 
SELECT 
    rider_country, constructor
FROM
    stg_season_champs_motogp
ORDER BY constructor;


rename table `constructure-world-championship` to constructure_world_championship;

rename table `grand-prix-race-winners` to gp_race_winners;

rename table `riders-finishing-positions` to gp_results;

SELECT 
    *
FROM
    constructure_world_championship;

rename table constructure_world_championship to constructor_champs;

SELECT 
    *
FROM
    constructor_champs;

CREATE TABLE stg_constructor_champs LIKE constructor_champs;

SELECT 
    *
FROM
    stg_constructor_champs;

insert into stg_constructor_champs
select * from constructor_champs;

SELECT 
    *
FROM
    stg_constructor_champs;

SELECT 
    class
FROM
    stg_constructor_champs;

UPDATE stg_constructor_champs 
SET 
    class = 'MotoGP'
WHERE
    class LIKE 'MotoGP%';



 SET SQL_SAFE_UPDATES = 0;
 
UPDATE stg_constructor_champs 
SET 
    class = 'Moto2'
WHERE
    class LIKE 'Moto2%';

UPDATE stg_constructor_champs 
SET 
    class = 'MotoE'
WHERE
    class LIKE 'MotoE%';

SELECT 
    *
FROM
    stg_constructor_champs
WHERE
    class LIKE '80%';

SELECT 
    *
FROM
    gp_evnt_held;

CREATE TABLE stg_gp_evnt_held LIKE gp_evnt_held;
insert into stg_gp_evnt_held
select * from gp_evnt_held;

SELECT DISTINCT
    track
FROM
    stg_gp_evnt_held;

CREATE TABLE stg_gp_race_winners LIKE gp_race_winners;
insert into stg_gp_race_winners
select * from gp_race_winners;

SELECT 
    *
FROM
    stg_gp_race_winners;

UPDATE stg_gp_race_winners 
SET 
    class = 'MotoE'
WHERE
    class LIKE 'MotoE%';

SELECT 
    *
FROM
    gp_results;
CREATE TABLE stg_gp_results LIKE gp_results;

insert into stg_gp_results
select * from gp_results;

SELECT 
    *
FROM
    stg_gp_results;

CREATE TABLE stg_rider_info LIKE rider_info;

insert into stg_rider_info
select * from rider_info;

SELECT 
    *
FROM
    stg_rider_info;

SELECT 
    Riders, Pole, World_Championships
FROM
    rider_info
WHERE
    Pole = '';

SELECT 
    Riders, Pole, World_Championships
FROM
    stg_rider_info
WHERE
    Pole IS NULL;



UPDATE stg_rider_info 
SET 
    Pole = NULL
WHERE
    pole = '';

drop table stg_riders_info;

SELECT 
    circuit, COUNT(Circuit) AS total_circuit
FROM
    stg_gp_race_winners
GROUP BY circuit
ORDER BY total_circuit DESC;

drop table stg_gp_results;

rename table stg2_gp_results to stg_gp_results;


SELECT 
    *
FROM
    stg_rider_info 
UNION ALL SELECT 
    *
FROM
    stg_gp_results
LIMIT 5;

SELECT 
    *
FROM
    stg_season_champs_motogp
WHERE
    Constructor LIKE '%/%';



SELECT 
    *,
    CASE
        WHEN `year` = '1989' THEN 'Honda'
        ELSE 'Yamaha'
    END AS CPP
FROM
    stg_season_champs_motogp
WHERE
    rider = 'Eddie Lawson';

UPDATE stg_season_champs_motogp 
SET 
    constructor = CASE
        WHEN `year` = '1989' THEN 'Honda'
        ELSE 'Yamaha'
    END
WHERE
    rider = 'Eddie Lawson';



SELECT 
    res.Rider
FROM
    stg_gp_results res
        JOIN
    stg_rider_info rd ON rd.Victories = res.Victories;

 
SELECT 
    COUNT(rider), COUNT(DISTINCT (rider))
FROM
    stg_gp_results;

SELECT 
    *
FROM
    stg_gp_results;

with cte_1 as 
(select *, row_number() over(partition by rider) as pt from stg_gp_results)
select * from cte_1 where pt >1;

SELECT 
    *
FROM
    stg_gp_results
WHERE
    rider = 'Edmund Czihak';

CREATE TABLE `stg2_gp_results` (
    `Rider` TEXT,
    `Victories` INT DEFAULT NULL,
    `NumberofSecond` INT DEFAULT NULL,
    `NumberofThird` INT DEFAULT NULL,
    `Numberof4th` INT DEFAULT NULL,
    `Numberof5th` INT DEFAULT NULL,
    `Numberof6th` INT DEFAULT NULL,
    `Country` TEXT,
    `rnum` INT
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;

insert into stg2_gp_results (
select *, row_number() over(partition by rider) as pt from stg_gp_results);

SELECT 
    *
FROM
    stg2_gp_results
WHERE
    rnum > 1;

DELETE FROM stg2_gp_results 
WHERE
    rnum > 1;

SELECT 
    *
FROM
    stg2_gp_results;

alter table stg2_gp_results
drop column rnum;

SELECT 
    *
FROM
    stg_rider_info;

SELECT 
    COUNT(DISTINCT (Riders))
FROM
    stg_rider_info;

with res as 
(select * from stg2_gp_results),
rd as (select * from stg_rider_info)
select res.rider, rd.riders from res
join rd on res.victories = rd.victories
where substring_index(res.rider, ' ', 1) = substring_index(rd.Riders, ' ', -1);

SELECT 
    SUBSTRING_INDEX(Rider, ' ', 1),
    rider,
    SUBSTRING_INDEX(Rider, ' ', - 1)
FROM
    stg2_gp_results;
commit;

SELECT 
    Riders, SUBSTRING_INDEX(Riders, ' ', - 1)
FROM
    rider_info;

SELECT 
    LOWER(SUBSTRING_INDEX(Riders, ' ', 1))
FROM
    rider_info;


UPDATE rider_info 
SET 
    Riders = LOWER(SUBSTRING_INDEX(Riders, ' ', 1));

SELECT 
    *
FROM
    rider_info;
rollback;

SELECT 
    *
FROM
    stg_rider_info;

SELECT 
    CONCAT(SUBSTRING_INDEX(Riders, ' ', - 1),
            ' ',
            LOWER(SUBSTRING_INDEX(Riders, ' ', 1)))
FROM
    stg_rider_info;
 
SELECT 
    LOWER(TRIM(SUBSTRING_INDEX(Riders, ' ', 1)))
FROM
    stg_rider_info;
 
UPDATE stg_rider_info 
SET 
    Riders = CONCAT(SUBSTRING_INDEX(Riders, ' ', - 1),
            ' ',
            LOWER(SUBSTRING_INDEX(Riders, ' ', 1)));

SELECT 
    UPPER(RIGHT(Riders, 9)), riders
FROM
    stg_rider_info;

SELECT 
    CONCAT(SUBSTRING_INDEX(riders, ' ', 1),
            ' ',
            UPPER(SUBSTRING(riders,
                        LOCATE(' ', riders) + 1,
                        1)),
            LOWER(SUBSTRING(riders,
                        LOCATE(' ', riders) + 2))) AS formatted_name
FROM
    stg_rider_info;

UPDATE stg_rider_info 
SET 
    Riders = CONCAT(SUBSTRING_INDEX(riders, ' ', 1),
            ' ',
            UPPER(SUBSTRING(riders,
                        LOCATE(' ', riders) + 1,
                        1)),
            LOWER(SUBSTRING(riders,
                        LOCATE(' ', riders) + 2)));

SELECT 
    *
FROM
    stg_rider_info;

alter table stg_rider_info
rename column `second` to `second_place`;

SELECT 
    *
FROM
    stg_gp_results;

set sql_safe_updates = 0;

SELECT 
    gp.rider,
    gp.Victories,
    gp.NumberofSecond,
    gp.NumberofThird,
    fo.Victories,
    fo.second_place,
    fo.third
FROM
    stg_gp_results gp
        JOIN
    stg_rider_info fo ON gp.rider = fo.riders;

SELECT 
    MAX(season), MIN(season)
FROM
    stg_constructor_champs;

SELECT 
    MAX(season), MIN(season)
FROM
    stg_season_champs_motogp;

alter table stg_season_champs_motogp
rename column `Year` to Season;

SELECT 
    *
FROM
    stg_season_champs_motogp;

DELETE FROM stg_season_champs_motogp 
WHERE
    season = '2023';
 
alter table stg_rider_info modify  `pole` int;

with cte as (select rider, row_number() over(partition by rider) as rm from gp_results)
select cte.*, gp.* from cte 
join gp_results gp on cte.rider = gp.rider
where rm > 1 ;

SELECT 
    *
FROM
    stg_constructor_champs
WHERE
    Season = ' ' OR Constructor = ''
        OR class = '';

SELECT 
    *
FROM
    stg_gp_evnt_held;

SELECT 
    *
FROM
    stg_gp_race_winners
WHERE
    Circuit = '' OR Class = ''
        OR Constructor = ''
        OR Country = ''
        OR Rider = ''
        OR Season = '';

UPDATE stg_gp_race_winners s1 
SET 
    s1.country = (SELECT 
            s2.Country
        FROM
            stg_gp_results s2
        WHERE
            s1.rider = s2.Rider)
WHERE
    s1.country = '';

SELECT 
    *
FROM
    stg_gp_results;

SELECT 
    W.Rider, w.country, c.rider_country
FROM
    stg_gp_race_winners w
        JOIN
    stg_season_champs_motogp c ON w.Rider = c.Rider;
            
CREATE TABLE copy_stg_champions LIKE stg_season_champs_motogp;

SELECT 
    *
FROM
    copy_stg_champions;

UPDATE copy_stg_champions c 
SET 
    c.Rider_Country = (SELECT 
            w.Country
        FROM
            stg_gp_race_winners w
        WHERE
            c.Rider = w.Rider)
WHERE
    c.Rider_country IS NOT NULL;

insert into copy_stg_champions
select * from stg_season_champs_motogp;

SELECT 
    w.Country
FROM
    stg_gp_race_winners w
        JOIN
    stg_season_champs_motogp c ON w.Rider = c.Rider;

truncate copy_stg_champions;

Insert into copy_stg_champions(Rider_Country)
select Country from stg_gp_race_winners;
            
Insert into copy_stg_champions(Season, Rider, Constructor)
Select Season, Rider, Constructor from stg_season_champs_motogp;

SELECT DISTINCT
    Rider_Country
FROM
    stg_season_champs_motogp;

UPDATE copy_stg_champions 
SET 
    Rider_Country = CASE
        WHEN Rider_country = 'United Kingdom' THEN 'UK'
        WHEN Rider_country = 'Italy' THEN 'IT'
        WHEN Rider_country = 'Australia' THEN 'AU'
        WHEN Rider_country = 'Spain' THEN 'ES'
        WHEN Rider_country = 'France' THEN 'FR'
        ELSE Rider_country
    END;

SELECT DISTINCT
    Rider_Country
FROM
    copy_stg_champions;

SELECT 
    *
FROM
    stg_gp_race_winners
WHERE
    Rider LIKE 'Ray%';

UPDATE stg_gp_race_winners 
SET 
    Country = 'Rhodesia'
WHERE
    Rider = 'Ray Amm';


DROP table stg_season_champs_motogp;

RENAME TABLE copy_stg_champions to stg_season_champs_motogp;

alter table stg_rider_info
rename column Riders to Rider;

 
SELECT 
    *
FROM
    stg_constructor_champs;
SELECT 
    *
FROM
    stg_gp_race_winners;
SELECT 
    *
FROM
    stg_gp_results;
SELECT 
    *
FROM
    stg_rider_info;
SELECT 
    *
FROM
    stg_season_champs_motogp;



