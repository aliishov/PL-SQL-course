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
