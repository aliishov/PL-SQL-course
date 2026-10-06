-- Task 1: Convert simple text '750' to NUMBER.
SELECT TO_NUMBER('750') AS result
FROM dual;

-- Task 2: Convert text '$2,450.75' to NUMBER.
SELECT TO_NUMBER('$2,450.75', '$9,999.99') AS result
FROM dual;

-- Task 3: Convert '<1,250.50>' to a negative NUMBER.
SELECT TO_NUMBER('<1,250.50>', '9,999.99PR') AS result
FROM dual;

-- Task 4: Show employees whose salary is greater than text value '10000'.
SELECT e.employee_id,
       e.first_name,
       e.salary
FROM employees e
WHERE e.salary > TO_NUMBER('10000');

-- Task 5: Show employees whose salary is at least formatted value '$5,000'.
SELECT e.employee_id,
       e.first_name,
       e.salary
FROM employees e
WHERE e.salary >= TO_NUMBER('$5,000', '$9,9999');

-- Task 6: Add text value '300' to every employee salary.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.salary + TO_NUMBER('300') AS increased_salary
FROM employees e;

-- Task 7: Subtract formatted text value '1,000' from salary.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.salary - TO_NUMBER('1,000', '9,999') AS reduced_salary
FROM employees e;

-- Task 8: Show employees whose commission_pct is greater than text '0.20'.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct
FROM employees e
WHERE e.commission_pct > TO_NUMBER('0.20', '9D99',
                                   'NLS_NUMERIC_CHARACTERS = ''.,''');

-- Task 9: Multiply salary by numeric value converted from text '1.10'.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.salary * TO_NUMBER('0.10', '9D99', 
                                    'NLS_NUMERIC_CHARACTERS = ''.,''') AS new_salary
FROM employees e;

-- Task 10: Show employees whose salary is between two converted text values.
SELECT e.employee_id,
       e.first_name,
       e.salary
FROM employees e
WHERE e.salary >= TO_NUMBER('5,000', '99,999')
  AND e.salary <= TO_NUMBER('15,000', '99,999');
