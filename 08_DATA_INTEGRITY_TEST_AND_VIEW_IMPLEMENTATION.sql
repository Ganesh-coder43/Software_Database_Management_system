/* =========================================================
   SOFTWARE MANAGEMENT DATABASE SYSTEM
   DBMS PROJECT
   ========================================================= */

USE SoftwareManagementDB;

/* =========================================================
   20. VIEW 1
   ========================================================= */


/* Project details with client */

CREATE VIEW Project_Client_View AS
SELECT
    p.Project_ID,
    p.Project_Name,
    c.Client_Name,
    c.Organization,
    p.Start_Date,
    p.End_Date,
    p.Status,
    p.Budget
FROM Project p
JOIN Client c
    ON p.Client_ID = c.Client_ID;


/* Display View */

SELECT *
FROM Project_Client_View;
/* =========================================================
   21. VIEW 2
   ========================================================= */


/* Employee assignment view */

CREATE VIEW Employee_Project_View AS
SELECT
    e.Employee_ID,
    e.Employee_Name,
    p.Project_Name,
    t.Team_Name,
    pa.Role,
    pa.Hours_Per_Week,
    pa.Status
FROM Project_Assignment pa
JOIN Employee e
    ON pa.Employee_ID = e.Employee_ID
JOIN Project p
    ON pa.Project_ID = p.Project_ID
JOIN Team t
    ON pa.Team_ID = t.Team_ID;


/* Display View */

SELECT *
FROM Employee_Project_View;
/* =========================================================
   22. VIEW 3
   ========================================================= */


/* Issue management view */

CREATE VIEW Issue_Management_View AS
SELECT
    i.Issue_ID,
    i.Issue_Title,
    p.Project_Name,
    r.Requirement_Title,
    reporter.Employee_Name AS Reported_By,
    assignee.Employee_Name AS Assigned_To,
    i.Severity,
    i.Priority,
    i.Status,
    i.Reported_Date
FROM Issue i

JOIN Project p
    ON i.Project_ID = p.Project_ID

LEFT JOIN Requirement r
    ON i.Requirement_ID = r.Requirement_ID

JOIN Employee reporter
    ON i.Reported_By = reporter.Employee_ID

LEFT JOIN Employee assignee
    ON i.Assigned_To = assignee.Employee_ID;


/* Display View */

SELECT *
FROM Issue_Management_View;
