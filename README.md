SOFTWARE MANAGEMENT DATABASE SYSTEM
===================================

Files are divided from the original SQL project into logical sections.

Execution order:
00_RUN_ALL.sql (or run 01 through 09 manually)

01_DDL_COMMANDS.sql
  Database creation, table creation, ALTER TABLE and indexes.

02_DML_COMMANDS.sql
  INSERT, UPDATE and DELETE commands.

03_DQL_COMMANDS.sql
  Basic SELECT, CASE and subqueries.

04_JOINS.sql
  INNER JOIN, multiple-table JOIN, employee/team JOIN, self JOIN,
  LEFT JOIN and issue JOIN.

05_AGGREGATE_FUNCTIONS.sql
  COUNT, SUM, AVG, MAX and MIN.

06_GROUP_BY_HAVING.sql
  GROUP BY, HAVING and aggregate + JOIN.

07_NORMALIZATION_AND_DATA_INTEGRITY.sql
  Documents the normalization/integrity design and provides read-only checks.

08_DATA_INTEGRITY_TEST_AND_VIEW_IMPLEMENTATION.sql
  The three VIEW definitions and their display queries.

09_DATABASE_VERIFICATION.sql
  Reports/verification queries plus SHOW TABLES and DESCRIBE commands.

NOTE: The original SQL logic is preserved and divided by topic. The normalization/integrity file adds only non-destructive verification queries and documentation; it does not alter the original schema.
