
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName NVARCHAR(50) UNIQUE NOT NULL 
 );
GO

CREATE TABLE Status (
    StatusID INT PRIMARY KEY IDENTITY(1,1),
    StatusName NVARCHAR(50) UNIQUE NOT NULL 
);

CREATE TABLE TriggerType (
    TriggerTypeID INT PRIMARY KEY IDENTITY(1,1),
    TriggerTypeName NVARCHAR(50) UNIQUE NOT NULL 
);

CREATE TABLE MessageType (
    MessageTypeID INT PRIMARY KEY IDENTITY(1,1),
    MessageTypeName NVARCHAR(50) UNIQUE NOT NULL 
);

CREATE TABLE NotificationType (
    NotificationTypeID INT PRIMARY KEY IDENTITY(1,1),
    TypeName NVARCHAR(100) UNIQUE NOT NULL 
);


CREATE TABLE VitalTypes (
    VitalTypeID INT PRIMARY KEY IDENTITY(1,1),
    VitalName NVARCHAR(50) NOT NULL, 
    Unit NVARCHAR(20), 
    HasTwoValues BIT DEFAULT 0 
);


INSERT INTO Roles (RoleName) VALUES ('Admin'), ('Doctor'), ('Child'), ('Caregiver'), ('caretaker');
INSERT INTO Status (StatusName) VALUES ('Pending'), ('Taken'), ('Skipped'), ('Missed');
INSERT INTO VitalTypes (VitalName, Unit, HasTwoValues) VALUES 
('Blood Pressure', 'mmHg', 1),
('Blood Sugar', 'mg/dL', 0),
('Heart Rate', 'bpm', 0),
('Oxygen Saturation', '%', 0),
('Weight', 'kg', 0);
GO


CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    RoleID INT NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NULL,
    Phone NVARCHAR(20) NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    DateOfBirth DATE NULL,
    Gender NVARCHAR(10) NULL,
    address NVARCHAR(200) NULL,
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    LastLogin DATETIME2,
    
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);
GO

 CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY,
    LicenseNumber varchar(30) NOT NULL,
    Specialization varchar(30) NOT NULL,
    Hospital varchar(255) NOT NULL,

    FOREIGN KEY (DoctorID) REFERENCES Users(UserID)
 );
GO
select * from status;
-- null
CREATE TABLE ElderProfiles (
    ElderID INT PRIMARY KEY,
    BloodType NVARCHAR(5), 
    Allergies NVARCHAR(MAX),
    ChronicConditions NVARCHAR(MAX), 
    EmergencyNotes NVARCHAR(MAX),
    Pastsurgeries NVARCHAR(MAX),
    PreferredDoctorID INT NULL, 
    
    FOREIGN KEY (ElderID) REFERENCES Users(UserID),
    FOREIGN KEY (PreferredDoctorID) REFERENCES Users(UserID)
);
GO

CREATE TABLE CareRelationships (
    RelationshipID INT PRIMARY KEY IDENTITY(1,1),
    ElderID INT NOT NULL,
    CaregiverID INT NOT NULL,
    RelationshipType NVARCHAR(50), 
    IsPrimary BIT DEFAULT 0,
  --  IsApproved BIT DEFAULT 1, 
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (ElderID) REFERENCES Users(UserID),
    FOREIGN KEY (CaregiverID) REFERENCES Users(UserID)
);
GO
select * from MedicationAdherence;

CREATE TABLE EmergencyContacts (
    ContactID INT PRIMARY KEY IDENTITY(1,1),
    ElderID INT NOT NULL,
    ContactName NVARCHAR(100),
    Phone NVARCHAR(20) NOT NULL,
    IsPrimary BIT DEFAULT 0,
    Relationship varchar(100) NUll,
    FOREIGN KEY (ElderID) REFERENCES Users(UserID)
);
GO
CREATE UNIQUE INDEX UX_EmergencyContacts_Primary
ON EmergencyContacts (ElderID)
WHERE IsPrimary = 1;

CREATE TABLE UserLogins (       
  LoginID INT PRIMARY KEY IDENTITY(1,1),
  SessionID VARCHAR(200) NULL,
  UserID INT NOT NULL,
  LoginTime DATETIME2 NULL DEFAULT GETDATE(),
  LogOutTime DATETIME2 NULL,
  RoleID INT NOT NULL,
  FOREIGN KEY (UserID) REFERENCES Users(UserID),
  FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);
--- not inserted
/*
CREATE TABLE LocationConsent (
    ConsentID INT PRIMARY KEY IDENTITY(1,1),
    ElderID INT NOT NULL,
    CaregiverID INT NOT NULL,
    IsEnabled BIT DEFAULT 0,
    
    FOREIGN KEY (ElderID) REFERENCES Users(UserID),
    FOREIGN KEY (CaregiverID) REFERENCES Users(UserID)
);
GO
*/

CREATE TABLE UserDevices (
    DeviceID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    FCMToken NVARCHAR(255) NULL,
    app_type VARCHAR(20) NOT NULL,
    Device_model VARCHAR(50) NULL,
    LastUpdated DATETIME2 DEFAULT GETDATE(),

    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

--DROP TABLE UserDevices;

CREATE TABLE Medications (
    MedicationID INT PRIMARY KEY IDENTITY(1,1),
    ElderID INT NOT NULL,
    MedicationName NVARCHAR(100) NOT NULL,
    Dosage NVARCHAR(50),
    Instructions NVARCHAR(255),

    CreatedBy INT NOT NULL, -- caregiver
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME2 DEFAULT GETDATE(),

    FOREIGN KEY (ElderID) REFERENCES Users(UserID),
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);
CREATE TABLE MedicationSchedules (
    ScheduleID INT PRIMARY KEY IDENTITY(1,1),
    MedicationID INT NOT NULL,

    TimeOfDay TIME NOT NULL,
    RepeatDays VARCHAR(20) NOT NULL,

    StartDate DATE NOT NULL,
    EndDate DATE NULL,

    IsActive BIT DEFAULT 1,

    FOREIGN KEY (MedicationID)
        REFERENCES Medications(MedicationID)
);

CREATE TABLE Status (
    StatusID INT PRIMARY KEY,
    StatusName NVARCHAR(20) NOT NULL
);
INSERT INTO Status (StatusID, StatusName) VALUES
(1, 'Pending'),
(2, 'Taken'),
(3, 'Missed'),
(4, 'Skipped');
CREATE TABLE MedicationAdherence (
    AdherenceID INT PRIMARY KEY IDENTITY(1,1),
    ScheduleID INT NOT NULL,
    ElderID INT NOT NULL,

    StatusID INT NOT NULL, 
    ScheduledFor DATETIME2 NOT NULL,
    TakenAt DATETIME2 NULL,
    Notes NVARCHAR(255),
    FOREIGN KEY (ScheduleID) REFERENCES MedicationSchedules(ScheduleID),
    FOREIGN KEY (StatusID)
        REFERENCES Status(StatusID),
    FOREIGN KEY (ElderID)
        REFERENCES Users(UserID)
);



CREATE TABLE VitalRecords (
    RecordID INT PRIMARY KEY IDENTITY(1,1),
    ElderID INT NOT NULL,
    VitalTypeID INT NOT NULL,
    
    -- Handle both Single (Sugar) and Double (BP) values
    Value DECIMAL(10, 2) NOT NULL,
 --   Notes NVARCHAR(255),
    RecordedBy INT NOT NULL, 
    RecordedAt DATETIME2 DEFAULT GETDATE(),
 
    FOREIGN KEY (ElderID) REFERENCES Users(UserID),
    FOREIGN KEY (VitalTypeID) REFERENCES VitalTypes(VitalTypeID),
    FOREIGN KEY (RecordedBy) REFERENCES Users(UserID)
);
GO