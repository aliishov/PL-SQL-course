-- Task 1: Return 100 when the calculation condition is TRUE.
SELECT CASE
           WHEN 3 * 4 = 12 THEN 100
       END AS result
FROM dual;

-- Task 2: Show that the first TRUE condition wins.
SELECT CASE
           WHEN 10 > 5 THEN 'First true condition'
           WHEN 10 > 1 THEN 'Second true condition'
           ELSE 'No condition'
       END AS result
FROM dual;

-- Task 3: Return ELSE when no condition is TRUE.
SELECT CASE
           WHEN 3 * 5 = 11 THEN 'Eleven'
           WHEN 3 * 5 = 12 THEN 'Twelve'
           ELSE 'Fifteen'
       END
FROM dual;

-- Task 4: Classify first_name by length ranges.
SELECT e.employee_id,
       e.first_name
       CASE
           WHEN LENGTH(e.first_name) <= 4 THEN 'Very short name'
           WHEN LENGTH(e.first_name) <= 6 THEN 'Short name'
           WHEN LENGTH(e.first_name) <= 8 THEN 'Middle name'
           ELSE 'Long name'
       END AS length_status
FROM employees e;

-- Task 5: Classify salary with higher threshold first.
SELECT e.employee_id,
       e.first_name 
       e.salary
       CASE
           WHEN e.salary >= 15000 THEN 'High salary'
           WHEN e.salary >= 8000  THEN 'Middle salary'
           ELSE 'Lower salary'
       END AS salary_group 
FROM employees e;

-- Task 6: Show commission status using IS NULL.
SELECT e.employee_id,
       e.first_name 
       e.commission_pct
       CASE
           WHEN e.commission_pct IS NULL THEN 'No commission'
           ELSE 'Have commission'
       END AS commission_status
FROM employees e;

-- Task 7: Check salary and commission_pct in one AND condition.
SELECT e.employee_id,
       e.first_name 
       e.commission_pct
       CASE
           WHEN e.salary >= 10000
            AND e.commission_pct IS NOT NULL
               THEN 'High salary with commission'
           ELSE 'Other employee'
       END AS employee_group
FROM employees e;

-- Task 8: Classify employees by hire_date periods.
SELECT e.employee_id,
       e.first_name,
       e.hire_date,
       CASE
           WHEN e.hire_date < TO_DATE('01-01-2005', 'DD-MM-YYYY')
               THEN 'Hired before 2005'
           WHEN e.hire_date < TO_DATE('01-01-2008', 'DD-MM-YYYY')
               THEN 'Hired from 2005 to 2007'
           ELSE 'Hired in 2008 or later'
       END AS hire_period 
FROM employees e;

-- Task 9: Calculate bonus using different conditions.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.commission_pct
       CASE
           WHEN e.commission_pct IS NOT NULL
               THEN e.salary * e.commission_pct
           WHEN e.salary >= 10000
               THEN e.salary * 0.10
           ELSE e.salary * 0.05
       END AS bonus
FROM employees e;
