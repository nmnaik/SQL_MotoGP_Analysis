/*	Question Set 1: Easy */
/* Q1: How many championships have been won by each country? */

SELECT 
    Rider_Country,
    COUNT(Rider) AS number_of_champions_by_country
FROM
    stg_season_champs_motogp
GROUP BY Rider_Country
ORDER BY 2 DESC;

/*Q2: How many championships has each of these top riders won?*/

SELECT 
    Rider, COUNT(Rider) AS Total_championships
FROM
    stg_season_champs_motogp
GROUP BY 1
ORDER BY 2 DESC;

/*Q3: How many championships have been won by riders, and which constructors did they ride for and their Country?*/

SELECT 
    Rider,  COUNT(Rider) AS championship_victories, Constructor, Rider_country
FROM
    stg_season_champs_motogp
GROUP BY Rider, Rider_Country , Constructor
ORDER BY 2 DESC;

/*Q4: Which circuits have hosted the most races? */

SELECT 
    Circuit, COUNT(circuit)
FROM
    stg_gp_race_winners
GROUP BY circuit
ORDER BY 2 DESC
LIMIT 1;

/*Q5: How many victories does each constructor have in each season? */

SELECT 
    constructor, COUNT(Constructor) AS total_victory, season
FROM
    stg_gp_race_winners
GROUP BY constructor , season
ORDER BY 3 ASC;

/*Q6: Total number of podium finishes for each riders*/

SELECT 
    SUM(victories + NumberofSecond + NumberofThird) AS total_podiums,
    rider,
    Country
FROM
    stg_gp_results
GROUP BY rider , country
ORDER BY 1 DESC;

/* Question set 2: Medium*/
/* Q1: Examine the relationship between pole positions and race wins for riders.*/
SELECT 
    inf.Rider, inf.pole, rs.Victories
FROM
    stg_rider_info inf
        JOIN
    stg_gp_results rs ON rs.Rider = inf.Rider;
    
/* Q2: What is the correlation between rider success and the constructors they rode for? */

SELECT 
    rw.rider,
    rw.constructor,
    COUNT(rs.Victories + rs.NumberofSecond + rs.NumberofThird) AS total_success
FROM
    stg_gp_race_winners rw
        JOIN
    stg_gp_results rs ON rw.rider = rs.Rider
GROUP BY rw.rider , rw.constructor
ORDER BY 3 DESC;

/*Q3:  How many titles did a Rider win overall compared to just in the top MotoGP class? */
    
SELECT 
    cgp.Rider,
    COUNT(cgp.Rider) AS MotoGP_championships,
    World_Championships AS Total_championships
FROM
    stg_season_champs_motogp cgp
        JOIN
    stg_rider_info rf ON cgp.Rider = rf.Rider
GROUP BY cgp.rider , World_Championships
ORDER BY 2 DESC, 3 DESC;


/* Question Set 3: Advanced */
/*Q1: How many total wins did the constructors won during their championship season? */

SELECT 
    COUNT(Constructor) as each_season_wins, Constructor as Constructor_Season_Champs, season
FROM
    stg_gp_race_winners
WHERE
    (constructor , season) IN (SELECT 
            Constructor, Season
        FROM
            stg_constructor_champs
        WHERE
            class = 'MotoGP') AND class = 'MotoGP'
GROUP BY Constructor , Season;

/*Q2: Who are the dominant rider and number of championship victories in each decades? */

WITH RiderCounts AS (
    SELECT 
        FLOOR(season / 10) * 10 AS decades, 
        rider, 
        COUNT(rider) AS Rider_dominance
    FROM 
        stg_season_champs_motogp
    GROUP BY 
        rider, decades
),
RankedRiders AS (
    SELECT 
        decades, 
        rider, 
        Rider_dominance,
        DENSE_RANK() OVER (PARTITION BY decades ORDER BY Rider_dominance DESC) AS rnk
    FROM 
        RiderCounts
)
SELECT 
    decades, 
    rider, 
    Rider_dominance
FROM 
    RankedRiders
WHERE 
    rnk = 1;

/* Q3: How different circuits affect race outcomes for top riders? */

/* Solution 1: Considering top 5 riders With more championship wins*/
WITH Top_Riders AS 
(SELECT 
    COUNT(season) AS total_wins, Rider
FROM
    stg_season_champs_motogp
GROUP BY rider
ORDER BY 1 DESC
LIMIT 5)
SELECT 
    rw.Circuit, tp.Rider, COUNT(tp.Rider) AS circuit_wins
FROM
    stg_gp_race_winners rw
        JOIN
    Top_Riders tp ON tp.Rider = rw.Rider
GROUP BY rw.Circuit , tp.rider;

/* Solution 2: Using a stored procedure to find the ciruit and rider outputs of our choice*/
Delimiter $$
CREATE PROCEDURE circuit_wins(IN p_circuit varchar(255), in p_rider varchar(255))
BEGIN
 SELECT 
    Circuit, Rider, COUNT(Rider) AS circuit_wins
FROM
    stg_gp_race_winners
    where Circuit = p_circuit and Rider = p_rider
GROUP BY Circuit , rider;
END $$
Delimiter ;

Call circuit_wins('TT Circuit Assen', 'Valentino Rossi');
Call circuit_wins('Sachsenring', 'Valentino Rossi');
Call circuit_wins('Sachsenring', 'Pedro Acosta');


/* Q4: Which riders have won the championship with more than one constructor? */
WITH ChampionRiders AS (
  SELECT
    Rider,
    Constructor,
    ROW_NUMBER() OVER (PARTITION BY Rider) AS RowNum
  FROM
    stg_season_champs_motogp
  GROUP BY
    Rider,
    Constructor
  ORDER BY
    Rider
)
SELECT
  c1.Rider,
  c1.Constructor
FROM
  ChampionRiders c1
JOIN
  ChampionRiders c2 ON c1.Rider = c2.Rider
WHERE
  c2.RowNum > 1;



 
    

