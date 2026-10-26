/* =========================================================
   SOFTWARE MANAGEMENT DATABASE SYSTEM
   DBMS PROJECT
   ========================================================= */

USE SoftwareManagementDB;

/* =========================================================
   14. GROUP BY
   ========================================================= */


/* Number of projects for each client */

SELECT
    c.Client_Name,
    COUNT(p.Project_ID) AS Total_Projects
FROM Client c
LEFT JOIN Project p
    ON c.Client_ID = p.Client_ID
GROUP BY c.Client_ID, c.Client_Name;


/* Number of issues per project */

SELECT
    p.Project_Name,
    COUNT(i.Issue_ID) AS Total_Issues
FROM Project p
LEFT JOIN Issue i
    ON p.Project_ID = i.Project_ID
GROUP BY p.Project_ID, p.Project_Name;
/* =========================================================
   15. HAVING
   ========================================================= */


/* Projects having more than one issue */

SELECT
    p.Project_Name,
    COUNT(i.Issue_ID) AS Issue_Count
FROM Project p
JOIN Issue i
    ON p.Project_ID = i.Project_ID
GROUP BY p.Project_ID, p.Project_Name
HAVING COUNT(i.Issue_ID) > 1;
/* =========================================================
   16. AGGREGATE + JOIN
   ========================================================= */


/* Total employees assigned to each project */

SELECT
    p.Project_Name,
    COUNT(DISTINCT pa.Employee_ID) AS Employee_Count
FROM Project p
LEFT JOIN Project_Assignment pa
    ON p.Project_ID = pa.Project_ID
GROUP BY p.Project_ID, p.Project_Name;
