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