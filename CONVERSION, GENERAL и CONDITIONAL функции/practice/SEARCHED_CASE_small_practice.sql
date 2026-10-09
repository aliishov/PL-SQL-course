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
