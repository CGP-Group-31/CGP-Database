select * from Users;
select * from UserDevices

select * from sys.tables;

select * FROM VitalRecords;
select * FROM Users;

select * from ElderProfiles;

select * from Appointments;

alter table Appointments
drop column AppointmentTime;

delete from Appointments where AppointmentID = 2;

ALTER TABLE Appointments
DROP CONSTRAINT DF__Appointme__Recor__7C1A6C5A;

alter table Appointments
drop column RecordedAt;

alter table Appointments
add AppointmentTime TIME(0);

alter table Appointments
add RecordedAt DATETIME2 DEFAULT GETDATE();