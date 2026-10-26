/* =========================================================
   SOFTWARE MANAGEMENT DATABASE SYSTEM
   DBMS PROJECT
   ========================================================= */

USE SoftwareManagementDB;

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
