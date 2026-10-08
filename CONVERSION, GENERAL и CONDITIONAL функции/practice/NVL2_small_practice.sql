-- Task 1: Return 18 because checked value 17 is not NULL.
SELECT NVL2(17, 18, 19) AS result
FROM dual;

-- Task 2: Return 19 because checked value is NULL.
SELECT NVL2(NULL, 18, 19) AS result
FROM dual;

-- Task 3: Show 'No text' for an empty string.
SELECT NVL2('', 'Has Text', 'No Text') AS result
FROM dual;

-- Task 4: Return commission_pct or 0.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       NVL2(e.commission_pct, e.commission_pct, 0) AS commission_value
FROM employees e;

-- Task 5: Show a text status for commission_pct.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       NVL2(e.commission_pct, 
            'Hash commission', 
            'No commission') AS commission_status
FROM employees e;

-- Task 6: Calculate commission amount or return 0.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.commission_pct,
       NVL2(e.commission_pct,
            e.salary * e.commission_pct,
            0) AS commission_amount
FROM employees e;

-- Task 7: Use commission for bonus or 5 percent of salary.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.commission_pct,
       NVL2(e.commission_pct,
            e.salary * e.commission_pct,
            e.salary * 0.05) AS commission_amount
FROM employees e;

-- Task 8: Show whether manager_id exists.
SELECT e.employee_id,
       e.first_name,
       e.manager_id,
       NVL2(e.manager_id, 
            'Hash manager', 
            'No manager') AS manager_status
FROM employees e;
