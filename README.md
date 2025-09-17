# Hospital Database Design

## 📌 Overview
This project is a **Hospital Management Database** designed to manage patients, doctors, staff, medicines, lab tests, billing, and more.  
It covers the full process from **ERD → Mapping → Implementation → T-SQL queries**.

---

## 🏗 Project Steps
1. **ERD (Entity Relationship Diagram)**  
   - Shows the main entities: Patients, Doctors, Appointments, Departments, etc.  
   - Includes all relationships (1-to-M, M-to-M).

2. **Mapping**  
   - Conversion from ERD to Relational Schema.  
   - Normalized tables with keys & constraints.

3. **Implementation (SQL DDL)**  
   - Tables created using SQL scripts.  
   - Includes constraints, primary/foreign keys, unique, check conditions.

4. **T-SQL Queries**  
   - Sample queries for reporting and hospital operations.  
   - Examples: Patient history, doctor schedules, billing reports.

---

## 📂 Repository Structure
- `ERD/` → ERD diagrams.  
- `Mapping/` → Mapping documents.  
- `SQL/` → All SQL scripts.  

---

## 🚀 How to Run
1. Create a new database in SQL Server (e.g., `HospitalDB`).
2. Run `01_create_tables.sql` to build the schema.
3. (Optional) Run `02_insert_data.sql` to add test data.
4. Run `03_tsql_queries.sql` for sample queries.

---

## 🛠 Tools Used
- **SQL Server** (T-SQL)  
- **Draw.io / Lucidchart** (for ERD)  
- *DrawDiagram (for Mapping)

--
