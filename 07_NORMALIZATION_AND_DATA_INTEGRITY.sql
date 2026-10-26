/* =========================================================
   NORMALIZATION AND DATA INTEGRITY
   =========================================================

   This file documents the normalization and integrity features
   already implemented in the database schema.

   NORMALIZATION DESIGN
   --------------------
   The project separates CLIENT, EMPLOYEE, PROJECT, TEAM,
   SOFTWARE_PRODUCT, REQUIREMENT, ISSUE and PROJECT_ASSIGNMENT
   into individual entities. PROJECT_ASSIGNMENT acts as a junction
   table for the Employee <-> Team many-to-many relationship.

   DATA INTEGRITY FEATURES PRESENT IN THE SCHEMA
   ----------------------------------------------
   - PRIMARY KEY constraints identify each entity record.
   - FOREIGN KEY constraints maintain relationships between tables.
   - NOT NULL constraints prevent required fields from being empty.
   - UNIQUE constraints prevent duplicate values where required.
   - CHECK constraints restrict invalid status, priority, date and
     workload values.
   - DEFAULT on Employee.Status supplies 'Active' when omitted.

   The checks below are read-only and can be used to verify that
   the expected data exists after running the DDL and DML files.
   ========================================================= */

USE SoftwareManagementDB;

-- Primary entity counts
SELECT 'Client' AS Entity_Name, COUNT(*) AS Record_Count FROM Client
UNION ALL
SELECT 'Employee', COUNT(*) FROM Employee
UNION ALL
SELECT 'Project', COUNT(*) FROM Project
UNION ALL
SELECT 'Team', COUNT(*) FROM Team
UNION ALL
SELECT 'Software_Product', COUNT(*) FROM Software_Product
UNION ALL
SELECT 'Requirement', COUNT(*) FROM Requirement
UNION ALL
SELECT 'Issue', COUNT(*) FROM Issue
UNION ALL
SELECT 'Project_Assignment', COUNT(*) FROM Project_Assignment;

-- Check for orphan projects (should return zero rows)
SELECT p.Project_ID
FROM Project p
LEFT JOIN Client c ON p.Client_ID = c.Client_ID
WHERE c.Client_ID IS NULL;

-- Check for orphan requirements (should return zero rows)
SELECT r.Requirement_ID
FROM Requirement r
LEFT JOIN Project p ON r.Project_ID = p.Project_ID
WHERE p.Project_ID IS NULL;

-- Check for invalid project date relationships (should return zero rows)
SELECT Project_ID, Start_Date, End_Date
FROM Project
WHERE End_Date IS NOT NULL AND End_Date < Start_Date;

-- Check for invalid assignment hours (should return zero rows)
SELECT Assignment_ID, Hours_Per_Week
FROM Project_Assignment
WHERE Hours_Per_Week NOT BETWEEN 1 AND 60;
