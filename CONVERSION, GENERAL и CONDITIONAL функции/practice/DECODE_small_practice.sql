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
       DECODE(
           e.commission_pct,
           NULL, 'No commission',
           0.1,  'Small',
           0.4,  'Big',
                 'Middle') AS commission_group
FROM employees e;
