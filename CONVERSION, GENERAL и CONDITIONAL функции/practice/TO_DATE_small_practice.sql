-- Task 1: Convert text '15-08-2026' to DATE.
SELECT TO_DATE('15-08-2026', 'DD-MM-YYYY') AS result
FROM dual;

-- Task 2: Convert text with time to DATE and show it with TO_CHAR.
SELECT TO_CHAR(TO_DATE('15-08-2026 14:30:25', 'DD-MM-YYYY HH24:MI:SS'),
                       'DD-MM-YYYY HH24:MI:SS') AS result
FROM dual;

-- Task 3: Convert text with English month name.
SELECT TO_DATE('15-August-2026',
               'DD-Month-YYYY',
               'NLS_DATE_LANGUAGE = English') AS result
FROM dual;

-- Task 4: Show employees hired after 01-JAN-2005.
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE e.hire_date > TO_DATE('01-JAN-2005', 'DD-MON-YYYY');

-- Task 5: Show employees hired before 01-JAN-2007.
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE e.hire_date < TO_DATE('01-JAN-2007', 'DD-MON-YYYY');

-- Task 6: Show employees hired during 2006.
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE e.hire_date >= TO_DATE('01-JAN-2006', 'DD-MON-YYYY') AND
      e.hire_date <  TO_DATE('01-JAN-2007', 'DD-MON-YYYY';

SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE e.hire_date BETWEEN TO_DATE('01-JAN-2006', 'DD-MON-YYYY') AND
                          TO_DATE('01-JAN-2007', 'DD-MON-YYYY';

-- Task 7: Show employees hired on or after 20-SEP-2006.
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE e.hire_date >= TO_DATE('20-SEP-2006', 'DD-MON-YYYY');

-- Task 8: Show employee name, hire_date and formatted hire_date_text
--         for employees hired after 01-JAN-2007.
SELECT e.employee_id,
       e.first_name,
       e.hire_date,
       TO_CHAR(e.hire_date, 'DD-MON-YYYY') AS hire_date_text
FROM employees e
WHERE e.hire_date > TO_DATE('01-JAN-2007', 'DD-MON-YYYY');

-- Task 9: Show employees whose hire_date is before 01-JUL-2006.
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE e.hire_date < TO_DATE('01-JAN-2006', 'DD-MON-YYYY');

-- Task 10: Show readable sentence for employees hired after 01-JAN-2008.
SELECT 'Employee ' || e.first_name ||
       ' was hired on ' ||
       TO_CHAR(e.hire_date, 'DD-MON-YYYY') AS sentence
FROM employees e
WHERE e.hire_date > TO_DATE('01-JAN-2008', 'DD-MON-YYYY');
