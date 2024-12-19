-- Insert data into City
INSERT INTO City (id, cityName) VALUES
(1, 'Zurich'),
(2, 'Geneva'),
(3, 'Bern'),
(4, 'Basel'),
(5, 'Lausanne');

-- Insert data into TrainType
INSERT INTO TrainType (id, trainTypeName) VALUES
(1, 'Regional'),
(2, 'Interregio'),
(3, 'Intercity');

-- Insert data into Station
INSERT INTO Station (id, cityId, stationName) VALUES
(1, 1, 'Zurich HB'),
(2, 2, 'Geneva Cornavin'),
(3, 3, 'Bern Bahnhof'),
(4, 4, 'Basel SBB'),
(5, 5, 'Lausanne Gare');

-- Insert data into Line
INSERT INTO Line (id, startStationId, endStationId) VALUES
(1, 1, 3),
(2, 3, 2),
(3, 4, 5),
(4, 2, 5);

-- Insert data into Segment
INSERT INTO Segment (id, fromStationId, toStationId, duration, price) VALUES
(1, 1, 3, 90, 45.00),
(2, 3, 2, 75, 40.00),
(3, 4, 5, 60, 35.00),
(4, 2, 5, 120, 50.00);

-- Insert data into Path
INSERT INTO Path (id, lineId, trainTypeId) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 1),
(4, 4, 2);

-- Insert data into PathSegment
INSERT INTO PathSegment (pathId, segmentId, segmentIndex) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1);

-- Insert data into Train
INSERT INTO Train (id, typeId, capacity) VALUES
(1, 2, 200),
(2, 3, 300),
(3, 1, 150);

-- Insert data into TrainPath
INSERT INTO TrainPath (trainId, pathId, departure) VALUES
(1, 1, '08:00:00'),
(2, 2, '09:30:00'),
(3, 3, '10:45:00');

-- Insert data into Customer
INSERT INTO Customer (id, firstname, lastname, birthdate) VALUES
(1, 'Jean', 'Dupont', '1980-05-15'),
(2, 'Marie', 'Curie', '1992-11-20'),
(3, 'Paul', 'Durand', '1975-03-30');

-- Insert data into Ticket
INSERT INTO Ticket (id, fromStationId, toStationId, customerId, price, validUntil) VALUES
(1, 1, 3, 1, 45.00, '2024-12-31 23:59:59'),
(2, 3, 2, 2, 40.00, '2024-12-31 23:59:59'),
(3, 4, 5, 3, 35.00, '2024-12-31 23:59:59');
