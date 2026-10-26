/* =========================================================
   SOFTWARE MANAGEMENT DATABASE SYSTEM
   DBMS PROJECT
   ========================================================= */

USE SoftwareManagementDB;

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
