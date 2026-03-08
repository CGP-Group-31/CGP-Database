
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
    Timezone VARCHAR(100) NOT NULL,
    
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

    CreatedAt DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (ElderID) REFERENCES Users(UserID),
    FOREIGN KEY (CaregiverID) REFERENCES Users(UserID)
);
GO
select * from Appointments;
CREATE UNIQUE INDEX UX_CareRelationships_Pair ON CareRelationships(ElderID, CaregiverID);
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
CREATE INDEX IX_UserDevices_UserID ON UserDevices(UserID);
CREATE INDEX IX_UserDevices_AppType ON UserDevices(app_type);
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
    RepeatDays VARCHAR(50) NOT NULL,

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
    
    Value DECIMAL(10, 2) NOT NULL,
    Notes NVARCHAR(255),
    RecordedBy INT NOT NULL, 
    RecordedAt DATETIME2 DEFAULT GETDATE(),
 
    FOREIGN KEY (ElderID) REFERENCES Users(UserID),
    FOREIGN KEY (VitalTypeID) REFERENCES VitalTypes(VitalTypeID),
    FOREIGN KEY (RecordedBy) REFERENCES Users(UserID)
);
GO

CREATE TABLE AppointmentReminders (
    ReminderID INT PRIMARY KEY IDENTITY(1,1),
    AppointmentID INT NOT NULL,
    ReminderType VARCHAR(10) NOT NULL,  -- '24H' or '6H'
    ScheduledFor DATETIME2 NOT NULL,
    SentAt DATETIME2 NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'PENDING', -- PENDING, SENT, SKIPPED
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

CREATE UNIQUE INDEX UX_Appointment_ReminderType
ON AppointmentReminders(AppointmentID, ReminderType);



CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY IDENTITY(1,1),
    ElderID INT NOT NULL,
    DoctorName VARCHAR(100) NULL,
    Title NVARCHAR(100),

    Location NVARCHAR(255),
    Notes NVARCHAR(255),
    AppointmentDate DATE,
    AppointmentTime TIME(0),   -- 24-hour format
     RecordedAt DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (ElderID) REFERENCES Users(UserID)
   
);
GO
CREATE TABLE LocationTrack (
    LocationID INT PRIMARY KEY IDENTITY(1,1),
    ElderID INT NOT NULL,
    Latitude DECIMAL(10, 6),
    Longitude DECIMAL(10, 6),
    RecordedAt DATETIME2 DEFAULT GETDATE(),
    
    FOREIGN KEY (ElderID) REFERENCES Users(UserID)
);
GO


CREATE TABLE SOSLogs (
    SOSID INT PRIMARY KEY IDENTITY(1,1),
    ElderID INT NOT NULL,
    TriggerTypeID INT NOT NULL, 
    RelationshipID INT NOT NULL,
    TriggeredAt DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (ElderID) REFERENCES Users(UserID),
    FOREIGN KEY (RelationshipID) REFERENCES CareRelationships(RelationshipID)
);
GO


CREATE TABLE Messages (
    MessageID INT IDENTITY(1,1) PRIMARY KEY,
    RelationshipID INT,
    SenderID INT NOT NULL,
    message_text NVARCHAR(MAX),
    IsRead BIT DEFAULT 0,
    SentAt DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (RelationshipID) REFERENCES CareRelationships(RelationshipID),
    FOREIGN KEY (SenderID) REFERENCES Users(UserID)
);
GO


CREATE INDEX IX_Messages_IsRead ON Messages(IsRead);

CREATE INDEX IX_Messages_Relationship_SentAt ON Messages(RelationshipID, SentAt);
CREATE INDEX IX_Messages_IsRead ON Messages(IsRead);


CREATE TABLE MealAdherence (
    MealAdherenceID INT PRIMARY KEY IDENTITY(1,1),
    ElderID INT NOT NULL,

    MealTime VARCHAR(10) NOT NULL,  -- BREAKFAST / LUNCH / DINNER
    ScheduledFor DATETIME2 NOT NULL, -- local-time slot stored as datetime2 (server inserts)
    StatusID INT NOT NULL,           -- 1 Pending, 2 Taken, 3 Missed, 4 Skipped

    Diet NVARCHAR(255) NULL,        -- what they ate
    UpdatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_MealAdherence_Users
        FOREIGN KEY (ElderID) REFERENCES Users(UserID),
         CONSTRAINT FK_MealAdherence_Status
FOREIGN KEY (StatusID) REFERENCES Status(StatusID),
    CONSTRAINT UQ_MealAdherence UNIQUE (ElderID, MealTime, ScheduledFor)
);

INSERT INTO TriggerType (TriggerTypeName)
VALUES 
    ('Emergency Call'),
    ('Ambulance Call');

        CREATE TABLE MoodTypes (   
    MoodID INT IDENTITY(1,1) PRIMARY KEY,
    MoodName NVARCHAR(50) NOT NULL UNIQUE
);  -------ai eken
INSERT INTO MoodTypes (MoodName)
VALUES ('Happy'), ('Neutral'), ('Sad'), ('Anxious'), ('Angry'), ('Confused'), ('Tired');
