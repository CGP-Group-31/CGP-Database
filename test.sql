
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

    FOREIGN KEY (DoctorID) REFERENCES Users(UserID),
 );
GO


CREATE TABLE ElderProfiles (
    ElderID INT PRIMARY KEY,
    BloodType NVARCHAR(5), 
    Allergies NVARCHAR(MAX),
    ChronicConditions NVARCHAR(MAX), 
    EmergencyNotes NVARCHAR(MAX),
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

CREATE TABLE EmergencyContacts (
    ContactID INT PRIMARY KEY IDENTITY(1,1),
    ElderID INT NOT NULL,
    ContactName NVARCHAR(100),
    Phone NVARCHAR(20) NOT NULL,
    PriorityOrder INT, 
    
    FOREIGN KEY (ElderID) REFERENCES Users(UserID)
);
GO
