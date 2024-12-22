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
('St-Maurice'),
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
(23, 'Gare d"Evionnaz'),
(24, 'Gare de Vernayaz'),
(25, 'Gare de Charrat-Fully'),
(26, 'Gare de Saxon'),
(27, 'Gare de Riddes'),
(28, 'Gare de Chamoson St-Pierre-de-Clages'),
(29, 'Gare de Chateauneuf-Conthey'),
(30, 'Gare d"Ardon'),
(31, 'Gare de St-Léonard'),
(32, 'Gare de Salgeasch'),
(33, 'Gare de Turtmann'),
(34, 'Gare de Gampel-Steg'),
(35, 'Gare de Raron'),
(1, 'Genève-Aéroport'),
(36, 'Basel SBB'),
(37, 'Gare d"Olten'),
(38, 'Gare de Bern'),
(39, 'Gare de Thun'),
(40, 'Gare de Spiez');

-- Insert data into Line
INSERT INTO Line (id, startStationId, endStationId) VALUES
(1, 36, 14), -- Geneve-Aeroport -> Gare de Brig
(2, 16, 14), -- Gare de St-Gingolphe -> Gare de Brig
(3, 37, 14); -- Basel SBB -> Gare de Brig

-- Insert data into Segment
INSERT INTO Segment (id, fromStationId, toStationId, duration, price) VALUES
(1, 36, 1, 7, 7), -- Geneve-Aeroport -> Gare Cornavin
(2, 1, 2, 14, 14), -- Gare Cornavin -> Gare de Nyon
(3, 2, 3, 16, 16), -- Gare de Nyon -> Gare de Morges
(4, 3, 4, 12, 12), -- Gare de Morges -> Gare de Lausanne
(5, 4, 5, 14, 14), -- Gare de Lausanne -> Gare de Vevey
(6, 5, 6, 6, 6), -- Gare de Vevey -> Gare de Montreux
(7, 6, 7, 10, 10), -- Gare de Montreux -> Gare d"Aigle
(8, 7, 10, 12, 12), -- Gare d'Aigle -> Gare de Martigny
(9, 10, 8, 15, 15), -- Gare de Martigny -> Gare de Sion
(10, 8, 9, 10, 10), -- Gare de Sion -> Gare de Sierre
(11, 9, 15, 7, 7), -- Gare de Sierre -> Gare de Leuk
(12, 15, 13, 11, 11), -- Gare de Leuk -> Gare de Visp
(13, 13, 14, 8, 8), -- Gare de Visp -> Gare de Brig  (Interregio + IC)
(14, 16, 17, 4, 4), -- Gare de St-Gingolphe -> Gare du Bouveret
(15, 17, 18, 3, 3), -- Gare du Bouveret -> Gare des Evouettes
(16, 18, 19, 2, 2), -- Gare des Evouettes -> Gare de Vouvry
(17, 19, 20, 3, 3), -- Gare de Vouvry -> Gare de Vionnaz
(18, 20, 21, 4, 4), -- Gare de Vionnaz -> Gare de Collombey
(19, 21, 11, 3, 3), -- Gare de Collombey -> Gare de Monthey
(20, 11, 22, 3, 3), -- Gare de Monthey -> Gare de Massongex
(21, 22, 23, 5, 5), -- Gare de Massongex -> Gare de St-Maurice
(22, 12, 24, 5, 5), -- Gare de St-Maurice -> Gare d"Evionnaz
(23, 23, 25, 3, 3), -- Gare d'Evionnaz -> Gare de Vernayaz
(24, 24, 10, 5, 5), -- Gare de Vernayaz -> Gare de Martigny
(25, 10, 26, 4, 4), -- Gare de Martigny -> Gare de Charrat-Fully
(26, 25, 27, 3, 3), -- Gare de Charrat-Fully -> Gare de Saxon
(27, 26, 28, 3, 3), -- Gare de Saxon -> Gare de Riddes
(28, 27, 29, 3, 3), -- Gare de Riddes -> Gare de Chamoson St-Pierre-de-Clages
(29, 28, 31, 3, 3), -- Gare de Chamoson St-Pierre-de-Clages -> Gare d'Ardon
(30, 30, 30, 2, 2), -- Gare d'Ardon -> Gare de Chateauneuf-Conthey
(31, 29, 8, 5, 5), -- Gare de Chateauneuf-Conthey -> Gare de Sion
(32, 8, 32, 5, 5), -- Gare de Sion -> Gare de St-Léonard
(33, 31, 9, 6, 6), -- Gare de St-Léonard -> Gare de Sierre
(34, 9, 33, 4, 4), -- Gare de Sierre -> Gare de Salgeasch
(35, 32, 15, 5, 5), -- Gare de Salgeasch -> Gare de Leuk
(36, 15, 34, 3, 3), -- Gare de Leuk -> Gare de Turtmann
(37, 33, 35, 3, 3), -- Gare de Turtmann -> Gare de Gampel-Steg
(38, 34, 36, 3, 3), -- Gare de Gampel-Steg -> Gare de Raron
(39, 35, 13, 6, 6), -- Gare de Raron -> Gare de Visp
(40, 13, 14, 10, 10), -- Gare de Visp -> Gare de Brig (Regio)
(41, 37, 39, 27, 27), -- Basel SBB -> Gare d'Olten
(42, 38, 40, 28, 28), -- Gare d'Olten -> Gare de Bern
(43, 39, 41, 20, 20), -- Gare de Bern -> Gare de Thun
(44, 40, 42, 9, 9), -- Gare de Thun -> Gare de Spiez
(45, 41, 13, 26, 26); -- Gare de Spiez -> Gare de Visp


-- Insert data into Path
INSERT INTO Path (id, lineId, trainTypeId) VALUES
(1, 1, 2), -- Interr
(2, 2, 1), -- Regio
(3, 3, 3); -- IC

-- Insert data into PathSegment
INSERT INTO PathSegment (pathId, segmentId, segmentIndex) VALUES
(1, 1, 1),
(1, 2, 2),
(1, 3, 3),
(1, 4, 4),
(1, 5, 5),
(1, 6, 6),
(1, 7, 7),
(1, 8, 8),
(1, 9, 9),
(1, 10, 10),
(1, 11, 11),
(1, 12, 12),
(1, 13, 13),
(2, 14, 1),
(2, 15, 2),
(2, 16, 3),
(2, 17, 4),
(2, 18, 5),
(2, 19, 6),
(2, 20, 7),
(2, 21, 8),
(2, 22, 9),
(2, 23, 10),
(2, 24, 11),
(2, 25, 12),
(2, 26, 13),
(2, 27, 14),
(2, 28, 15),
(2, 29, 16),
(2, 30, 17),
(2, 31, 18),
(2, 32, 19),
(2, 33, 20),
(2, 34, 21),
(2, 35, 22),
(2, 36, 23),
(2, 37, 24),
(2, 38, 25),
(2, 39, 26),
(2, 40, 27),
(3, 41, 1),
(3, 42, 2),
(3, 43, 3),
(3, 44, 4),
(3, 45, 5);

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
(3, 'Paul', 'Durand', '1975-03-30'),
(4, 'Sophie', 'Lefevre', '1988-07-10'),
(5, 'Pierre', 'Leroy', '1990-01-25'),
(6, 'Marie', 'Leroy', '1990-01-25');

-- Insert data into Ticket
INSERT INTO Ticket (id, fromStationId, toStationId, customerId, price, validUntil) VALUES
(1, 1, 3, 1, 45.00, '2024-12-31 23:59:59'),
(2, 3, 2, 2, 40.00, '2024-12-31 23:59:59'),
(3, 4, 5, 3, 35.00, '2024-12-31 23:59:59'),
(4, 5, 6, 4, 30.00, '2024-12-31 23:59:59'),
(5, 6, 7, 5, 25.00, '2024-12-31 23:59:59'),
(6, 7, 8, 6, 20.00, '2024-12-31 23:59:59');
