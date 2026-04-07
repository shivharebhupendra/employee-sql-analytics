# employee-sql-analytics
A collection of SQL queries and insights analyzing employee and department data, showcasing aggregation, joins, window functions, and real-world business problem solving.

---

## 📘 SQL Practice Project – Employee & Project Management System

This project contains 38 SQL questions, including queries, joins, subqueries, window functions, CTEs, triggers, procedures, transactions, indexing, and views.
It also includes business insights derived from the outputs.

---

## 🏗️ Database Structure
- Employees Table
  - Stores employee info like department, salary, manager, and join date.

- Projects Table

  - Stores project assignments, hours worked, and rating.

---

## 🎯 Covered SQL Concepts

- ✔ Basic Queries
- ✔ Joins (INNER, LEFT, RIGHT)
- ✔ Aggregations
- ✔ Subqueries
- ✔ Window Functions
- ✔ CTEs + Recursive CTEs
- ✔ Stored Functions
- ✔ Stored Procedures
- ✔ Transactions
- ✔ Triggers
- ✔ Views
- ✔ Indexing
- ✔ Case Statements
- ✔ Salary Categorization
- ✔ Performance Insights

---

## 📊 Key Insights from All Queries

- 1. Employee Patterns

  - Highest Salary: Meera (95,000)

  - Second Highest Salary: Karan (90,000)

  - IT department has 3 employees — highest count

  - Highest total hours: John (226 hours) across 4 projects

  - HR avg salary = 67,500 (Aisha < avg, Karan > avg)

  - IT avg salary = 75,000

  - Finance avg salary = 60,000

- 2. Department-Level Insights

  - Department with highest total salary: IT (230,000 total salary)

  - Department with lowest headcount: Finance (1 employee)

  - High salary range (>80k): Meera & Karan

  - Medium salary range (50k–80k): Majority employees

  - Low salary (<50k): None after updates

- 3. Project Insights

  - Multiple high-performance projects: "ERP System", "E-Commerce", "Mobile App"

  - Most productive employee (hours): John

  - Ratings:

    - Excellent (>=8): 5 projects

    - Good (6–7): 2 projects

  - Project distribution shows strong contribution from IT-related employees

- 4. Managerial Structure

  - Managers:

    - Karan manages: Aisha & Riya

    - Meera manages: John & Sam

  - Trigger prevents deletion of managers to maintain hierarchy integrity
 
---

| Category         | Questions |
| ---------------- | --------- |
| Basic Queries    | Q1–Q7     |
| Self Join        | Q9–Q10    |
| Window Functions | Q11–Q15   |
| Aggregations     | Q16–Q18   |
| CTEs             | Q19–Q20   |
| Functions        | Q21–Q22   |
| Temporary Tables | Q23–Q24   |
| Procedures       | Q25–Q26   |
| Triggers         | Q27–Q28   |
| Transactions     | Q29–Q30   |
| Views            | Q31–Q32   |
| Indexing         | Q33       |
| Business Case    | Q35–Q38   |

---

## 📚 Highlights of Important SQL Concepts Used

🧮 Window Functions

- Ranking

- Running totals

- Avg salary difference

- LAG & LEAD

🛠 Procedures & Functions

- Annual salary calculation

- Experience in years

- Insert project procedure

- Transaction-safe employee + project insertion

🔒 Triggers

- Logging deleted employees

- Blocking deletion of managers

👁 Views

- Employee project details

- IT employees with salary > 60k

⚡ Indexing

- Improving performance by indexing join or filter columns

---

## 🧠 Final Summary – What This Project Demonstrates

This SQL project proves your capability in:

- ✔ Real-world database problem solving
- ✔ Advanced SQL including transactions & triggers
- ✔ Creating structured business insights from raw queries
- ✔ Building production-level stored procedures & views
- ✔ Data analysis using aggregate + window functions

---

## 👨‍💻 Author

Bhupendra Shivhare

Aspiring Data Scientist | Deep Learning Enthusiast

📧 Email: shivharebhupendra@gmail.com
