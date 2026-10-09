-- Task 1: Match calculation result 12 with text 'Twelve'.
SELECT DECODE(3 * 4, 12, 'Twelve') AS result
FROM dual;

-- Task 2: Return NULL when no value matches and default is absent.
SELECT DECODE(3 * 4, 13, 'Thriteen') AS result
FROM dual;

-- Task 3: Use several calculated searches and a default result.
SELECT DECODE(2 + 2 * 2, 
              5,      'Five', 
              12 / 2, 'Six from expression', 
              6,      'Six from literal', 
                      'No match') AS result
FROM dual;

-- Task 4: Classify commission_pct by exact values.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       DECODE(e.commission_pct,
              NULL, 'No commission',
              0.1,  'Small',
              0.4,  'Big',
                    'Middle') AS commission_group
FROM employees e;

-- Task 5: Translate department_id to department text.
SELECT e.employee_id,
       e.first_name,
       e.department_id,
       DECODE(e.department_id,
              10, 'Administration',
              20, 'Marketing',
              50, 'Shipping',
                  'Other department') AS department_text
FROM employees e;

-- Task 6: Translate selected job_id values to job names.
SELECT e.employee_id,
       e.first_name,
       e.job_id,
       DECODE(e.job_id,
              'IT_PROG', 'Programmer',
              'SA_REP',  'Sales representative',
              'ST_CLERK','Stock clerk',
                         'Other job') AS job_names
FROM employees e;

-- Task 7: Calculate commission amount or return 0.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.commission_pct,
       DECODE(e.commission_pct,
              NULL, 0,
                    e.salary * e.commission_pct) AS commission_amount
FROM employees e;

-- Task 8: Classify job area by first two characters of job_id.
SELECT e.employee_id,
       e.first_name,
       e.job_id,
       DECODE(SUBSTR(e.job_id, 1, 2),
              'IT', 'Technology',
              'SA', 'Sales',
              'ST', 'Stock',
                    'Other') AS job_area
FROM employees e;
       
-- Task 9: Show whether manager_id is NULL.
SELECT e.employee_ida,
       e.first_name,
       e.manager_id,
       DECODE(e.manager_id, 
              NULL, 'No manager',
                    'Has Manager') AS manager_status
FROM employees e;
