USE employees;

-- See the lastNames of employees
SELECT lastName FROM employees;

-- See the lastNames of employees without repeated values
SELECT DISTINCT lastName FROM employees;

-- Show all data about employees that last name is "Lopez"
SELECT * FROM employees
WHERE lastName = "Lopez";

-- -- Show all data about employees that last name is "Lopez" and "Perez"
SELECT  * FROM employees
WHERE lastName IN ("Lopez", "Perez");

-- Show all data of employees that work in department 102
SELECT * FROM employees
WHERE department=102;

-- Show all data of employees that work in department 101 and 102
SELECT e.dni, e.firstName, e.lastName FROM employees AS e
INNER JOIN departments AS d
ON d.id = e.department
WHERE e.department IN (101, 102);

-- show all employees data that last name starts with "p"
SELECT * FROM employees
WHERE lastName LIKE "P%";

-- All department's badget
SELECT SUM(budget) AS "badget's sum" FROM departments;

-- Number of employees/ per department
SELECT d.departmentName, COUNT(e.dni) AS number_employees
FROM departments AS d
INNER JOIN employees AS e
ON e.department = d.id
GROUP BY d.departmentName;

-- All info of employees and their department
SELECT e.dni, e.firstName, e.lastName, d.id, d.departmentName, d.budget  FROM employees AS e
INNER JOIN departments AS d
ON d.id=e.department;

-- Show some employees' information and some department information
SELECT e.firstName, e.lastName, d.departmentName, d.budget
FROM employees AS e
INNER JOIN departments AS d
ON d.id=e.department;

-- Employees' info if budget > 5000000
SELECT e.firstName, e.lastName FROM employees AS e
INNER JOIN departments AS d
ON d.id=e.department
	AND d.budget > 5000000;

-- Bring departments' info if the budget is more than all budget's average
SELECT id, departmentName, budget FROM departments
WHERE budget >
(
	SELECT AVG(budget)
    FROM departments
);

-- Bring only names of departments who has two or more employees
SELECT departmentName FROM departments
WHERE id IN (
	SELECT department FROM employees
	GROUP BY department
	HAVING COUNT(dni) >= 2
);

-- Add some data
INSERT INTO departments (id, departmentName, budget)
VALUES (11, 'Calidad', 40000);

INSERT INTO employees (firstName, lastName, department)
VALUES ('Santiago', 'Torres', (
	SELECT id FROM departments
    WHERE departmentName = 'Calidad'
    )
);
INSERT INTO employees (firstName, lastName, department)
VALUES ('Lauara', 'Gómez', (
	SELECT id FROM departments
    WHERE departmentName = 'music'
    )
);

-- Apply a cut on the budget of all departmens by 10%
UPDATE departments SET budget = budget*0.10;

-- Move some employees to another departmen
UPDATE employees SET department=100
WHERE department IN (
	SELECT id FROM departments
    WHERE departmentName='Technology'
);

-- Fired tecnology's employees
DELETE FROM employees
WHERE department = (
	SELECT id FROM departments
    WHERE departmentName="Technology"
);