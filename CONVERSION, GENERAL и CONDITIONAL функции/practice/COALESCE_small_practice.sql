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
