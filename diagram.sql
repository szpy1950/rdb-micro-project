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
  startStationId INT NOT NULL REFERENCES Station(id),
  endStationId INT NOT NULL REFERENCES Station(id)
);

CREATE TABLE Segment (
  id SERIAL PRIMARY KEY,
  fromStationId INT NOT NULL REFERENCES Station(id),
  toStationId INT NOT NULL REFERENCES Station(id),
  duration INT NOT NULL,
  trainTypeId INT NOT NULL REFERENCES TrainType(id),
  price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Path (
  id SERIAL PRIMARY KEY,
  lineId INT NOT NULL REFERENCES Line(id),
  trainTypeId INT NOT NULL REFERENCES TrainType(id)
);

CREATE TABLE PathSegment (
  pathId INT NOT NULL REFERENCES Path(id),
  segmentId INT NOT NULL REFERENCES Segment(id),
  segmentIndex INT NOT NULL,
);

CREATE TABLE Train (
  id SERIAL PRIMARY KEY,
  typeId INT NOT NULL REFERENCES TrainType(id),
  capacity INT NOT NULL
);

CREATE TABLE TrainPath (
  trainId INT NOT NULL REFERENCES Train(id),
  pathId INT NOT NULL REFERENCES Path(id)
  departure TIME NOT NULL,
);

CREATE TABLE Ticket (
  id SERIAL PRIMARY KEY,
  fromStationId INT NOT NULL REFERENCES Station(id),
  toStationId INT NOT NULL REFERENCES Station(id),
  customerId INT NOT NULL REFERENCES Customer(id),
  price DECIMAL(10, 2) NOT NULL,
  validUntil DATETIME NOT NULL
);

CREATE TABLE Customer (
  id SERIAL PRIMARY KEY,
  firstname VARCHAR(255) NOT NULL,
  lastname VARCHAR(255) NOT NULL,
  birthdate DATE NOT NULL
);
