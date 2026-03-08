SELECT * from Roles;
SELECT * from VitalTypes;
SELECT * FROM VitalRecords;
SELECT * FROM DOCTOR;

SELECT * from Users;
select * from CareRelationships;

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