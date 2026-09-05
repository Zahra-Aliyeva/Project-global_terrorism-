CREATE TABLE terrorism ( 
    eventid BIGINT,
    iyear INT,
    imonth INT,
    iday INT,
    extended INT,
    country INT,
    country_txt TEXT,
    region INT,
    region_txt TEXT,
    provstate TEXT,
    city TEXT,
    latitude FLOAT,
    longitude FLOAT,
    specificity FLOAT,
    vicinity INT,
    crit1 INT,
    crit2 INT,
    crit3 INT,
    doubtterr FLOAT,
    multiple FLOAT,
    success INT,
    suicide INT,
    attacktype1 INT,
    attacktype1_txt TEXT,
    targtype1 INT,
    targtype1_txt TEXT,
    targsubtype1_txt TEXT,
    corp1 TEXT,
    target1 TEXT,
    natlty1_txt TEXT,
    gname TEXT,
    guncertain1 FLOAT,
    individual INT,
    claimed FLOAT,
    weaptype1 INT,
    weaptype1_txt TEXT,
    weapsubtype1_txt TEXT,
    nkill FLOAT,
    nkillus FLOAT,
    nkillter FLOAT,
    nwound FLOAT,
    nwoundus FLOAT,
    nwoundte FLOAT,
    property INT,
    ishostkid FLOAT,
    dbsource TEXT
);

SELECT * FROM "public"."terrorism";


-----1 
--Historical Data Quality Check
--With this query, we see the number of records that have 0 in each column. It counts the records with 0 in every column. If there are many 0s, it is more appropriate --to create a date_quality column for analysis.


SELECT SUM(CASE WHEN iyear = 0 THEN 1 ELSE 0 END) AS iyear_zeros,
SUM(CASE WHEN imonth = 0 THEN 1 ELSE 0 END) AS imonth_zeros,
SUM(CASE WHEN iday = 0 THEN 1 ELSE 0 END) AS iday_zeros FROM "public"."terrorism";



-- A new column "date_quality" is added: (Instead of analyzing the date components separately, it is more appropriate to create a new column that represents the --accuracy of the date.)




ALTER TABLE terrorism
ADD COLUMN date_quality VARCHAR(20);

UPDATE terrorism
SET date_quality = 
CASE
WHEN imonth = 0 AND iday = 0 THEN 'Year only' 
WHEN iday = 0 THEN 'Year month'
ELSE 'Full date'
END;

SELECT * FROM "public"."terrorism";



---2
-- Number of events in each category in the "date_quality" column
-- Distribution of Date Quality: How many events are there in each category?



SELECT date_quality, COUNT(*) AS total_events FROM terrorism
GROUP BY date_quality
ORDER BY 
CASE 
WHEN date_quality = 'Year only' THEN 1
WHEN date_quality = 'Year month' THEN 2
WHEN date_quality = 'Full date' THEN 3
END;


---3 
-- Are there any records with negative injured or deceased values?


SELECT count(*) FROM "public"."terrorism"
WHERE nkill < 0 OR nwound < 0;




--Severity Level 
---4



ALTER TABLE terrorism
ADD COLUMN severity_level VARCHAR(20);

UPDATE terrorism
SET severity_level =
CASE
WHEN nkill = 0 THEN 'No fatalities'
WHEN nkill BETWEEN 1 AND 5 THEN 'Low'
WHEN nkill BETWEEN 6 AND 20 THEN 'Medium'
ELSE 'High'
END;


SELECT * FROM "public"."terrorism";





--5
--Number of incidents without coordinates.




SELECT COUNT(*)
FROM terrorism
WHERE latitude IS NULL OR longitude IS NULL;


-- 6
-- Group the data in the terrorism table by country and calculate overall statistics for each country.
-- The purpose of this step is to determine the distribution of terrorist incidents by country and the death/injury statistics.


CREATE OR REPLACE VIEW country_summary AS
SELECT country_txt, COUNT(*) AS total_attacks, SUM(nkill) AS total_killed, SUM(nwound) AS total_wounded
FROM terrorism
GROUP BY country_txt;

SELECT * FROM country_summary
ORDER BY total_attacks DESC;



-- 
-- 7
-- What is the growth/percentage change of attacks by year? Determine whether the number of attacks increased or decreased compared to the previous year.
-- This column shows how the number of attacks has changed over time.
-- Positive → increase compared to the previous year
-- Negative → decrease compared to the previous year




SELECT iyear, COUNT(*) AS total_attacks,
COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY iyear) AS yearly_change FROM terrorism
GROUP BY iyear
ORDER BY iyear;




-- Which types of weapons are more destructive and deadly in terrorist incidents.
-- 8
-- The most dangerous weapon types (by severity).


SELECT weaptype1_txt,severity_level,
COUNT(*) AS incidents FROM terrorism
GROUP BY weaptype1_txt, severity_level
ORDER BY incidents DESC;


-- The purpose of this query is to determine which groups have a higher success rate in their attacks.
-- 9
-- Groups’ “success rate”


SELECT gname,
COUNT(*) AS total_attacks,
SUM(success) AS successful_attacks,
ROUND(100.0 * SUM(success) / COUNT(*), 2) AS success_rate FROM terrorism
WHERE gname <> 'Unknown'
GROUP BY gname
HAVING COUNT(*) > 20
ORDER BY success_rate DESC;




-- 10
-- In which countries are incidents without coordinates most common?


SELECT country_txt,
COUNT(*) AS missing_location_events
FROM terrorism
WHERE latitude IS NULL OR longitude IS NULL
GROUP BY country_txt
ORDER BY missing_location_events DESC;



-- 11
-- Risk Score: Risk score based on the number of deaths and injuries.


SELECT eventid, country_txt, nkill, nwound, severity_level,
(nkill * 2 + nwound) AS risk_score FROM terrorism
ORDER BY risk_score DESC
LIMIT 10;



--12
-- Seasonal Distribution: In which month of each year did the most attacks occur?



SELECT iyear, imonth, COUNT(*) AS monthly_attacks 
FROM terrorism
WHERE imonth > 0
GROUP BY iyear, imonth
ORDER BY iyear, imonth;




--13
-- Target Analysis → Which targets have been attacked the most?


SELECT targtype1_txt, COUNT(*) AS attacks_count, SUM(nkill) AS total_killed
FROM terrorism
GROUP BY targtype1_txt
ORDER BY attacks_count DESC;




--14
-- Weapon and Target Type Relationship: Which target types are most commonly attacked with each weapon type?



SELECT weaptype1_txt, targtype1_txt, COUNT(*) AS incidents
FROM terrorism
GROUP BY weaptype1_txt, targtype1_txt
ORDER BY incidents DESC
LIMIT 20;




--15
-- Countries where US citizens suffered the most harm.


SELECT country_txt,
SUM(nkillus) AS us_killed,
SUM(nwoundus) AS us_wounded,
SUM(nkillus + nwoundus) AS total_us_victims FROM terrorism
GROUP BY country_txt
HAVING SUM(nkillus + nwoundus) > 0
ORDER BY total_us_victims DESC
LIMIT 10;





--16 
-- In which countries are terrorist groups more active?
-- Activity of groups by country.


SELECT gname, country_txt, COUNT(*) AS total_attacks
FROM terrorism
WHERE gname <> 'Unknown'
GROUP BY gname, country_txt
ORDER BY total_attacks DESC
LIMIT 10;



--17
-- In which country did the deadliest terrorist incident occur each year?
-- (The incident with the highest number of deaths per year.)



SELECT iyear, country_txt, city, nkill
FROM ( SELECT iyear, country_txt, city, nkill,
RANK() OVER (PARTITION BY iyear ORDER BY nkill DESC) AS rank_per_year FROM terrorism
WHERE city <> 'Unknown') ranked_terrorism
WHERE rank_per_year = 1
ORDER BY iyear;




--18 
-- What is the severity of incidents without lat/long? Are incidents without coordinates more severe or not?
-- Severity of incidents without coordinates.


SELECT 
CASE 
WHEN latitude IS NULL OR longitude IS NULL THEN 'Missing location' 
ELSE 'Has location' 
END AS location_status,
AVG(nkill) AS avg_killed,
AVG(nwound) AS avg_wounded,
COUNT(*) AS total_events
FROM terrorism
GROUP BY location_status;


-- 19 
-- Types of attacks in which terrorists themselves were killed.


SELECT attacktype1_txt,
SUM(nkillter) AS terrorists_killed
FROM terrorism
WHERE attacktype1_txt <> 'Unknown'
GROUP BY attacktype1_txt
ORDER BY terrorists_killed DESC;



--20
-- How do suspicious terrorist incidents (doubtterr) differ from confirmed/real terrorist incidents?

SELECT 
CASE 
WHEN doubtterr = 1 THEN 'Doubtful'
ELSE 'Confirmed'
END AS terror_status,
AVG(nkill) AS avg_killed,
AVG(nwound) AS avg_wounded,
COUNT(*) AS total_events FROM terrorism
GROUP BY terror_status;



SELECT * FROM "public"."terrorism"
