-- https://sqlzoo.net/wiki/SELECT_basics
SELECT population FROM world WHERE name = 'Germany'
SELECT name, population FROM world WHERE name IN ('Sweden','Norway', 'Denmark');
SELECT name, area FROM world WHERE area BETWEEN 200000 AND 250000


-- https://sqlzoo.net/wiki/SELECT_names
SELECT name FROM world WHERE name LIKE 'Y%'
SELECT name FROM world WHERE name LIKE '%y'
SELECT name FROM world WHERE name LIKE '%X%'
SELECT name FROM world WHERE name LIKE '%land'
SELECT name FROM world WHERE name LIKE 'C%ia'
SELECT name FROM world WHERE name LIKE '%oo%'
SELECT name FROM world WHERE name LIKE '%a%a%a%'
SELECT name FROM world WHERE name LIKE '_t%' ORDER BY name
SELECT name FROM world WHERE name LIKE '%o__o%'
SELECT name FROM world WHERE name LIKE '____'
SELECT name FROM world WHERE capital = Concat(name, ' City')
SELECT capital, name FROM world WHERE capital LIKE concat('%', name, '%')
SELECT name, mid(capital,LENGTH(name)+1) ext FROM world WHERE capital LIKE concat(name,'_%')


-- https://sqlzoo.net/wiki/SELECT_from_WORLD_Tutorial
SELECT name, continent, population FROM world
SELECT name FROM world WHERE population>200000000
SELECT name, gdp/population FROM world WHERE population > 200000000
SELECT name, population/1000000 FROM world WHERE continent = 'South America'
SELECT name, population FROM world WHERE name IN ('France', 'Germany', 'Italy')
SELECT name FROM world WHERE name LIKE '%United%'
SELECT name, population, area FROM world WHERE area > 3000000 OR population > 250000000
SELECT name, population, area FROM world WHERE area > 3000000 XOR population > 250000000
SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2) FROM world WHERE continent = 'South America'
SELECT name, ROUND(gdp/population,-3) FROM world WHERE gdp>1000000000000
SELECT name, capital FROM world WHERE LENGTH(name) = Length(capital)
SELECT name, capital FROM world WHERE LEFT(name,1) = LEFT(capital,1) AND name != capital
SELECT name FROM world WHERE name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%' AND name LIKE '%o%' AND name LIKE '%u%' AND name NOT LIKE '% %'


-- https://sqlzoo.net/wiki/SELECT_from_Nobel_Tutorial
SELECT yr, subject, winner FROM nobel WHERE yr = 1950
SELECT winner FROM nobel WHERE yr = 1962 AND subject = 'Literature'
SELECT yr, subject FROM nobel WHERE winner = 'Albert Einstein'
SELECT winner FROM nobel WHERE subject = 'Peace' AND yr >= 2000
SELECT * FROM nobel WHERE subject = 'Literature' AND yr >= 1980 AND yr <=1989
SELECT * FROM nobel WHERE  winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama')
SELECT winner FROM nobel WHERE winner LIKE 'John %'
SELECT * FROM nobel WHERE subject = 'Physics' AND yr = 1980 OR subject = 'Chemistry' AND yr = 1984
SELECT * FROM nobel WHERE yr=1980 AND subject NOT IN ('Chemistry','Medicine')
SELECT * FROM nobel WHERE (subject = 'Medicine' AND yr < 1910) OR (subject = 'Literature' AND yr >= 2004)
SELECT * FROM nobel WHERE winner = 'PETER GRÜNBERG'
SELECT * FROM nobel WHERE winner = 'EUGENE O\'NEILL''
SELECT winner, yr, subject FROM nobel WHERE winner LIKE 'Sir%' ORDER BY yr DESC, winner
SELECT winner, subject FROM nobel WHERE yr=1984 ORDER BY subject IN ('Physics', 'Chemistry'), subject, winner


-- https://sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial
SELECT name FROM world WHERE population > (SELECT population FROM world WHERE name='Russia')
SELECT name FROM world WHERE continent='Europe' AND gdp/population > (SELECT gdp/population FROM world WHERE name='United Kingdom')
SELECT name, continent FROM world WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia')) ORDER BY name
SELECT name, population FROM world WHERE population BETWEEN (SELECT population+1 FROM world WHERE name = 'Canada') AND (SELECT population-1 FROM world WHERE name = 'Poland')
SELECT name, CONCAT(ROUND((population/(SELECT population FROM world WHERE name='Germany'))*100), '%') FROM world WHERE continent = 'Europe'
SELECT name FROM world WHERE gdp > ALL (SELECT gdp FROM world WHERE continent = 'Europe' AND gdp IS NOT NULL)
SELECT continent, name, area FROM world i
  WHERE area >= ALL
    (SELECT area FROM world j
        WHERE j.continent=i.continent
          AND area>0)
SELECT continent,name FROM world i
  WHERE i.name <= ALL (
    SELECT name FROM world j
     WHERE i.continent=j.continent)
SELECT name,continent,population FROM world x
  WHERE 25000000 >= ALL (
    SELECT population FROM world y
     WHERE x.continent=y.continent
       AND y.population>0)
SELECT name,continent FROM world i
  WHERE population > ALL ( SELECT population*3 FROM world j
     WHERE i.continent=j.continent
       AND i.name != j.name
       AND j.population>0)

-- https://sqlzoo.net/wiki/SUM_and_COUNT
SELECT SUM(population) FROM world
SELECT DISTINCT(continent) FROM world
SELECT SUM(gdp) FROM world WHERE continent = 'Africa'
SELECT COUNT(area) FROM world WHERE area >= 1000000
SELECT sum(population) FROM world WHERE name IN ('Estonia', 'Latvia', 'Lithuania')
SELECT continent, COUNT(name) FROM world GROUP BY(continent)
SELECT continent, COUNT(name) FROM world WHERE population >= 10000000 GROUP BY(continent) 
SELECT continent FROM world GROUP BY(continent) HAVING SUM(population) >= 100000000

-- https://sqlzoo.net/wiki/The_JOIN_operation
SELECT matchid, player FROM goal WHERE teamid = 'GER'
SELECT id,stadium,team1,team2 FROM game WHERE id=1012
SELECT player,teamid, stadium, mdate FROM game JOIN goal ON (game.id = goal.matchid) WHERE teamid = 'GER'
SELECT team1, team2, player FROM  game JOIN goal ON (game.id = goal.matchid) WHERE player LIKE 'Mario%'
SELECT player, teamid, coach, gtime FROM goal JOIN eteam ON (goal.teamid = eteam.id) WHERE gtime<=10
SELECT mdate, teamname FROM game JOIN eteam ON(game.team1 = eteam.id) WHERE coach = 'Fernando Santos'
SELECT player FROM game JOIN goal ON(game.id = goal.matchid) WHERE stadium = 'National Stadium, Warsaw'
SELECT DISTINCT player FROM game JOIN goal ON matchid = id WHERE (team1 = 'GER' OR team2 = 'GER') AND teamid!='GER'
SELECT teamname,COUNT(teamid) FROM eteam JOIN goal ON id=teamid GROUP BY teamname
SELECT stadium,COUNT(gtime) FROM goal JOIN game ON id=matchid GROUP BY stadium
SELECT matchid,mdate,COUNT(teamid) FROM game JOIN goal ON matchid = id WHERE (team1 = 'POL' OR team2 = 'POL') GROUP BY matchid,mdate
SELECT matchid,mdate,COUNT(teamid) FROM game JOIN goal ON matchid = id WHERE (teamid='GER') GROUP BY matchid,mdate
SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
  FROM game LEFT JOIN goal ON matchid = id 
GROUP BY mdate,matchid,team1,team2

-- https://sqlzoo.net/wiki/More_JOIN_operations
SELECT id, title FROM movie WHERE yr=1962
SELECT yr FROM movie WHERE title='Citizen Kane'
SELECT id,title, yr FROM movie WHERE title LIKE 'Star Trek%' ORDER BY yr
SELECT id FROM actor WHERE name= 'Glenn Close'
SELECT id FROM movie WHERE title='Casablanca'
SELECT name FROM casting, actor WHERE movieid=(SELECT id FROM movie WHERE title='Casablanca') AND actorid=actor.id
SELECT name FROM movie, casting, actor WHERE title='Alien' AND movieid=movie.id AND actorid=actor.id
SELECT title FROM movie, casting, actor WHERE name='Harrison Ford' AND movieid=movie.id AND actorid=actor.id
SELECT title FROM movie, casting, actor WHERE name='Harrison Ford' AND movieid=movie.id AND actorid=actor.id AND ord<>1
SELECT title, name FROM movie, casting, actor WHERE yr=1962 AND movieid=movie.id AND actorid=actor.id AND ord=1
SELECT yr,COUNT(title) FROM movie JOIN casting ON movie.id=movieid JOIN actor ON actorid=actor.id where name='Rock Hudson' GROUP BY yr HAVING COUNT(title) > 2
SELECT title, name FROM movie, casting, actor
  WHERE movieid=movie.id AND actorid=actor.id AND ord=1 AND movieid IN
    (SELECT movieid FROM casting, actor WHERE actorid=actor.id AND name='Julie Andrews')

-- https://sqlzoo.net/wiki/Using_Null
SELECT name FROM teacher WHERE dept IS NULL
SELECT teacher.name, dept.name FROM teacher INNER JOIN dept ON (teacher.dept=dept.id)
SELECT teacher.name, dept.name FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)
SELECT teacher.name, dept.name FROM teacher RIGHT JOIN dept ON (teacher.dept=dept.id)
SELECT name, COALESCE(mobile,'07986 444 2266') FROM teacher
SELECT teacher.name, COALESCE(dept.name,'None') FROM teacher LEFT JOIN dept ON teacher.dept=dept.id
SELECT COUNT(teacher.name), COUNT(mobile) FROM teacher
SELECT dept.name, COUNT(teacher.name) FROM teacher RIGHT JOIN dept ON teacher.dept=dept.id GROUP BY dept.name
SELECT name, CASE WHEN dept IN (1,2) THEN 'Sci' ELSE 'Art' END FROM teacher
SELECT name, CASE WHEN dept IN (1,2)  THEN 'Sci' WHEN dept = 3  THEN 'Art' ELSE 'None' END FROM teacher

-- https://sqlzoo.net/wiki/NSS_Tutorial
SELECT A_STRONGLY_AGREE FROM nss
 WHERE question='Q01'
   AND institution='Edinburgh Napier University'
   AND subject='(8) Computer Science'
SELECT institution, subject FROM nss WHERE question='Q15' AND score>=100
SELECT institution, score FROM nss
 WHERE question='Q15' AND score<50 AND subject = '(8) Computer Science'
SELECT subject,SUM(response) FROM nss WHERE question='Q22' AND subject IN ('(8) Computer Science','(H) Creative Arts and Design') GROUP BY subject
SELECT subject,SUM(response*A_STRONGLY_AGREE/100) FROM nss WHERE question='Q22' AND subject IN ('(8) Computer Science','(H) Creative Arts and Design') GROUP BY subject
SELECT subject, ROUND(SUM(response*A_STRONGLY_AGREE)/SUM(response),0) FROM nss
 WHERE question='Q22' AND subject IN ('(8) Computer Science','(H) Creative Arts and Design') GROUP BY subject
SELECT institution, ROUND(SUM(response*score)/SUM(response),0) score FROM nss
 WHERE question='Q22' AND (institution LIKE '%Manchester%') GROUP BY institution
SELECT institution, SUM(sample), SUM(CASE WHEN subject LIKE '(8)%' THEN sample END) comp FROM nss WHERE question='Q01' AND (institution LIKE '%Manchester%') GROUP BY institution

-- https://sqlzoo.net/wiki/Window_functions
SELECT lastName, party, votes FROM ge WHERE constituency = 'S14000024' AND yr = 2017 ORDER BY votes DESC
SELECT party, votes, RANK() OVER (ORDER BY votes DESC) as posn FROM ge WHERE constituency = 'S14000024' AND yr = 2017 ORDER BY party
SELECT yr,party, votes, RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn FROM ge WHERE constituency = 'S14000021' ORDER BY party,yr
SELECT constituency,party, votes,
  RANK() OVER (PARTITION BY constituency ORDER BY votes DESC)
    AS posn FROM ge WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
   AND yr  = 2017 ORDER BY posn,constituency
SELECT constituency, party
  FROM ( SELECT constituency,party,
      RANK() OVER (PARTITION BY constituency ORDER BY votes DESC)
        AS posn FROM ge WHERE constituency BETWEEN 'S14000021' AND 'S14000026' AND yr  = 2017
   ) AS ed WHERE posn = 1
SELECT party,COUNT(1) FROM ( SELECT constituency,party,
      RANK() OVER (PARTITION BY constituency ORDER BY votes DESC)
        AS posn FROM ge WHERE constituency LIKE 'S%' AND yr  = 2017
   ) AS ed WHERE posn = 1 GROUP BY party

-- https://sqlzoo.net/wiki/Self_join
SELECT COUNT(*) FROM stops
SELECT id FROM stops WHERE name='Craiglockhart'
SELECT id, name FROM stops, route WHERE id=stop AND company='LRT' AND num='4'
SELECT company, num, COUNT(*) FROM route WHERE stop=149 OR stop=53 GROUP BY company, num HAVING COUNT(*)=2
SELECT a.company, a.num, a.stop, b.stop FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num) WHERE a.stop = 53 AND b.stop=149
SELECT a.company, a.num, stopa.name, stopb.name FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num) JOIN stops stopa ON (a.stop=stopa.id) JOIN stops stopb ON (b.stop=stopb.id)
    WHERE stopa.name='Craiglockhart' AND stopb.name='London Road'
SELECT DISTINCT R1.company, R1.num FROM route R1, route R2
  WHERE R1.num=R2.num AND R1.company=R2.company AND R1.stop=115 AND R2.stop=137
SELECT R1.company, R1.num FROM route R1, route R2, stops S1, stops S2
  WHERE R1.num=R2.num AND R1.company=R2.company
    AND R1.stop=S1.id AND R2.stop=S2.id AND S1.name='Craiglockhart' AND S2.name='Tollcross'
SELECT DISTINCT S2.name, R2.company, R2.num FROM stops S1, stops S2, route R1, route R2
  WHERE S1.name='Craiglockhart' AND S1.id=R1.stop AND R1.company=R2.company AND R1.num=R2.num AND R2.stop=S2.id

-- https://sqlzoo.net/wiki/Window_LAG
SELECT name, DAY(whn), confirmed, deaths, recovered FROM covid WHERE name = 'Spain' AND MONTH(whn) = 3 ORDER BY whn
SELECT name, DAY(whn), confirmed, LAG(confirmed, 1) OVER (partition by name ORDER BY whn) AS dbf FROM covid WHERE name = 'Italy' AND MONTH(whn) = 3 ORDER BY whn
SELECT name, DAY(whn), confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) as new
  FROM covid WHERE name = 'Italy' AND MONTH(whn) = 3 ORDER BY whn
SELECT name,DATE_FORMAT(whn,'%Y-%m-%d'), confirmed-LAG(confirmed,1) OVER (ORDER BY whn) "new this week" FROM covid WHERE name='Italy' and WEEKDAY(whn) = 0
SELECT tw.name, DATE_FORMAT(tw.whn,'%Y-%m-%d'),  tw.confirmed - lw.confirmed FROM covid tw LEFT JOIN covid lw ON 
  DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn AND tw.name=lw.name WHERE tw.name = 'Italy' AND WEEKDAY(tw.whn) = 0 ORDER BY tw.whn
SELECT name, confirmed, RANK() OVER (ORDER BY confirmed DESC) rc, deaths, RANK() OVER (ORDER BY deaths DESC) rc
  FROM covid WHERE whn = '2020-04-20' ORDER BY confirmed DESC
SELECT  world.name, ROUND(100000*confirmed/population,0), RANK() OVER (ORDER BY confirmed/population) AS rank
  FROM covid JOIN world ON covid.name=world.name WHERE whn = '2020-04-20' AND population > 10000000 ORDER BY population DESC
SELECT name,DATE_FORMAT(whn,'%Y-%m-%d'),
  newCases AS peakNewCases
FROM (
SELECT name,whn,newCases,
  RANK() OVER 
    (PARTITION BY name ORDER BY newCases DESC) rnc
FROM
(
  SELECT name, whn,
     confirmed -
     LAG(confirmed, 1) OVER
      (PARTITION BY name ORDER BY whn) as newCases
   FROM covid
) AS x
) AS y
WHERE rnc = 1 AND newCases>1000
ORDER BY whn

