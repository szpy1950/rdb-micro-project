-- list of interesting querries

-- 1) Counting the number of passengers between two given stations at at specific date. It is using the ticket data to achieve our desired result

SELECT 
    COUNT(DISTINCT t.customerId) as total_passengers,
    s_from.stationName as from_station,
    s_to.stationName as to_station,
    '2024-01-01'::DATE as travel_date  -- Replace with your date
FROM Ticket t
LEFT JOIN Station s_from ON t.fromStationId = s_from.id
LEFT JOIN Station s_to ON t.toStationId = s_to.id
WHERE DATE(t.validUntil) >= '2024-01-01'  -- Replace with your date
    AND DATE(t.validUntil - INTERVAL '24 hours') <= '2024-01-01'  -- Replace with your date
    -- Remove or modify these WHERE conditions as needed:
    AND t.fromStationId = 1  -- specify departure station
    AND t.toStationId = 2    -- specify arrival station
GROUP BY s_from.stationName, s_to.stationName;
