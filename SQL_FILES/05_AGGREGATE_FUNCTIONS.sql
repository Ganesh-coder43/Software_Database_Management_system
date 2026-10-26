/* =========================================================
   SOFTWARE MANAGEMENT DATABASE SYSTEM
   DBMS PROJECT
   ========================================================= */

USE SoftwareManagementDB;

/* =========================================================
   13. AGGREGATE FUNCTIONS
   ========================================================= */


/* COUNT */

SELECT COUNT(*) AS Total_Projects
FROM Project;


/* SUM */

SELECT SUM(Budget) AS Total_Project_Budget
FROM Project;


/* AVG */

SELECT AVG(Budget) AS Average_Project_Budget
FROM Project;


/* MAX */

SELECT MAX(Budget) AS Highest_Project_Budget
FROM Project;


/* MIN */

SELECT MIN(Budget) AS Lowest_Project_Budget
FROM Project;
