select * from Users where RoleID=4;
select * from UserDevices
select * from LocationTrack;

select * from sys.tables;

select * FROM VitalRecords;
select * FROM Users;

select * from ElderProfiles;

select * from Appointments;

alter table Appointments
drop column AppointmentTime;


select * from SOSLogs;

delete from Appointments where AppointmentID = 2;

ALTER TABLE Appointments
DROP CONSTRAINT DF__Appointme__Recor__7C1A6C5A;

alter table Appointments
drop column RecordedAt;

alter table Appointments
add AppointmentTime TIME(0);

alter table Appointments
add RecordedAt DATETIME2 DEFAULT GETDATE();

select * from MedicationAdherence;
select * from Status;

select * from SOSLogs;
select * from LocationTrack;

UPDATE Roles
SET RoleName = 'Elder'
WHERE RoleID = 5;


select * from Roles;
select * from CareRelationships;
select * from Messages;

select * from Users;
UPDATE Users
SET Timezone = 'IST +05:30'
WHERE UserID = 223;

INSERT INTO Complaints (ComplainantID, Subject, Description)
VALUES (1366, 'App Lagging', 'The caregiver mobile app takes too long to load the dashboard.');

INSERT INTO Complaints (ComplainantID, Subject, Description)
VALUES (1355, 'Payment Issue', 'The caregiver monthly payment summary is showing incorrect values.');

INSERT INTO Complaints (ComplainantID, Subject, Description)
VALUES (1313, 'Incorrect Health Data', 'The blood pressure reading recorded today does not match the actual measurement.');

INSERT INTO Complaints (ComplainantID, Subject, Description)
VALUES (290, 'Login Error', 'The caregiver app sometimes shows invalid login even with the correct credentials.');

INSERT INTO Complaints (ComplainantID, Subject, Description)
VALUES (214, 'Appointment Missing', 'A scheduled doctor appointment is not visible in the appointments page.');

INSERT INTO Complaints (ComplainantID, Subject, Description)
VALUES (196, 'Medication Reminder Failure', 'Medication reminders are not triggering notifications on time.');

INSERT INTO Complaints (ComplainantID, Subject, Description)
VALUES (68, 'Profile Update Issue', 'Changes made to the elder profile are not saved properly.');

INSERT INTO Complaints (ComplainantID, Subject, Description)
VALUES (73, 'Slow Dashboard', 'Dashboard takes several seconds to load when opening the caregiver app.');

INSERT INTO Complaints (ComplainantID, Subject, Description)
VALUES (1311, 'Hydration Record Missing', 'The hydration record for today is not appearing in the elder dashboard.');

INSERT INTO Complaints (ComplainantID, Subject, Description)
VALUES (1302, 'Duplicate Notifications', 'The same medicine reminder notification is sent multiple times.');

INSERT INTO Complaints (ComplainantID, Subject, Description)
VALUES (297, 'Location Tracking Delay', 'The elder location on the caregiver app updates very slowly.');

INSERT INTO Complaints (ComplainantID, Subject, Description)
VALUES (223, 'Emergency Contact Error', 'An error occurs when adding a new emergency contact.');

INSERT INTO Complaints (ComplainantID, Subject, Description)
VALUES (210, 'Doctor Details Missing', 'Preferred doctor details are not displayed in the medical profile.');

INSERT INTO Complaints (ComplainantID, Subject, Description)
VALUES (208, 'App Crash', 'The caregiver application crashes when opening the reminders screen.');

INSERT INTO Complaints (ComplainantID, Subject, Description)
VALUES (111, 'Data Sync Issue', 'Health data entered on the caregiver app does not sync immediately.');