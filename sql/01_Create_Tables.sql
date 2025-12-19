CREATE DATABASE Project_Team6;
GO
USE Project_Team6;
GO

USE Project_Team6;
GO


--------------------------------------------------
----Create Dimension Tables (SQL Server)

-- 1. Department Dimension
CREATE TABLE Department (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentNumber INT,
    DepartmentName NVARCHAR(100)
);

-- 2. Job Dimension
CREATE TABLE Job (
    JobCode NVARCHAR(50) PRIMARY KEY,
    Title NVARCHAR(150),
    SalaryType NVARCHAR(50),
    BaseSalary FLOAT
);

-- 3. Calendar Dimension
CREATE TABLE Calendar (
    CalendarID INT IDENTITY(1,1) PRIMARY KEY,
    CalendarYear INT,
    Quarter INT,
    MonthOfAbsence TINYINT,
    DayOfWeek NVARCHAR(20),
    Season NVARCHAR(20)
);

-- 4. Absence Dimension
CREATE TABLE Absence (
    AbsenceID INT IDENTITY(1,1) PRIMARY KEY,
    Reason NVARCHAR(200)
);

-- 5. Employee Dimension
CREATE TABLE Employee (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    PublicID INT,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    EmployeeCategory NVARCHAR(50),
    CompulsoryUnionCode NVARCHAR(50),
    TerminationMonth TINYINT,
    TerminationYear INT,
    DepartmentID INT,
    JobCode NVARCHAR(50),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (JobCode) REFERENCES Job(JobCode)
);

-----------------------------

-----Create Fact Table

CREATE TABLE Earnings (
    EarningsID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    CalendarID INT,
    AbsenceID INT NULL,
    OvertimeGrossPay FLOAT,
    BaseGrossPay FLOAT,
    LongevityGrossPay FLOAT,
    PostSeparationGrossPay FLOAT,
    MiscellaneousGrossPay FLOAT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (CalendarID) REFERENCES Calendar(CalendarID),
    FOREIGN KEY (AbsenceID) REFERENCES Absence(AbsenceID)
);

-- UNIQUE CONSTRAINT
-- Makes sure each JobCode–Title combination appears only once.
-- This prevents duplicate job entries while still allowing
-- the same job title to exist under different job codes.
-- Example:
--   (6A02, 'Police Officer1') → allowed
--   (6A03, 'Police Officer1') → allowed
--   (6A02, 'Police Officer1') → NOT allowed (duplicate)

ALTER TABLE Job
ADD CONSTRAINT UQ_Job_JobCode_Title UNIQUE (JobCode, Title);

SELECT * FROM Job



-- CHECK CONSTRAINTS
-- Quarter must be between 1 and 4.
-- store the quarter because payroll and attendance
-- are often analyzed by quarter (Q1, Q2, Q3, Q4).
-- A quarter is just a 3-month period in a year, and
-- having this value saved makes reporting and analytics easier.

ALTER TABLE Calendar
ADD CONSTRAINT CK_Calendar_Quarter CHECK (Quarter BETWEEN 1 AND 4);

SELECT * FROM Calendar

-- TerminationMonth must be 1–12 or NULL.
-- This makes sure the month is valid (Jan to Dec).
-- If the employee has not left the job yet, the value stays NULL.
ALTER TABLE Employee
ADD CONSTRAINT CK_Employee_TermMonth CHECK 
(TerminationMonth BETWEEN 1 AND 12 OR TerminationMonth IS NULL);

SELECT * FROM Employee


-- Fix negative payroll values:
-- Any negative amount is replaced with 0 because
-- payroll numbers should never be negative.
UPDATE Earnings
SET 
  BaseGrossPay = CASE WHEN BaseGrossPay < 0 THEN 0 ELSE BaseGrossPay END,
  OvertimeGrossPay = CASE WHEN OvertimeGrossPay < 0 THEN 0 ELSE OvertimeGrossPay END,
  LongevityGrossPay = CASE WHEN LongevityGrossPay < 0 THEN 0 ELSE LongevityGrossPay END,
  PostSeparationGrossPay = CASE WHEN PostSeparationGrossPay < 0 THEN 0 ELSE PostSeparationGrossPay END,
  MiscellaneousGrossPay = CASE WHEN MiscellaneousGrossPay < 0 THEN 0 ELSE MiscellaneousGrossPay END;

  SELECT * FROM Earnings


-- Ensures all payroll values stay non-negative 
-- in the future (Stops negative values from 
-- being inserted or updated)
ALTER TABLE Earnings
ADD CONSTRAINT CK_Earnings_Positive CHECK (
    BaseGrossPay >= 0 AND
    OvertimeGrossPay >= 0 AND
    LongevityGrossPay >= 0 AND
    PostSeparationGrossPay >= 0 AND
    MiscellaneousGrossPay >= 0
);

--test the constraint
INSERT INTO Earnings (
    EmployeeID, CalendarID, AbsenceID,
    OvertimeGrossPay, BaseGrossPay, LongevityGrossPay,
    PostSeparationGrossPay, MiscellaneousGrossPay
)
VALUES (1, 1, NULL, 50, 200, 10, 0, 25);

--for negativer value
INSERT INTO Earnings (
    EmployeeID, CalendarID, AbsenceID,
    OvertimeGrossPay, BaseGrossPay, LongevityGrossPay,
    PostSeparationGrossPay, MiscellaneousGrossPay
)
VALUES (1, 1, NULL, 50, -200, 10, 0, 25);


UPDATE Earnings
SET BaseGrossPay = -10
WHERE EarningsID = 1;


-- DEFAULT CONSTRAINT
-- If EmployeeCategory is missing, set it to 'Unknown'
-- so we never have empty values in this column.
ALTER TABLE Employee
ADD CONSTRAINT DF_Employee_Category DEFAULT 'Unknown' FOR EmployeeCategory;

SELECT * FROM Employee WHERE EmployeeCategory = 'Unknown';

-- DEFAULT CONSTRAINT:
-- If no BaseSalary is provided for a job,
-- automatically set it to 0.
ALTER TABLE Job
ADD CONSTRAINT DF_Job_BaseSalary DEFAULT 0 FOR BaseSalary;

SELECT * FROM Job WHERE BaseSalary = 0