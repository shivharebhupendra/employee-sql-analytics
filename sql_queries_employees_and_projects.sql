CREATE DATABASE Set5;
USE Set5;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL,
    manager_id INT,
    join_date DATE
);

INSERT INTO employees (emp_id, name, department, salary, manager_id, join_date) VALUES
(1, 'Aisha', 'HR', 45000, 5, '2021-01-12'),
(2, 'John', 'IT', 75000, 6, '2020-03-15'),
(3, 'Riya', 'Finance', 60000, 5, '2022-08-01'),
(4, 'Sam', 'IT', 55000, 6, '2023-01-10'),
(5, 'Karan', 'HR', 90000, NULL, '2018-02-01'),
(6, 'Meera', 'IT', 95000, NULL, '2017-07-22');


CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT,
    hours INT,
    rating INT,
    FOREIGN KEY (emp_id)
        REFERENCES employees (emp_id)
);


INSERT INTO projects (project_id, project_name, emp_id, hours, rating) VALUES
(101, 'Website', 1, 45, 8),
(102, 'Mobile App', 2, 60, 9),
(103, 'Finance Audit', 3, 55, 7),
(104, 'Network Setup', 4, 30, 6),
(105, 'ERP System', 2, 90, 10);


-- Q1. Find total salary per department.
SELECT 
    department, SUM(salary) AS total_salary
FROM
    employees
GROUP BY department;


-- Q2. Find departments whose average salary is greater than 60,000.
SELECT 
    department, AVG(salary) AS avg_salary
FROM
    employees
GROUP BY department
HAVING avg_salary > 60000;


-- Q3. Find employees who joined after 2021.
SELECT 
    emp_id, name, salary, join_date
FROM
    employees
WHERE
    join_date > '2021-12-31';


-- Q4. Display employees whose name starts with ‘A’ or ‘R’.
SELECT 
    name
FROM
    employees
WHERE
    name LIKE 'A%' OR name LIKE 'R%';


-- Q5. Show employee names with their project names.
SELECT 
    e.name, p.project_name
FROM
    employees e
        JOIN
    projects p ON e.emp_id = p.emp_id;


-- Q6. List all employees even if they are not assigned any projects.
SELECT 
    *
FROM
    employees e
        LEFT JOIN
    projects p ON e.emp_id = p.emp_id;


-- Q7. List all projects even if employee data is missing.
SELECT 
    *
FROM
    employees e
        RIGHT JOIN
    projects p ON e.emp_id = p.emp_id;


-- Q8. Show all combinations of employees × projects.
SELECT 
    *
FROM
    employees
        CROSS JOIN
    projects;


-- Q9. Show manager–employee pairs.
SELECT 
    m.emp_id AS manager_id,
    m.name AS manager_name,
    e.emp_id AS employee_id,
    e.name AS emp_name
FROM
    employees e
        JOIN
    employees m ON e.manager_id = m.emp_id;


-- Q10. Show all employees who share the same department.
SELECT 
    e1.emp_id AS emp1, e2.emp_id AS emp2, e1.department
FROM
    employees e1
        JOIN
    employees e2 ON e1.department = e2.department
        AND e1.emp_id < e2.emp_id;
        

-- Q11. Rank employees by salary.
SELECT 
	emp_id, name, salary, 
    RANK() OVER(ORDER BY salary desc) as rnk 
FROM 
	employees;


-- Q12. Compute running total of salaries ordered by join_date.
SELECT 
	emp_id, name, salary, 
	SUM(salary) OVER(ORDER BY join_date) as running_total 
FROM 
	employees; 


-- Q13. Show difference between each employee’s salary and department average salary (using AVG() OVER PARTITION).
SELECT 
	emp_id, name, salary, department, 
	AVG(salary) OVER(PARTITION BY department) AS avg_salary,
    (salary-AVG(salary) OVER(PARTITION BY department)) AS difference_salary
FROM 
	employees;

-- Q14. Show previous employee salary.
SELECT 
	emp_id, name, salary, 
    LAG(salary) OVER(ORDER BY join_date) as previous_emp_salary 
FROM 
	employees;

-- Q15. Show next employee salary.
SELECT 
	emp_id, name, salary, 
    LEAD(salary) OVER(ORDER BY join_date) as next_emp_salary 
FROM 
	employees;


-- Q16. Count employees per department.     
SELECT 
    department, COUNT(*)
FROM
    employees
GROUP BY department;


-- Q17. Find employees earning more than the average salary.
SELECT 
    emp_id, name, salary
FROM
    employees
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            employees);


-- Q18. Find the employee with the second highest salary.   
SELECT 
    emp_id, name, salary
FROM
    employees
WHERE
    salary = (SELECT 
            MAX(salary)
        FROM
            employees
        WHERE
            salary < (SELECT 
                    MAX(salary)
                FROM
                    employees)); 
                    
                    
-- Q19. Use a CTE to show each employee and their yearly salary (salary × 12).
WITH cte AS (
SELECT 
    emp_id, name, salary, (salary * 12) AS yearly_salary
FROM
    employees
)
SELECT 
    *
FROM
    cte;

-- Q20. Recursive CTE: print numbers from 1 to 10.
WITH RECURSIVE nums AS (
SELECT 1 AS n 
UNION ALL SELECT 
    n + 1
FROM
    nums
WHERE
    n < 10
)
SELECT 
    n
FROM
    nums;
    

-- Q21. Create a function that returns annual salary of an employee.
DELIMITER $$
CREATE FUNCTION annual_salary(emp INT)
RETURNS INT 
DETERMINISTIC 
BEGIN
	DECLARE sal INT;
    
   SELECT 
    salary
INTO sal FROM
    employees
WHERE
    emp_id = emp;
    
	RETURN sal*12;
END $$
DELIMITER ;

SELECT annual_salary(1) ;


-- Q22. Create a function that returns employee experience in years.
DELIMITER $$
CREATE FUNCTION experience_in_years(emp INT)
RETURNS INT
DETERMINISTIC
BEGIN 
	DECLARE experience INT;
SELECT 
    TIMESTAMPDIFF(YEAR,
        join_date,
        CURDATE())
INTO experience FROM
    employees
WHERE
    emp_id = emp;
    RETURN experience;
END$$
DELIMITER ;

SELECT EXPERIENCE_IN_YEARS(1);


-- Q23. Create a temp table of employees earning above 70,000.
CREATE TEMPORARY TABLE earning_above AS
SELECT 
    *
FROM
    employees
WHERE
    salary > 70000;

SELECT 
    *
FROM
    earning_above;
    
    
-- Q24. Insert top 3 highest salary employees into a temp table.
CREATE TEMPORARY TABLE top_3_salaries AS
SELECT 
    *
FROM
    employees
ORDER BY salary DESC
LIMIT 3;

SELECT * FROM top_3_salaries;

-- Q25. Create a procedure that returns all employees from a department.
DELIMITER $$
CREATE PROCEDURE all_employees(dept VARCHAR(50))
BEGIN
	SELECT emp_id, name
	FROM employees
	WHERE department = dept; 
END $$
DELIMITER ;
    
CALL all_employees('HR');    

-- Q26. Create a procedure that inserts a new project.
DELIMITER $$
CREATE PROCEDURE new_project(
	IN p_id INT, 
    IN p_name VARCHAR(50), 
    IN emp_id INT, 
    IN hrs INT, 
    IN rate INT
)
BEGIN
	INSERT INTO projects(project_id, project_name, emp_id, hours, rating)
	VALUES(p_id, p_name, emp_id, hrs, rate);
END $$
DELIMITER ;
CALL new_project(106, 'E-Commerce', 2, 76, 8);
SELECT * FROM projects;

-- Q27. Trigger to log deleted employees into a log table.
CREATE TABLE log_table (
    emp_id INT,
    emp_name VARCHAR(50),
    salary INT,
    operation VARCHAR(10),
    datetime DATETIME
);

DELIMITER $$
CREATE TRIGGER after_delete_emp
AFTER DELETE ON employees 
FOR EACH ROW 
BEGIN
	INSERT INTO log_table(emp_id, emp_name, salary, operation, datetime)
    VALUES (old.emp_id, old.name, old.salary, 'DELETE', NOW());
END $$
DELIMITER ;

ALTER TABLE projects 
ADD CONSTRAINT project_ibfk_1
FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
ON DELETE CASCADE;
 
DELETE FROM employees 
WHERE
    emp_id = 1;
    
SELECT 
    *
FROM
    log_table;


-- Q28. Trigger to prevent deleting managers.
DELIMITER $$
CREATE TRIGGER prevent_manager_delete
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
	IF OLD.manager_id IS NULL THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Deletion blocked: Managers cannot be deleted';
	END IF;
END $$
DELIMITER ;

DELETE FROM employees WHERE emp_id = 6;


-- Q29. Write a transaction to insert a new employee → new project. 
-- (Rollback if second insert fails.)
DELIMITER $$
CREATE PROCEDURE insert_emp_project(
	IN eid INT, 
    IN emp_name VARCHAR(50), 
	IN dept VARCHAR(50),
    IN income INT,
    IN mid INT,
    IN joindate DATE,
    IN pid INT,
    IN pname VARCHAR(50),
    IN hours INT,
    IN rate INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
	END;
    
    START TRANSACTION;
    INSERT INTO employees (emp_id, name, department, salary, manager_id, join_date)
    VALUES (eid, emp_name, dept, income, mid, joindate);

    INSERT INTO projects (project_id, project_name, emp_id, hours, rating)
    VALUES (pid, pname, eid, hours, rate);
    
    COMMIT;
END $$
DELIMITER ;
CALL insert_emp_project(
    20,                 -- emp_id
    'John',             -- name
    'HR',               -- dept
    55000,              -- salary
    3,                  -- manager_id
    '2024-01-10',       -- join_date
    210,                -- project_id
    'Payroll System',   -- project_name
    45,                 -- hours
    9                   -- rating
);




-- Q30. Write a transaction that updates salary, then logs it in audit table.
CREATE TABLE salary_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    old_salary DECIMAL(10 , 2 ),
    new_salary DECIMAL(10 , 2 ),
    changed_at DATETIME
);

DELIMITER $$
CREATE PROCEDURE update_salary_transaction(
	IN emp INT,
    IN new_sal DECIMAL(10,2)
)
BEGIN 
	DECLARE old_sal DECIMAL(10,2);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
	END;
	
    START TRANSACTION;
    
SELECT 
    salary
INTO old_sal FROM
    employees
WHERE
    emp_id = emp;
    
UPDATE employees 
SET 
    salary = new_sal
WHERE
    emp_id = emp;
    
    INSERT INTO salary_audit(emp_id, old_salary, new_salary, changed_at)
    VALUES (emp, old_sal, new_sal, NOW());
    
    COMMIT;
END$$
DELIMITER ;
CALL update_salary_transaction(2, 80000);
SELECT 
    *
FROM
    salary_audit;



-- Q31. Create a view showing emp_name, department, project_name.
CREATE VIEW emp_details AS
    SELECT 
        e.name, e.department, p.project_name
    FROM
        employees e
            JOIN
        projects p ON e.emp_id = p.emp_id;

SELECT 
    *
FROM
    emp_details;


-- Q32. Create a view showing only IT employees with salary > 60k.
CREATE VIEW emp_it AS
    SELECT 
        *
    FROM
        employees
    WHERE
        department = 'IT' AND salary > 60000;

SELECT 
    *
FROM
    emp_it;


-- Q33. Create an index on employees(salary).
CREATE INDEX idx_salary ON employees(salary);
                                   

-- Q34. Explain why indexing join columns improves performance.
-- Ans. 
-- i. Indexing join columns reduces execution time
-- ii. Makes queries scalable for large datasets
-- iii. Essential in OLTP and OLAP systems for efficient reporting and analytics

-- Q35. Categorize employees based on salary:
-- High (>80k),
-- Medium (50k–80k),
-- Low (<50k)
SELECT 
    *,
    CASE
        WHEN salary > 80000 THEN 'High'
        WHEN salary BETWEEN 50000 AND 80000 THEN 'Medium'
        ELSE 'Low'
    END AS category
FROM
    employees;


-- Q36. Display project performance:
-- If rating >= 8 → “Excellent”
-- If rating >= 6 → “Good”
-- Else “Average”
SELECT 
    *,
    CASE
        WHEN rating >= 8 THEN 'Excellent'
        WHEN rating >= 6 THEN 'Good'
        ELSE 'Average'
    END AS rating_category
FROM
    projects;


-- Q37. Find department with highest total salary.
SELECT 
    department, SUM(salary) AS total_salary
FROM
    employees
GROUP BY department
ORDER BY total_salary DESC
LIMIT 1;


-- Q38. Find employee who worked highest hours across all projects.
SELECT 
    e.emp_id, e.name, SUM(p.hours) AS total_hour
FROM
    employees e
        JOIN
    projects p ON e.emp_id = p.emp_id
GROUP BY e.emp_id , e.name
ORDER BY total_hour DESC
LIMIT 1;


