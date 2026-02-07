SELECT * from Roles;
SELECT * from VitalTypes;



SELECT * from Users;
select * from CareRelationships;

SELECT * from ElderProfiles;
SELECT * from UserLogins;
ALTER TABLE ElderProfiles
ADD  Pasrsurgeries NVARCHAR(MAX);

;
EXEC sp_rename 'ElderProfiles.Pasrsurgeries', 'Pastsurgeries', 'COLUMN';



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



ALTER TABLE EmergencyContacts
DROP COLUMN ADDRelationship;


ALTER TABLE EmergencyContacts
ADD IsPrimary BIT DEFAULT 0,
Relationship varchar(100) NUll;


