SELECT * from Roles;
SELECT * from VitalTypes;



SELECT * from Users;




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
        