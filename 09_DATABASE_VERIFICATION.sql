/* =========================================================
   SOFTWARE MANAGEMENT DATABASE SYSTEM
   DBMS PROJECT
   ========================================================= */

USE SoftwareManagementDB;

/* =========================================================
   23. REQUIREMENTS AND ISSUES
   ========================================================= */


/* Requirements with number of issues */

SELECT
    r.Requirement_ID,
    r.Requirement_Title,
    COUNT(i.Issue_ID) AS Issue_Count
FROM Requirement r
LEFT JOIN Issue i
    ON r.Requirement_ID = i.Requirement_ID
GROUP BY
    r.Requirement_ID,
    r.Requirement_Title;
/* =========================================================
   24. PROJECT STATUS REPORT
   ========================================================= */

SELECT
    Status,
    COUNT(*) AS Number_of_Projects,
    SUM(Budget) AS Total_Budget,
    AVG(Budget) AS Average_Budget
FROM Project
GROUP BY Status;
/* =========================================================
   25. EMPLOYEE WORKLOAD REPORT
   ========================================================= */

SELECT
    e.Employee_Name,
    COUNT(pa.Assignment_ID) AS Project_Assignments,
    SUM(pa.Hours_Per_Week) AS Total_Hours_Per_Week
FROM Employee e
LEFT JOIN Project_Assignment pa
    ON e.Employee_ID = pa.Employee_ID
GROUP BY
    e.Employee_ID,
    e.Employee_Name
ORDER BY Total_Hours_Per_Week DESC;
/* =========================================================
   26. ISSUE SEVERITY REPORT
   ========================================================= */

SELECT
    Severity,
    COUNT(*) AS Number_of_Issues
FROM Issue
GROUP BY Severity
ORDER BY Number_of_Issues DESC;
/* =========================================================
   27. HIGH PRIORITY REQUIREMENTS
   ========================================================= */

SELECT
    p.Project_Name,
    r.Requirement_Title,
    r.Priority,
    r.Status
FROM Requirement r
JOIN Project p
    ON r.Project_ID = p.Project_ID
WHERE r.Priority IN ('High', 'Critical')
ORDER BY r.Priority;
/* =========================================================
   28. PROJECTS WITH NO COMPLETED END DATE
   ========================================================= */

SELECT
    Project_Name,
    Status,
    Start_Date
FROM Project
WHERE End_Date IS NULL;
/* =========================================================
   32. SHOW TABLES
   ========================================================= */

SHOW TABLES;
/* =========================================================
   33. DESCRIBE TABLE
   ========================================================= */

DESCRIBE Project;

DESCRIBE Employee;

DESCRIBE Issue;
