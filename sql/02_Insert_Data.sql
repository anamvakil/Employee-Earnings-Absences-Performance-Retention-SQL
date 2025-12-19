----Load Time Dimension
INSERT INTO Calendar (CalendarYear, Quarter, MonthOfAbsence, DayOfWeek, Season)
SELECT DISTINCT
    calendar_year,
    quarter,
    [Month_of_absence],
    [Day_of_the_week],
    Seasons
FROM EmployeeEarningsRaw;

--------------------
---Load Absence Dimension

INSERT INTO Absence (Reason)
SELECT DISTINCT 
    [Reason_for_absence]
FROM EmployeeEarningsRaw
WHERE [Reason_for_absence] IS NOT NULL;

---------------------------------------------


----- Load Employee Dimension

INSERT INTO Employee (
    PublicID, FirstName, LastName, EmployeeCategory, CompulsoryUnionCode,
    TerminationMonth, TerminationYear, DepartmentID, JobCode
)
SELECT 
    r.public_id,
    r.first_name,
    r.last_name,
    r.employee_category,
    r.compulsory_union_code,
    r.termination_month,
    r.termination_year,
    d.DepartmentID,
    r.job_code
FROM EmployeeEarningsRaw r
JOIN Department d
    ON r.department_number = d.DepartmentNumber;

-----------------
-------Load Fact Table (Earnings)

TRUNCATE TABLE Earnings;

INSERT INTO Earnings (
    EmployeeID, CalendarID, AbsenceID,
    OvertimeGrossPay, BaseGrossPay, LongevityGrossPay,
    PostSeparationGrossPay, MiscellaneousGrossPay
)
SELECT
    e.EmployeeID,
    c.CalendarID,
    a.AbsenceID,
    r.overtime_gross_pay_qtd,
    r.base_gross_pay_qtd,
    r.longevity_gross_pay_qtd,
    r.post_separation_gross_pay_qtd,
    r.miscellaneous_gross_pay_qtd
FROM EmployeeEarningsRaw r
JOIN Employee e ON r.public_id = e.PublicID
JOIN Calendar c 
    ON c.CalendarYear = r.calendar_year
    AND c.Quarter = r.quarter
    AND c.MonthOfAbsence = r.[Month_of_absence]
    AND c.DayOfWeek = r.[Day_of_the_week]
    AND c.Season = r.Seasons
LEFT JOIN Absence a ON a.Reason = r.[Reason_for_absence];
------------------------------------------------
SELECT COUNT(*) AS DeptCount   FROM Department;
SELECT COUNT(*) AS JobCount    FROM Job;
SELECT COUNT(*) AS CalCount    FROM Calendar;
SELECT COUNT(*) AS AbsCount    FROM Absence;
SELECT COUNT(*) AS EmpCount    FROM Employee;
SELECT COUNT(*) AS FactCount   FROM Earnings;
--------------------------------