# Star Schema – Employee Absenteeism and Earnings Analysis

This document describes the **multidimensional star schema** designed for the *Employee Earnings, Absences, Performance, and Retention* analysis project.  
The schema supports analytical querying and reporting on workforce behavior using SQL Server.

---

## Star Schema Diagram

![Employee Absenteeism Star Schema](employee_absenteeism_star_schema.png)

<img width="1332" height="759" alt="image" src="https://github.com/user-attachments/assets/c2ea5460-2b51-46fc-9a66-6736024cf762" />

<img width="511" height="361" alt="image" src="https://github.com/user-attachments/assets/d3357c6d-1408-4bff-b201-6728979ca9e3" />

<img width="507" height="352" alt="image" src="https://github.com/user-attachments/assets/b37170df-5210-4423-82c3-749b3e33a3de" />




---

## Design Overview

The database is modeled using a **star schema** to enable efficient analytical queries.  
It consists of a central **fact table** that captures measurable events, surrounded by multiple **dimension tables** that provide descriptive context.

This design is optimized for:
- Aggregation and reporting
- Time-based trend analysis
- Departmental and employee-level insights
- Workforce performance and retention analysis

---

## Fact Table

### `Earnings`
The fact table captures quantitative payroll and attendance-related measures.

Key characteristics:
- Stores earnings components for each employee event
- Links to all dimension tables via foreign keys
- Supports aggregation across time, department, job, and absence attributes

Typical measures include:
- Base gross pay  
- Overtime gross pay  
- Longevity and miscellaneous pay  
- Post-separation earnings  

---

## Dimension Tables

### `Employee`
Contains descriptive employee information:
- Employee identifiers
- Category and union attributes
- Termination month and year

---

### `Department`
Stores department-level attributes:
- Department identifiers
- Department name and number
- Enables department-level performance analysis

---

### `Job`
Stores job-related attributes:
- Job code and title
- Salary type and base salary
- Ensures consistency in job classification

---

### `Calendar`
Provides time-based attributes for analysis:
- Year, quarter, month
- Day of week and season
- Enables seasonal and temporal trend analysis

---

### `Absence`
Stores absence-related information:
- Absence reason codes
- Descriptive absence details
- Supports analysis of attendance impact on earnings

---

## Relationship Design

- All dimension tables have **one-to-many** relationships with the fact table
- Foreign key constraints enforce referential integrity
- The schema supports multi-dimensional slicing without complex joins

---

## Modeling Rationale

- Star schema simplifies analytical queries compared to fully normalized OLTP designs
- Separating descriptive attributes into dimensions improves readability and performance
- The fact table focuses solely on measurable business events
- The model aligns with data warehousing and BI best practices

---

## Related Components

- SQL Scripts: See `/sql/`  
- Project Report: See `/report/Employee_Absenteeism_SQL_Analysis.pdf`

---

This ERD serves as the structural foundation for all analytical queries and insights derived in this project.

