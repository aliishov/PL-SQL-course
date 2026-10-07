-- Task 1: Keep 18 because it is not NULL.
SELECT NVL(18, 19) AS result
FROM dual;

-- Task 2: Replace NULL with number 19.
SELECT NVL(NULL, 19) AS result
FROM dual;

-- Task 3: Replace an empty string with text 'No value'.
SELECT NVL('', 'No value') AS result
FROM dual;

-- Task 4: Show 0 instead of NULL commission_pct.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       NVL(e.commission_pct, 0) AS commission_value
FROM employees e;

-- Task 5: Return bonus 500 when salary * commission_pct is NULL.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.commission_pct,
       NVL(e.salary * e.commission_pct, 500) AS bonus
FROM employees e;

-- Task 6: Replace NULL commission_pct with 0 before multiplication.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.commission_pct,
       e.salary * NVL(e.commission_pct) AS commission_amount
FROM employees e;

-- Task 7: Show a message when SUBSTR returns NULL.
SELECT e.employee_id,
       e.first_name,
       NVL(SUBSTR(e.first_name, 6), 'Name is too short') AS name_part
FROM employees e;

-- Task 8: Show 0 when manager_id is NULL.
SELECT e.employee_id,
       e.first_name,
       e.manager_id,
       NVL(e.manager_id, 0) AS manager_value
FROM employees e;

-- Task 9: Show 'No phone' when phone_number is NULL.
SELECT e.employee_id,
       e.first_name,
       e.phone_number,
       NVL(e.phone_number, 'No phone') AS phone_value
FROM employees e;

-- Task 10: Find employees whose commission_pct is NULL or 0.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct
FROM employees e
WHERE NVL(e.commission_pct, 0) = 0;
