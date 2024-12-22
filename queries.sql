-- List of interesting queries

-- 1) Find all the departures from a station for the current date
SELECT tp.departure + pi.timeOffset AS departure,
       tt.trainTypeName AS trainType,
       s.stationName AS terminus
FROM (
  SELECT p.id, SUM(s2.duration) * '1 minute'::INTERVAL AS timeOffset
  FROM Station AS st
  JOIN Segment AS s1 ON s1.fromStationId=st.id
  JOIN PathSegment AS ps1 ON ps1.segmentId=s1.id
  JOIN Path AS p ON p.id=ps1.pathId
  JOIN PathSegment AS ps2 ON ps1.pathId=p.id
  JOIN Segment AS s2 ON s2.id=ps2.segmentId
  WHERE st.id=8  -- Replace with desired station
    AND ps2.segmentIndex < ps1.segmentIndex
  GROUP BY p.id
) AS pi
JOIN Path as p ON p.id=pi.id
JOIN Line AS l ON l.id=p.lineId
JOIN Station AS s ON s.id=l.endStationId
JOIN TrainPath AS tp ON tp.pathId=p.id
JOIN Train AS t ON t.id=tp.trainId
JOIN TrainType AS tt ON tt.id=t.typeId;

-- 2) List the customers who have purchased tickets above a certain price 
SELECT DISTINCT 
    c.firstName,
    c.lastName,
    t.price
FROM Customer c
JOIN Ticket t ON c.id = t.customerId
WHERE t.price > 100.00  -- Replace with desired price
ORDER BY t.price DESC;

-- 3) Get the average price of tickets between cities:
SELECT 
    c1.cityName as from_city,
    c2.cityName as to_city,
    ROUND(AVG(t.price), 2) as avg_ticket_price
FROM Ticket t
JOIN Station s1 ON t.fromStationId = s1.id
JOIN Station s2 ON t.toStationId = s2.id
JOIN City c1 ON s1.cityId = c1.id
JOIN City c2 ON s2.cityId = c2.id
GROUP BY c1.cityName, c2.cityName;

-- 4) Find the 10 most popular routes by ticket count
SELECT 
    s1.stationName as from_station,
    s2.stationName as to_station,
    COUNT(*) as ticket_count
FROM Ticket t
JOIN Station s1 ON t.fromStationId = s1.id
JOIN Station s2 ON t.toStationId = s2.id
GROUP BY s1.stationName, s2.stationName
ORDER BY ticket_count DESC
LIMIT 10;

-- 5) Counting the number of passengers between two given stations at at specific date
SELECT 
    COUNT(DISTINCT t.customerId) as total_passengers,
    s_from.stationName as from_station,
    s_to.stationName as to_station
FROM Ticket t
LEFT JOIN Station s_from ON t.fromStationId = s_from.id
LEFT JOIN Station s_to ON t.toStationId = s_to.id
WHERE '2024-12-31'::DATE BETWEEN DATE(t.validUntil) - INTERVAL '1 day'
                             AND DATE(t.validUntil)  -- Replace with your date
  AND t.fromStationId = 1  -- departure station
  AND t.toStationId = 3    -- arrival station
GROUP BY s_from.stationName, s_to.stationName;

-- 6) Count the number of trains circulating at a given hour, grouped by train type
SELECT COUNT(*) AS trains, tt.trainTypeName
FROM Train AS t
JOIN TrainType AS tt ON tt.id=t.typeId
JOIN TrainPath AS tp ON tp.trainId=t.id
JOIN (
    SELECT p.id, SUM(s.duration) AS duration
    FROM Path AS p
    JOIN PathSegment AS ps ON ps.pathId=p.id
    JOIN Segment AS s ON s.id=ps.segmentId
    GROUP BY p.id
) AS temp ON temp.id=tp.pathId
WHERE '09:00:00' BETWEEN tp.departure AND tp.departure + (temp.duration * '1 minute'::INTERVAL)
GROUP BY tt.id;
