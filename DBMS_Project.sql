/* =========================================================
   SOFTWARE MANAGEMENT DATABASE SYSTEM
   DBMS PROJECT
   ========================================================= */


/* =========================================================
   1. CREATE DATABASE
   ========================================================= */
DROP DATABASE IF EXISTS SoftwareManagementDB;
CREATE DATABASE SoftwareManagementDB;

USE SoftwareManagementDB;


/* =========================================================
   2. DDL - CREATE TABLES
   ========================================================= */


/* ---------------------------------------------------------
   ENTITY 1: CLIENT
   --------------------------------------------------------- */

CREATE TABLE Client (
    Client_ID INT PRIMARY KEY,
    Client_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Organization VARCHAR(100) NOT NULL
);


/* ---------------------------------------------------------
   ENTITY 2: EMPLOYEE
   --------------------------------------------------------- */

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Designation VARCHAR(50),
    Department VARCHAR(50),
    Date_Joined DATE,
    Status VARCHAR(20) DEFAULT 'Active'
);


/* ---------------------------------------------------------
   ENTITY 3: PROJECT
   --------------------------------------------------------- */

CREATE TABLE Project (
    Project_ID INT PRIMARY KEY,
    Project_Name VARCHAR(100) NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE,
    Status VARCHAR(30) NOT NULL,
    Budget DECIMAL(12,2),
    Client_ID INT NOT NULL,

    CONSTRAINT fk_project_client
        FOREIGN KEY (Client_ID)
        REFERENCES Client(Client_ID),

    CONSTRAINT chk_project_status
        CHECK (Status IN ('Planned', 'Active', 'Completed', 'On Hold')),

    CONSTRAINT chk_project_dates
        CHECK (End_Date IS NULL OR End_Date >= Start_Date)
);


/* ---------------------------------------------------------
   ENTITY 4: TEAM
   --------------------------------------------------------- */

CREATE TABLE Team (
    Team_ID INT PRIMARY KEY,
    Team_Name VARCHAR(100) NOT NULL,
    Project_ID INT NOT NULL,
    Team_Lead_ID INT,

    CONSTRAINT fk_team_project
        FOREIGN KEY (Project_ID)
        REFERENCES Project(Project_ID),

    CONSTRAINT fk_team_lead
        FOREIGN KEY (Team_Lead_ID)
        REFERENCES Employee(Employee_ID)
);


/* ---------------------------------------------------------
   ENTITY 5: SOFTWARE_PRODUCT
   --------------------------------------------------------- */

CREATE TABLE Software_Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100) NOT NULL,
    Version VARCHAR(20) NOT NULL,
    Product_Type VARCHAR(50),
    Release_Date DATE,
    Description VARCHAR(255),
    Status VARCHAR(30),
    Project_ID INT NOT NULL,

    CONSTRAINT fk_product_project
        FOREIGN KEY (Project_ID)
        REFERENCES Project(Project_ID)
);


/* ---------------------------------------------------------
   ENTITY 6: REQUIREMENT
   --------------------------------------------------------- */

CREATE TABLE Requirement (
    Requirement_ID INT PRIMARY KEY,
    Project_ID INT NOT NULL,
    Requirement_Title VARCHAR(150) NOT NULL,
    Description VARCHAR(255),
    Priority VARCHAR(20),
    Type VARCHAR(30),
    Status VARCHAR(30),
    Created_Date DATE,

    CONSTRAINT fk_requirement_project
        FOREIGN KEY (Project_ID)
        REFERENCES Project(Project_ID),

    CONSTRAINT chk_requirement_priority
        CHECK (Priority IN ('Low', 'Medium', 'High', 'Critical'))
);


/* ---------------------------------------------------------
   ENTITY 7: ISSUE
   --------------------------------------------------------- */

CREATE TABLE Issue (
    Issue_ID INT PRIMARY KEY,
    Issue_Title VARCHAR(150) NOT NULL,
    Description VARCHAR(255),
    Priority VARCHAR(20),
    Severity VARCHAR(20),
    Status VARCHAR(30),
    Reported_Date DATE,

    Project_ID INT NOT NULL,
    Requirement_ID INT,
    Reported_By INT NOT NULL,
    Assigned_To INT,

    CONSTRAINT fk_issue_project
        FOREIGN KEY (Project_ID)
        REFERENCES Project(Project_ID),

    CONSTRAINT fk_issue_requirement
        FOREIGN KEY (Requirement_ID)
        REFERENCES Requirement(Requirement_ID),

    CONSTRAINT fk_issue_reporter
        FOREIGN KEY (Reported_By)
        REFERENCES Employee(Employee_ID),

    CONSTRAINT fk_issue_assignee
        FOREIGN KEY (Assigned_To)
        REFERENCES Employee(Employee_ID)
);


/* ---------------------------------------------------------
   ENTITY 8: PROJECT_ASSIGNMENT
   ---------------------------------------------------------
   Junction table for Employee <-> Team M:N relationship
   --------------------------------------------------------- */

CREATE TABLE Project_Assignment (
    Assignment_ID INT PRIMARY KEY,
    Project_ID INT NOT NULL,
    Employee_ID INT NOT NULL,
    Team_ID INT NOT NULL,
    Role VARCHAR(50),
    Allocated_Date DATE,
    Hours_Per_Week INT,
    Status VARCHAR(30),

    CONSTRAINT fk_assignment_project
        FOREIGN KEY (Project_ID)
        REFERENCES Project(Project_ID),

    CONSTRAINT fk_assignment_employee
        FOREIGN KEY (Employee_ID)
        REFERENCES Employee(Employee_ID),

    CONSTRAINT fk_assignment_team
        FOREIGN KEY (Team_ID)
        REFERENCES Team(Team_ID),

    CONSTRAINT chk_hours
        CHECK (Hours_Per_Week BETWEEN 1 AND 60),

    CONSTRAINT uq_employee_team
        UNIQUE (Employee_ID, Team_ID)
);


/* =========================================================
   3. DML - INSERT SAMPLE DATA
   ========================================================= */


/* ---------------------------------------------------------
   CLIENT DATA
   --------------------------------------------------------- */

INSERT INTO Client
VALUES
(101, 'ABC Technologies', 'contact@abctech.com',
 '9876543210', 'ABC Technologies'),

(102, 'Global Solutions', 'info@globalsolutions.com',
 '9876543211', 'Global Solutions'),

(103, 'NextGen Systems', 'admin@nextgensystems.com',
 '9876543212', 'NextGen Systems'),

(104, 'Smart Industries', 'contact@smartindustries.com',
 '9876543213', 'Smart Industries');


/* ---------------------------------------------------------
   EMPLOYEE DATA
   --------------------------------------------------------- */

INSERT INTO Employee
VALUES
(201, 'Arjun Kumar', 'arjun@company.com',
 'Project Manager', 'Management', '2022-01-10', 'Active'),

(202, 'Priya Sharma', 'priya@company.com',
 'Software Developer', 'Development', '2023-02-15', 'Active'),

(203, 'Rahul Reddy', 'rahul@company.com',
 'Software Developer', 'Development', '2023-03-20', 'Active'),

(204, 'Sneha Rao', 'sneha@company.com',
 'Tester', 'Testing', '2023-04-10', 'Active'),

(205, 'Vikram Singh', 'vikram@company.com',
 'UI Designer', 'Design', '2022-07-12', 'Active'),

(206, 'Anjali Patel', 'anjali@company.com',
 'Software Developer', 'Development', '2024-01-20', 'Active'),

(207, 'Kiran Kumar', 'kiran@company.com',
 'DevOps Engineer', 'Operations', '2023-08-18', 'Active'),

(208, 'Meena Reddy', 'meena@company.com',
 'Tester', 'Testing', '2024-02-11', 'Active');


/* ---------------------------------------------------------
   PROJECT DATA
   --------------------------------------------------------- */

INSERT INTO Project
VALUES
(301, 'Banking Application', '2025-01-10',
 '2025-12-20', 'Active', 1500000.00, 101),

(302, 'E-Commerce Platform', '2025-02-15',
 '2025-11-30', 'Active', 1200000.00, 102),

(303, 'Healthcare Management', '2025-03-01',
 '2026-01-15', 'Completed', 1800000.00, 103),

(304, 'Inventory Management', '2025-04-10',
 NULL, 'Active', 900000.00, 104),

(305, 'Education Portal', '2025-06-01',
 NULL, 'Planned', 750000.00, 101);


/* ---------------------------------------------------------
   TEAM DATA
   --------------------------------------------------------- */

INSERT INTO Team
VALUES
(401, 'Backend Team', 301, 201),
(402, 'Frontend Team', 301, 202),
(403, 'Testing Team', 301, 204),
(404, 'Development Team', 302, 203),
(405, 'Testing Team 2', 302, 208),
(406, 'Healthcare Team', 303, 202),
(407, 'Inventory Team', 304, 206);


/* ---------------------------------------------------------
   SOFTWARE PRODUCT DATA
   --------------------------------------------------------- */

INSERT INTO Software_Product
VALUES
(501, 'Banking App', '1.0',
 'Mobile Application', '2025-06-15',
 'Online banking application', 'Released', 301),

(502, 'Banking App', '2.0',
 'Mobile Application', '2025-10-20',
 'Updated banking application', 'Development', 301),

(503, 'Shopping Portal', '1.0',
 'Web Application', '2025-07-10',
 'E-commerce web platform', 'Released', 302),

(504, 'Hospital System', '1.0',
 'Web Application', '2025-12-10',
 'Hospital management software', 'Released', 303),

(505, 'Inventory Pro', '1.0',
 'Desktop Application', NULL,
 'Inventory management software', 'Development', 304);


/* ---------------------------------------------------------
   REQUIREMENT DATA
   --------------------------------------------------------- */

INSERT INTO Requirement
VALUES
(601, 301, 'User Login',
 'Users should securely login', 'High',
 'Functional', 'Completed', '2025-01-15'),

(602, 301, 'Fund Transfer',
 'Users can transfer money', 'Critical',
 'Functional', 'In Progress', '2025-02-01'),

(603, 302, 'Product Search',
 'Users can search products', 'High',
 'Functional', 'Completed', '2025-03-01'),

(604, 302, 'Online Payment',
 'Users can make online payments', 'Critical',
 'Functional', 'In Progress', '2025-03-10'),

(605, 303, 'Patient Registration',
 'Register patient information', 'High',
 'Functional', 'Completed', '2025-03-15'),

(606, 304, 'Stock Tracking',
 'Track inventory stock', 'Medium',
 'Functional', 'In Progress', '2025-05-01'),

(607, 305, 'Student Login',
 'Students can login to portal', 'High',
 'Functional', 'Pending', '2025-06-05');


/* ---------------------------------------------------------
   ISSUE DATA
   --------------------------------------------------------- */

INSERT INTO Issue
VALUES
(701, 'Login Error',
 'Users cannot login',
 'High', 'Critical', 'Open',
 '2025-06-20', 301, 601, 204, 202),

(702, 'Payment Failure',
 'Payment transaction fails',
 'High', 'Critical', 'In Progress',
 '2025-07-05', 302, 604, 208, 203),

(703, 'Search Bug',
 'Search results are incorrect',
 'Medium', 'Major', 'Resolved',
 '2025-07-12', 302, 603, 208, 203),

(704, 'Patient Data Error',
 'Patient data validation issue',
 'High', 'Major', 'Open',
 '2025-08-01', 303, 605, 204, 202),

(705, 'Stock Update Error',
 'Stock quantity not updating',
 'Medium', 'Major', 'Open',
 '2025-08-10', 304, 606, 208, 206);


/* ---------------------------------------------------------
   PROJECT ASSIGNMENT DATA
   --------------------------------------------------------- */

INSERT INTO Project_Assignment
VALUES
(801, 301, 201, 401, 'Project Manager',
 '2025-01-10', 40, 'Active'),

(802, 301, 202, 402, 'Backend Developer',
 '2025-01-15', 40, 'Active'),

(803, 301, 203, 402, 'Backend Developer',
 '2025-01-15', 35, 'Active'),

(804, 301, 204, 403, 'Tester',
 '2025-02-01', 30, 'Active'),

(805, 302, 203, 404, 'Team Lead',
 '2025-02-15', 40, 'Active'),

(806, 302, 208, 405, 'Tester',
 '2025-03-01', 30, 'Active'),

(807, 303, 202, 406, 'Developer',
 '2025-03-01', 40, 'Completed'),

(808, 304, 206, 407, 'Developer',
 '2025-04-10', 40, 'Active'),

(809, 305, 205, 407, 'UI Designer',
 '2025-06-01', 25, 'Active');


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
   5. UPDATE - DML
   ========================================================= */

UPDATE Project
SET Status = 'Completed'
WHERE Project_ID = 304;


/* Update employee department */

UPDATE Employee
SET Department = 'Software Development'
WHERE Employee_ID = 206;


/* =========================================================
   6. DELETE - DML
   ========================================================= */

/*
   Example delete.
   Use only when the record is not referenced by FK records.

DELETE FROM Requirement
WHERE Requirement_ID = 607;
*/


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
   29. DDL - ALTER TABLE
   ========================================================= */


/* Add a new column */

ALTER TABLE Client
ADD Address VARCHAR(200);


/* =========================================================
   30. DDL - MODIFY COLUMN
   ========================================================= */

ALTER TABLE Employee
MODIFY Department VARCHAR(100);


/* =========================================================
   31. CREATE INDEX
   ========================================================= */

CREATE INDEX idx_project_status
ON Project(Status);

CREATE INDEX idx_issue_status
ON Issue(Status);

CREATE INDEX idx_employee_department
ON Employee(Department);


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


/* =========================================================
   END OF SOFTWARE MANAGEMENT DATABASE SYSTEM
   ========================================================= */