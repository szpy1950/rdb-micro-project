-- Insert data into City
INSERT INTO City (cityName) VALUES
('Genève'),
('Nyon'),
('Morges'),
('Lausanne'),
('Vevey'),
('Montreux'),
('Aigle'),
('Sion'),
('Sierre'),
('Martigny'),
('Monthey'),
('St-Maurice')
('Visp'),
('Brig'),
('Leuk'),
('St-Gingolph'),
('Bouveret'),
('Les Evouettes'),
('Vouvry'),
('Vionnaz'),
('Collombey'),
('Massongex'),
('St-Maurice'),
('Evionnaz'),
('Vernayaz'),
('Charrat-Fully'),
('Saxon'),
('Riddes'),
('Chamoson St-Pierre-de-Clages'),
('Chateauneuf-Conthey'),
('Ardon'),
('St-Léonard'),
('Salgeasch'),
('Turtmann'),
('Gampel-Steg'),
('Raron'),
('Basel'),
('Olten'),
('Bern'),
('Thun'),
('Spiez');

-- Insert data into TrainType
INSERT INTO TrainType (id, trainTypeName) VALUES
(1, 'Regional'),
(2, 'Interregio'),
(3, 'Intercity');

-- Insert data into Station
INSERT INTO Station (cityId, stationName) VALUES
(1, 'Gare Cornavin'),
(2, 'Gare de Nyon'),
(3, 'Gare de Morges'),
(4, 'Gare de Lausanne'),
(5, 'Gare de Vevey'),
(6, 'Gare de Montreux'),
(7, 'Gare d"Aigle'),
(8, 'Gare de Sion'),
(9, 'Gare de Sierre'),
(10, 'Gare de Martigny'),
(11, 'Gare de Monthey'),
(12, 'Gare de St-Maurice'),
(13, 'Gare de Visp'),
(14, 'Gare de Brig'),
(15, 'Gare de Leuk'),
(16, 'Gare de St-Gingolph'),
(17, 'Gare de Bouveret'),
(18, 'Gare des Evouettes'),
(19, 'Gare de Vouvry'),
(20, 'Gare de Vionnaz'),
(21, 'Gare de Collombey'),
(22, 'Gare de Massongex'),
(23, 'Gare de St-Maurice'),
(24, 'Gare d"Evionnaz'),
(25, 'Gare de Vernayaz'),
(26, 'Gare de Charrat-Fully'),
(27, 'Gare de Saxon'),
(28, 'Gare de Riddes'),
(29, 'Gare de Chamoson St-Pierre-de-Clages'),
(30, 'Gare de Chateauneuf-Conthey'),
(31, 'Gare d"Ardon'),
(32, 'Gare de St-Léonard'),
(33, 'Gare de Salgeasch'),
(34, 'Gare de Turtmann'),
(35, 'Gare de Gampel-Steg'),
(36, 'Gare de Raron'),
(37, 'Geneve-Aeroport'),
(38, 'Basel SBB'),
(39, 'Gare d"Olten'),
(40, 'Gare de Bern'),
(41, 'Gare de Thun'),
(42, 'Gare de Spiez');

-- Insert data into Line
INSERT INTO Line (id, startStationId, endStationId) VALUES
(1, 37, 14),
(2, 16, 14),
(3, 38, 14);

-- Insert data into Segment
INSERT INTO Segment (id, fromStationId, toStationId, duration, price) VALUES
(1, 37, 1, 7, 7);
(2, 1, 2, 14, 14),
(3, 2, 3, 16, 16),
(4, 3, 4, 12, 12),
(5, 4, 5, 14, 14),
(6, 5, 6, 6, 6),
(7, 6, 7, 10, 10),
(8, 7, 10, 12, 12);

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
