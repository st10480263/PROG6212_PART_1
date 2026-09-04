CREATE DATABASE Prog_Database

USE Prog_Database

CREATE TABLE Venue( 
	VenueID INT NOT NULL PRIMARY KEY,
	VenueName VARCHAR(100) NOT NULL,
	City VARCHAR(100) NOT NULL,
	Province VARCHAR(100) NOT NULL
);

INSERT INTO Venue (VenueID, VenueName, City, Province) VALUES
	(1, 'FNB Stadium', 'Johannesburg', 'Gauteng'),
	(2, 'Grand Parade', 'Cape Town', 'Western Cape'),
	(3, 'North Beach Promenade', 'Durban', 'KwaZulu-Natal');

CREATE TABLE Users(
	UserID INT NOT NULL PRIMARY KEY,
	FullName VARCHAR(100) NOT NULL,
	Email VARCHAR(100) NOT NULL,
	Role VARCHAR(100) NOT NULL,
	PhoneNumber VARCHAR(100) NOT NULL
);

INSERT INTO Users (UserID, FullName, Email, Role, PhoneNumber) VALUES
	(1, 'Sipho Ndlovu', 'sipho.organizer@raceday.co.za', 'Organiser', '0821234567'),
	(2, 'Karen van der Merwe', 'karen.vdm@caperaces.co.za', 'Organiser', '0839876543'),
	(3, 'Tebogo Moloto', 'tebogo.dev@gmail.com', 'Participant', '0712345678'),
	(4, 'Sbusiso Khoza', 'sbu.khoza@gmail.com', 'Participant', '0798765432');

CREATE TABLE Events(
	EventID INT NOT NULL PRIMARY KEY,
	OrganiserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
	VenueID INT NOT NULL FOREIGN KEY REFERENCES Venue(VenueID),
	EventName VARCHAR(100) NOT NULL,
	EventType VARCHAR(100) NOT NULL,
	EventDate VARCHAR(100) NOT NULL
	);

INSERT INTO Events (EventID, OrganiserID, VenueID, EventName, EventType, EventDate) VALUES
	(1, 1, 1, 'Soweto Marathon 2026', 'Running', '2026-11-01'),
	(2, 2, 2, 'Cape Town Cycle Tour 2027', 'Cycling', '2027-03-14'),
	(3, 1, 3, 'Durban Coastal Fun Walk', 'Walking', '2026-10-10');

CREATE TABLE Categories(
	CategoryID INT NOT NULL PRIMARY KEY,
	EventID INT NOT NULL FOREIGN KEY REFERENCES Events(EventID),
	CategoryName VARCHAR(100) NOT NULL,
	Distance VARCHAR(100) NOT NULL,
	EntryFee VARCHAR(100) NOT NULL
);

INSERT INTO Categories (CategoryID, EventID, CategoryName, Distance, EntryFee) VALUES
	(1, 1, '42.2km Full Marathon', '42.2 km', 'R380.00'),
	(2, 1, '21.1km Half Marathon', '21.1 km', 'R250.00'),
	(3, 1, '10km Road Race', '10.0 km', 'R150.00'),
	(4, 2, '109km Classic Tour', '109.0 km', 'R650.00'),
	(5, 2, '42km Short Route', '42.0 km', 'R320.00'),
	(6, 3, '5km Family Fun Walk', '5.0 km', 'R50.00'),
	(7, 3, '10km Power Walk', '10.0 km', 'R90.00');


CREATE TABLE Enrolments(
	EnrolmentID INT NOT NULL PRIMARY KEY,
	ParticipantID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
	CategoryID INT NOT NULL FOREIGN KEY REFERENCES Categories(CategoryID),
	RegistrationDate DATETIME NOT NULL
);

CREATE TABLE Results(
	ResultID INT NOT NULL PRIMARY KEY,
	EnrolmentID INT NOT NULL FOREIGN KEY REFERENCES Enrolments(EnrolmentID),
	FinishTime TIME NOT NULL,
	Position VARCHAR(100) NOT NULL,
	Status VARCHAR(100) NOT NULL
);


