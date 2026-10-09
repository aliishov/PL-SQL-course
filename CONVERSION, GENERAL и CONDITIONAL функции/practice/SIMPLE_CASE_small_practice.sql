-- Task 1: Return numeric value 100 when 3 * 4 equals 12.
SELECT CASE 3 * 4
           WHEN 12 THEN 100
       END AS result
FROM dual;

-- Task 2: Show that the first of two equal matches wins.
SELECT CASE 3 * 4 
           WHEN 11     THEN 'Eleven'
           WHEN 12     THEN 'Twelve from literal'
           WHEN 24 / 2 THEN 'Twelve from expression'
           ELSE 'No match'
       END AS result
FROM dual;

-- Task 3: Return ELSE when 3 * 5 matches no WHEN value.
SELECT CASE 3 * 5 
           WHEN 11     THEN 'Eleven'
           WHEN 12     THEN 'Twelve from literal'
           WHEN 24 / 2 THEN 'Twelve from expression'
           ELSE 'No match'
       END AS result
FROM dual;

-- Task 4: Classify first_name by its exact length.
SELECT e.employee_id,
       e.first_name,
       CASE LENGTH(e.first_name)
           WHEN 4 THEN 'Too short name'
           WHEN 5 THEN 'Short name'
           WHEN 6 THEN 'Middle length name'
           WHEN 7 THEN 'Long name'
           WHEN 8 THEN 'Too long name'
           ELSE 'Length undefined'
       END AS length_status
FROM employees e;

-- Task 5: Translate department_id to department text.
SELECT e.employee_id,
       e.first_name,
       e.department_id,
       CASE e.depatment_id
           WHEN 10 THEN 'Administration'
           WHEN 20 THEN 'Marketing'
           WHEN 50 THEN 'Shipping'
           ELSE 'Other department' 
       END AS department_name
FROM employees e;
