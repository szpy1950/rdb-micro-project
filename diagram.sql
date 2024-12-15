CREATE TABLE City (
  id SERIAL PRIMARY KEY
);

CREATE TABLE TrainType (
  id SERIAL PRIMARY KEY
);

CREATE TABLE Station (
  id SERIAL PRIMARY KEY,
  cityId INT REFERENCES City(id)
);

CREATE TABLE Line (
  id SERIAL PRIMARY KEY,
  startStationId INT REFERENCES Station(id),
  endStationId INT REFERENCES Station(id)
);

CREATE TABLE Segment (
  id SERIAL PRIMARY KEY,
  fromStationId INT REFERENCES Station(id),
  toStationId INT REFERENCES Station(id),
  duration INT NOT NULL,
  trainTypeId INT REFERENCES TrainType(id),
  price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Path (
  id SERIAL PRIMARY KEY,
  lineId INT REFERENCES Line(id),
  trainTypeId INT REFERENCES TrainType(id)
);

CREATE TABLE PathSegment (
  pathId INT REFERENCES Path(id),
  segmentId INT REFERENCES Segment(id),
  segmentIndex INT NOT NULL,
);

CREATE TABLE Train (
  id SERIAL PRIMARY KEY,
  typeId INT REFERENCES TrainType(id),
  capacity INT NOT NULL
);

CREATE TABLE TrainPath (
  trainId INT REFERENCES Train(id),
  pathId INT REFERENCES Path(id)
  departure TIME NOT NULL,
);

CREATE TABLE Ticket (
  id SERIAL PRIMARY KEY,
  fromStationId INT REFERENCES Station(id),
  toStationId INT REFERENCES Station(id),
  customerId INT REFERENCES Customer(id),
  price DECIMAL(10, 2) NOT NULL,
  validUntil DATETIME NOT NULL
);

CREATE TABLE Customer (
  id SERIAL PRIMARY KEY,
  firstname VARCHAR(255) NOT NULL,
  lastname VARCHAR(255) NOT NULL,
  birthdate DATE NOT NULL
);
