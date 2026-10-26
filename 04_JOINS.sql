/* =========================================================
   SOFTWARE MANAGEMENT DATABASE SYSTEM
   DBMS PROJECT
   ========================================================= */

USE SoftwareManagementDB;

/* =========================================================
   7. INNER JOIN
   ========================================================= */


/* Projects with their clients */

SELECT
    p.Project_ID,
    p.Project_Name,
    c.Client_Name,
    c.Organization
FROM Project p
INNER JOIN Client c
    ON p.Client_ID = c.Client_ID;
/* =========================================================
   8. MULTIPLE TABLE JOIN
   ========================================================= */


/* Project + Client + Product */

SELECT
    p.Project_Name,
    c.Client_Name,
    sp.Product_Name,
    sp.Version
FROM Project p
JOIN Client c
    ON p.Client_ID = c.Client_ID
JOIN Software_Product sp
    ON p.Project_ID = sp.Project_ID;
/* =========================================================
   9. EMPLOYEE - TEAM JOIN
   ========================================================= */


/* Employees working in teams */

SELECT
    e.Employee_Name,
    t.Team_Name,
    p.Project_Name,
    pa.Role
FROM Project_Assignment pa
JOIN Employee e
    ON pa.Employee_ID = e.Employee_ID
JOIN Team t
    ON pa.Team_ID = t.Team_ID
JOIN Project p
    ON pa.Project_ID = p.Project_ID;
/* =========================================================
   10. SELF JOIN
   ========================================================= */


/* Employee and Team Lead relationship */

SELECT
    t.Team_Name,
    e.Employee_Name AS Team_Lead
FROM Team t
JOIN Employee e
    ON t.Team_Lead_ID = e.Employee_ID;
/* =========================================================
   11. LEFT JOIN
   ========================================================= */


/* Display all projects even if no product exists */

SELECT
    p.Project_Name,
    sp.Product_Name
FROM Project p
LEFT JOIN Software_Product sp
    ON p.Project_ID = sp.Project_ID;
/* =========================================================
   12. ISSUE JOIN
   ========================================================= */


/* Issues with project and assigned employee */

SELECT
    i.Issue_ID,
    i.Issue_Title,
    p.Project_Name,
    e.Employee_Name AS Assigned_Employee,
    i.Severity,
    i.Status
FROM Issue i
JOIN Project p
    ON i.Project_ID = p.Project_ID
JOIN Employee e
    ON i.Assigned_To = e.Employee_ID;
