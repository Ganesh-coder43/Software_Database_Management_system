/* =========================================================
   SOFTWARE MANAGEMENT DATABASE SYSTEM
   DBMS PROJECT
   ========================================================= */

USE SoftwareManagementDB;

/* =========================================================
   4. BASIC SELECT QUERIES
   ========================================================= */


/* Display all projects */

SELECT *
FROM Project;


/* Display selected columns */

SELECT Project_ID, Project_Name, Status
FROM Project;


/* DISTINCT */

SELECT DISTINCT Status
FROM Project;


/* WHERE */

SELECT *
FROM Project
WHERE Status = 'Active';


/* ORDER BY */

SELECT *
FROM Project
ORDER BY Budget DESC;


/* BETWEEN */

SELECT *
FROM Project
WHERE Budget BETWEEN 900000 AND 1500000;


/* LIKE */

SELECT *
FROM Employee
WHERE Employee_Name LIKE 'A%';


/* IN */

SELECT *
FROM Project
WHERE Status IN ('Active', 'Completed');
/* =========================================================
   17. CASE STATEMENT
   ========================================================= */

SELECT
    Project_Name,
    Budget,
    CASE
        WHEN Budget >= 1500000 THEN 'High Budget'
        WHEN Budget >= 1000000 THEN 'Medium Budget'
        ELSE 'Low Budget'
    END AS Budget_Category
FROM Project;
/* =========================================================
   18. SUBQUERY
   ========================================================= */


/* Projects with budget greater than average */

SELECT
    Project_Name,
    Budget
FROM Project
WHERE Budget >
(
    SELECT AVG(Budget)
    FROM Project
);
/* =========================================================
   19. ANOTHER SUBQUERY
   ========================================================= */


/* Employees assigned to Banking Application */

SELECT Employee_Name
FROM Employee
WHERE Employee_ID IN
(
    SELECT Employee_ID
    FROM Project_Assignment
    WHERE Project_ID =
    (
        SELECT Project_ID
        FROM Project
        WHERE Project_Name = 'Banking Application'
    )
);
