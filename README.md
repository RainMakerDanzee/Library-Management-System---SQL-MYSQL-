# Library Management System---SQL-MYSQL

Project Description
This SQL project demonstrates the creation and management of a robust database system for a library. The project involves designing a relational database schema with multiple interconnected tables, managing data integrity through constraints, and implementing advanced SQL features such as triggers and stored procedures to enforce business rules. This project is designed to showcase advanced SQL skills, including database design, data manipulation, and the implementation of business logic within the database layer. It is a testament to my capability in handling complex data systems and my proficiency in SQL.

# Features
Database Design: Creation of a comprehensive library database schema with tables for Branch, Member, Publisher, Book, Author, Authoredby, Holding, and Borrowedby.
Data Integrity: Implementation of primary keys, foreign keys, and constraints to maintain data accuracy and consistency.
Business Rule Enforcement: Use of triggers and stored procedures to enforce various business rules like membership status updates, borrowing limits, fine calculations, and overdue item handling.
Advanced SQL Operations: Demonstrates complex SQL operations including joins, subqueries, aggregate functions, and date functions.

### Tables and Relationships
Branch, Member, Publisher, Book, Author: Core entities representing the library's branches, members, publishers, books, and authors.
Authoredby, Holding, Borrowedby: Associative tables managing the relationships between books and authors, books' availability in branches, and books' borrowing details.

### Constraints and Triggers
Check constraints: To ensure valid data entry (e.g., stock count should not be less than the number of books on loan).
Triggers: For automating tasks such as updating member status based on borrowing behavior, tracking membership changes, enforcing borrowing limits, and ensuring return dates are within membership validity.

### Stored Procedures:
Implementing procedures to manage complex operations like terminating overdue memberships and handling exceptions.

### Test Scenarios
Detailed test cases to validate the functionality of triggers, stored procedures, and data integrity constraints.


