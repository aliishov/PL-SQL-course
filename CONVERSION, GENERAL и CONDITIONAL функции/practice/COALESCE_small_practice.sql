-- Task 1: Return the first non-NULL number.
SELECT COALESCE(1, NULL, 2) AS result
FROM dual;

-- Task 2: Skip two NULL values and return 2.
SELECT COALESCE(NULL, NULL, 2) AS result
FROM dual;

-- Task 3: Return NULL when every argument is NULL.
SELECT COALESCE(NULL, NULL, NULL, NULL) AS result
FROM dual;

-- Task 4: Choose the first available numeric employee value.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       e.manager_id,
       e.salary,
       COALESCE(
           e.commission_pct,
           e.manager_id,
           e.salary
       ) AS first_available_number
FROM employees e;

-- Task 5: Choose phone_number, email or fixed contact text.
SELECT e.employee_id,
       e.first_name,
       e.email,
       e.phone_number,
       COALESCE(
           e.email,
           e.phone_number,
           'No contact'
       ) AS preferred_contact
FROM employees e;

-- Task 6: Calculate commission, five percent bonus or fixed bonus.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.commission_pct,
       COALESCE(
           e.salary * e.commission_pct,
           e.salary * 0.05,
           500
       ) AS bonus
FROM employees e;

-- Task 7: Return hire_date or a default DATE value.
SELECT e.employee_id,
       e.first_name,
       e.hire_date,
       COALESCE(
           e.hire_date,
           TO_DATE('01-01-2000', 'DD-MM-YYYY')
       ) AS safe_hire_date
FROM employees e;

-- Task 8: Use SUBSTR result, original first_name or fixed text.
SELECT e.employee_id,
       e.first_name
       COALESCE(
           SUBSTR(e.first_name, 6),
           e.first_name,
           'No name'
       ) AS name_value
FROM employees e;

-- Task 9: Replace job_id 'SA_REP' through NULLIF and COALESCE.
SELECT e.employee_id,
       e.first_name,
       e.job_id,
       COALESCE(
           NULLIF(e.job_id, 'SA_REP'),
           'Hidden job'
       ) AS job_value
FROM employees e;

-- Task 10: Find employees with a positive commission_pct.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct
FROM employees e
WHERE COALESCE(e.commission_pct, 0) > 0;
