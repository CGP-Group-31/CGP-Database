SELECT * from Roles;
SELECT * from VitalTypes;
SELECT * FROM VitalRecords;
SELECT * FROM DOCTOR;

SELECT * from Users;
select * from CareRelationships;
SELECT * FROM Users WHERE Timezone = '+ 00:00';
SELECT * from ElderProfiles;
SELECT * from UserLogins;
ALTER TABLE ElderProfiles
ADD  Pasrsurgeries NVARCHAR(MAX);

SELECT * FROM UserDevices;

EXEC sp_rename 'ElderProfiles.Pasrsurgeries', 'Pastsurgeries', 'COLUMN';

SELECt * FROM EmergencyContacts;

INSERT INTO Users 
(RoleID, FullName, Email, Phone, PasswordHash, DateOfBirth, Gender, IsActive, CreatedAt, LastLogin)
VALUES

(1, 'Jsf fsfsf', 'admin1@example.com', '1234567890', 'HASH_ADMIN_123', '1985-04-12', 'Male', 1, GETDATE(), GETDATE()),
(4, 'Linda Caregiver', 'caregiver1@example.com', '6789012345', 'HASH_CARE_123', '1992-03-05', 'Female', 1, GETDATE(), GETDATE()),
(4, 'Robert Caretaker', 'caretaker1@example.com', '7890123456', 'HASH_TAKE_123', '1980-11-30', 'Male', 1, GETDATE(), NULL);


   INSERT INTO Users
        (RoleID, FullName, Email, Phone, PasswordHash,
         DateOfBirth, Gender, IsActive, CreatedAt, LastLogin)
        OUTPUT INSERTED.UserID
        VALUES
        (4, 'asf jfnkjaf fasfjk', 'afkmkasd@gmail.com', '234232423', '234234234','1920-11-30', 'Male', 1, GETDATE(), NULL);
     
     
     ALTER TABLE Users
ADD address NVARCHAR(200) NULL;

DELETE FROM Users WHERE UserID = 26;


SELECt * FROM MedicationSchedules;

INSERT INTO Users (RoleID, FullName, Email, Phone, PasswordHash, DateOfBirth, Gender, address, IsActive)
VALUES 
(2, 'Dr. Alice Smith', 'alice.smith@example.com', '555-0101', 'hashed_password1', '1980-02-15', 'Female', '456 Health Ave', 1);

DECLARE @DoctorID1 INT = SCOPE_IDENTITY();

INSERT INTO Doctor (DoctorID, LicenseNumber, Specialization, Hospital)
VALUES (@DoctorID1, 'LIC1001', 'Pediatrics', 'Sunshine Clinic');

INSERT INTO Users (RoleID, FullName, Email, Phone, PasswordHash, DateOfBirth, Gender, address, IsActive)
VALUES 
(2, 'Dr. Robert Johnson', 'robert.johnson@example.com', '555-0202', 'hashed_password2', '1970-09-30', 'Male', '789 Wellness Rd', 1);

DECLARE @DoctorID2 INT = SCOPE_IDENTITY();

INSERT INTO Doctor (DoctorID, LicenseNumber, Specialization, Hospital)
VALUES (@DoctorID2, 'LIC1002', 'Dermatology', 'City Skin Center');

INSERT INTO Users (RoleID, FullName, Email, Phone, PasswordHash, DateOfBirth, Gender, address, IsActive)
VALUES 
(2, 'Dr. Emily Davis', 'emily.davis@example.com', '555-0303', 'hashed_password3', '1985-07-22', 'Female', '321 Care Blvd', 1);

DECLARE @DoctorID3 INT = SCOPE_IDENTITY();

INSERT INTO Doctor (DoctorID, LicenseNumber, Specialization, Hospital)
VALUES (@DoctorID3, 'LIC1003', 'Orthopedics', 'Downtown Hospital');

select * from doctor;

ALTER TABLE EmergencyContacts
DROP COLUMN ADDRelationship;

SELECT * FROM Complaints;
SELECT * FROM SOSlogs;

ALTER TABLE EmergencyContacts
ADD IsPrimary BIT DEFAULT 0,
Relationship varchar(100) NUll;

SELECT name FROM sys.tables;

SELECT * FROM ELders;
DELETE FROM locationtrack WHERE LocationID = 1011;

SELECT *FROM locationtrack;

SELECT * FROM UserDevices;

SELECT * FROM MedicationAdherence ORDER BY AdherenceID DESC;

SELECT * FROM  Medications;
SELECT * FROM  MedicationSchedules;

select * from EmergencyContacts;

SELECT *  FROM MedicationAdherence;


-- Only ONE primary contact per elder
CREATE UNIQUE INDEX UX_EmergencyContacts_Primary
ON EmergencyContacts (ElderID)
WHERE IsPrimary = 1;

select * FROM UserDevices;

DROP TABLE SOS;

SELECT * FROM  MedicationAdherence;

SELECT * FROM VitalTypes;

ALTER TABLE VitalTypes
DROP COLUMN HasTwoValues;

SELECT * FROM UserLogins;
ALTER TABLE VitalTypes
DROP CONSTRAINT DF__VitalType__HasTw__5CD6CB2B;

ALTER TABLE VitalTypes
DROP COLUMN HasTwoValues;

SELECT * FROM VitalRecords;
SELECT * FROM Messages;

   
     ALTER TABLE Users
ADD Timezone VARCHAR(100) NULL;


SELECT *  FROM  AppointmentReminders;
SELECT *  FROM  Appointments;

INSERT INTO Appointments (
    ElderID,
    DoctorName,
    Title,
    Location,
    Notes,
    AppointmentDate,
    AppointmentTime,
    RecordedAt
)
VALUES (
    224, -- ElderID
    'Dr. Smith', -- DoctorName
    'Routine Checkup', -- Title
    'Clinic A', -- Location
    'Patient reports no issues.', -- Notes
    '2024-03-10', -- AppointmentDate
    '14:30', -- AppointmentTime in HH:MM format
    GETDATE() -- RecordedAt (current date and time)
);


1

SELECT * FROM MoodTypes;

SELECT * FROM SemanticIndexQueue;

SELECT * FROM ElderAdditionalInfo;

SELECT * FROM ElderForm;
ALTER TABLE CheckInRuns
ADD WindowType NVARCHAR(20) NULL,   -- Morning / Night
    LocalDate DATE NULL;

CREATE UNIQUE INDEX UX_CheckInRuns_Elder_Window_LocalDate
ON CheckInRuns(ElderID, WindowType, LocalDate);

UPDATE Users
SET Timezone = 'IST +05:00'
WHERE UserID = 1312;



UPDATE Users
SET PasswordHash = '$2y$10$.ZidhHFjx8VaZEWuDjKX/.1nsh6ef.enVbZRFJLkaDl/E2Otek0f6'
WHERE UserID = 293;

select * FROM CheckInSchedules;
SELECT * FROM CheckInRuns;
SELECT * FROM ChatThreads;
SELECT * FROM ChatMessages;


INSERT INTO CheckInSchedules (ElderID, ScheduleName, LocalDate, LocalTime, IsActive, CreatedAt)
VALUES (224, 'Morning', '2026-03-17', '07:00', 1, SYSUTCDATETIME());

ALTER TABLE CheckInSchedules
ADD LocalDate DATE NULL;

ALTER TABLE CheckInRuns
DROP CONSTRAINT FK_CheckInRuns_Schedule;
GO

ALTER TABLE CheckInRuns
DROP CONSTRAINT FK_CheckInRuns_Schedule;
GO
DROP TABLE CheckInSchedules;

DROP TABLE IF EXISTS CheckInRuns;
GO
ALTER TABLE ChatThreads
DROP CONSTRAINT FK_ChatThreads_Run;

SELECT * FROM carereports WHERE ElderID = 224;

SELECT * FROM carereports;