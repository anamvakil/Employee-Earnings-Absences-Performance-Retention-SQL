# Employee Earnings, Absences, Performance & Retention Analysis  
## SQL Server | Multidimensional Modeling (Star Schema)

This project implements a complete **SQL-based analytical workflow** to evaluate employee earnings, absenteeism, departmental performance, and retention trends. The solution was developed entirely in **SQL Server Management Studio (SSMS)**, transforming raw flat files into a structured, analytical database using **normalization and star schema design**.

The project demonstrates how database-driven analytics can support workforce planning and organizational decision-making without the use of external BI tools.

---

## Project Objective

To design, implement, and analyze a relational database that enables multi-dimensional analysis of:
- Employee absences
- Earnings performance
- Department-level productivity
- Retention and turnover patterns

All data preparation, modeling, and analysis were executed using SQL.

---

## Data Sources

- City Employee Earnings dataset (City of Philadelphia)
- UCI Absenteeism at Work dataset

The datasets were combined for demonstration purposes to simulate a real-world organizational scenario involving earnings, attendance, and retention.

---

## Data Modeling Approach

The database design follows a **star-schema-style analytical model**, optimized for reporting and aggregation.

### Fact Table
**Earnings**
- Stores measurable payroll components
- Links employee, department, job, calendar, and absence data
- Serves as the central table for analytical queries

Key measures include:
- Base gross pay
- Overtime gross pay
- Longevity and miscellaneous pay
- Absence-related earnings impact

---

### Dimension Tables
- **Employee** – employee attributes, category, and termination details
- **Department** – department identifiers and names
- **Job** – job title, salary type, and base salary
- **Calendar** – year, quarter, month, season, and day attributes
- **Absence** – absence reasons and descriptions

This structure supports slicing and aggregation across time, departments, and employee groups.

---

## Normalization Strategy

The original flat file was normalized to **Third Normal Form (3NF)** prior to analytical modeling:

- Atomic values enforced (1NF)
- Partial dependencies removed (2NF)
- Transitive dependencies eliminated (3NF)

Normalization improved data quality, reduced redundancy, and ensured referential integrity before analytical processing.

---

## Key SQL Features Implemented

- Primary and foreign key constraints
- UNIQUE, CHECK, and DEFAULT constraints
- Aggregations and GROUP BY analysis
- JOINs across fact and dimension tables
- Window functions (DENSE_RANK)
- Common Table Expressions (CTEs)
- Stored procedures for payroll calculations
- Triggers for automated payroll adjustments
- Non-clustered indexing for performance optimization

---

## Analytical Use Cases

- Identifying employees with the highest absenteeism
- Evaluating seasonal absence patterns
- Analyzing the relationship between absences and earnings
- Comparing departmental performance
- Assessing retention and turnover trends
- Ranking employees by absence behavior within departments

---


---

## Key Insights

- High absenteeism is strongly associated with reduced earnings
- Absence behavior follows seasonal patterns
- Departments vary significantly in earnings and retention
- Normalization and indexing substantially improved query performance
- Advanced SQL features enabled automation and deeper analytics

---

## Contribution Note

This was a **group academic project**.  
My primary contributions included:
- Designing the normalized and star schema database model
- Creating fact and dimension tables
- Implementing constraints, indexes, and relationships
- Writing analytical SQL queries
- Developing stored procedures and triggers
- Contributing to technical documentation and analysis

---

This project demonstrates applied data warehousing, SQL analytics, and multidimensional modeling concepts using real-world workforce data.


