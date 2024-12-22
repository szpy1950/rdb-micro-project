CREATE TABLE City (
  id SERIAL PRIMARY KEY,
  cityName VARCHAR(255) NOT NULL
);

CREATE TABLE TrainType (
  id SERIAL PRIMARY KEY,
  trainTypeName VARCHAR(255) NOT NULL
);

CREATE TABLE Station (
  id SERIAL PRIMARY KEY,
  cityId INT NOT NULL REFERENCES City(id),
  stationName VARCHAR(255) NOT NULL
);

CREATE TABLE Line (
  id SERIAL PRIMARY KEY,
  startStationId INT NOT NULL REFERENCES Station(id) ON DELETE CASCADE,
  endStationId INT NOT NULL REFERENCES Station(id) ON DELETE CASCADE
);

CREATE TABLE Segment (
  id SERIAL PRIMARY KEY,
  fromStationId INT NOT NULL REFERENCES Station(id) ON DELETE CASCADE,
  toStationId INT NOT NULL REFERENCES Station(id) ON DELETE CASCADE,
  duration INT NOT NULL CHECK (duration > 0),
  price DECIMAL(10, 2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE Path (
  id SERIAL PRIMARY KEY,
  lineId INT NOT NULL REFERENCES Line(id),
  trainTypeId INT NOT NULL REFERENCES TrainType(id)
);

CREATE TABLE PathSegment (
  pathId INT NOT NULL REFERENCES Path(id) ON DELETE CASCADE,
  segmentId INT NOT NULL REFERENCES Segment(id) ON DELETE CASCADE,
  segmentIndex INT NOT NULL,
  PRIMARY KEY (pathId, segmentId, segmentIndex)
);

CREATE TABLE Train (
  id SERIAL PRIMARY KEY,
  typeId INT NOT NULL REFERENCES TrainType(id) ON DELETE CASCADE,
  capacity INT NOT NULL CHECK (capacity > 0)
);

CREATE TABLE Customer (
  id SERIAL PRIMARY KEY,
  firstName VARCHAR(255) NOT NULL,
  lastName VARCHAR(255) NOT NULL,
  birthDate DATE NOT NULL
);

CREATE TABLE TrainPath (
  trainId INT NOT NULL REFERENCES Train(id) ON DELETE CASCADE,
  pathId INT NOT NULL REFERENCES Path(id) ON DELETE CASCADE,
  departure TIME NOT NULL,
  PRIMARY KEY (trainId, pathId, departure)
);

CREATE TABLE Ticket (
  id SERIAL PRIMARY KEY,
  fromStationId INT NOT NULL REFERENCES Station(id) ON DELETE CASCADE,
  toStationId INT NOT NULL REFERENCES Station(id) ON DELETE CASCADE,
  customerId INT NOT NULL REFERENCES Customer(id) ON DELETE CASCADE,
  price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
  validUntil TIMESTAMP NOT NULL CHECK (validUntil > CURRENT_TIMESTAMP)
);

-- Indexes
CREATE INDEX idx_station_city ON Station(cityId);
CREATE INDEX idx_segment_from ON Segment(fromStationId);
CREATE INDEX idx_segment_to ON Segment(toStationId);
CREATE INDEX idx_ticket_customer ON Ticket(customerId);
CREATE INDEX idx_train_type ON Train(typeId);
CREATE INDEX idx_pathsegment_index ON PathSegment(segmentIndex);
CREATE INDEX idx_path_line ON Path(lineId);
CREATE INDEX idx_trainpath_departure ON TrainPath(departure);

-- Composite indexes for common queries
CREATE INDEX idx_segment_stations ON Segment(fromStationId, toStationId);
CREATE INDEX idx_train_search ON Train(typeId, capacity);
CREATE INDEX idx_ticket_search ON Ticket(customerId, validUntil);
CREATE INDEX idx_ticket_stations ON Ticket(fromStationId, toStationId);


ALTER TABLE Line ADD CONSTRAINT check_different_stations 
    CHECK (startStationId != endStationId);

ALTER TABLE PathSegment ADD CONSTRAINT check_segment_index 
    CHECK (segmentIndex >= 0);

ALTER TABLE PathSegment ADD CONSTRAINT unique_path_segment_order 
    UNIQUE (pathId, segmentIndex);


-- Useful views
CREATE VIEW SegmentWithStations AS (
  SELECT s.id, st1.stationName AS fromStation, st2.stationName AS toStation, s.duration, s.price
  FROM Segment AS s
  JOIN Station AS st1 ON st1.id=s.fromStationId
  JOIN Station AS st2 ON st2.id=s.toStationId
);

CREATE VIEW TicketWithNames AS (
  SELECT t.id,
         s1.stationName AS fromStation,
         s2.stationName AS toStation,
         c.firstName || ' ' || c.lastName AS customer,
         t.price,
         t.validUntil
  FROM Ticket AS t
  JOIN Station AS s1 ON s1.id=t.fromStationId
  JOIN Station AS s2 ON s2.id=t.toStationId
  JOIN Customer AS c ON c.id=t.customerId
);

CREATE VIEW LineWithStations AS (
  SELECT l.id, s1.stationName AS fromStation, s2.stationName AS toStation
  FROM Line AS l
  JOIN Station AS s1 ON s1.id=l.startStationId
  JOIN Station AS s2 ON s2.id=l.endStationId
);
