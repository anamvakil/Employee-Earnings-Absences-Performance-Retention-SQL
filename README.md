# Employee-Absenteeism-Analysis

# Employee Absenteeism Analysis  
## Multidimensional Modeling (Star Schema)

This project focuses on designing and implementing a **multidimensional data model** to analyze employee absenteeism patterns.  
A **star schema** was developed to support analytical queries related to absence frequency, duration, and contributing factors.

---

## Project Objective

To transform employee absenteeism data into an **analytical schema** that enables efficient reporting and trend analysis using fact and dimension tables.

---

## Data Modeling Approach

The database follows a **star schema design**, consisting of:

- One central **fact table** capturing absenteeism measures
- Multiple **dimension tables** providing descriptive context

This design supports:
- Fast aggregations
- Simplified analytical queries
- BI and reporting use cases

---

## Schema Overview

### Fact Table
**Fact_EmployeeAbsenteeism**
- Stores quantitative measures related to absenteeism
- References all dimension tables using foreign keys
- Designed for aggregation and trend analysis

Typical measures include:
- Absence duration
- Absence frequency

---

### Dimension Tables
The schema includes dimensions such as:
- Employee
- Date / Time
- Reason for Absence
- Department (if applicable)

Each dimension contains descriptive attributes used for filtering, grouping, and slicing data.

---

## Key Concepts Demonstrated

- Star schema design
- Fact vs dimension modeling
- Surrogate keys
- Referential integrity
- Analytical (OLAP) vs operational (OLTP) design principles

---

## Technologies Used

- SQL Server
- T-SQL
- ERD / schema modeling tools

---

## Repository Structure

