-- ============================================================
-- Conditional functions
-- DECODE
-- ============================================================
-- DECODE is an Oracle conditional function.
--
-- Простыми словами:
--   DECODE compares one expression with several search values
--   and returns the result connected to the first match.
--
-- It provides simple IF / THEN / ELSE-like logic
-- for equality comparisons.
--
-- В этом уроке только DECODE.
-- Other conditional constructions будут отдельными темами.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   DECODE(
--       expression,
--       search_1, result_1,
--       search_2, result_2,
--       ...,
--       search_n, result_n,
--       default_result
--   )
--
-- Где:
--   expression      - value that Oracle checks;
--   search_n        - possible matching value;
--   result_n        - result for that match;
--   default_result  - optional result when nothing matches.
--
-- Search values and results are written in pairs.


-- ============================================================
-- Main idea
-- ============================================================
-- First, Oracle calculates expression.
-- Then it compares that value with search values.
--
-- Пример:
SELECT DECODE(3 * 4,
              12, 'Twelve') AS result
FROM dual;

-- Evaluation:
--   3 * 4 = 12;
--   12 matches search value 12;
--   result is 'Twelve'.


-- ============================================================
-- One search-result pair
-- ============================================================
-- The shortest useful form contains:
--   expression;
--   one search value;
--   one matching result.
--
-- Pattern:
--
--   DECODE(expression, search, result)
--
-- Пример:
SELECT DECODE(10,
              10, 'Match') AS result
FROM dual;

-- Result:
--   Match


-- ============================================================
-- No match and no default
-- ============================================================
-- If no search value matches
-- and default_result is not provided,
-- DECODE returns NULL.
--
-- Пример:
SELECT DECODE(3 * 4,
              13, 'Thirteen') AS result
FROM dual;

-- 3 * 4 is 12.
-- Search value is 13.
-- They do not match.
--
-- Result:
--   NULL


-- ============================================================
-- Default result
-- ============================================================
-- The last unpaired argument is the default result.
-- Oracle returns it when no search value matches.
--
-- Пример:
SELECT DECODE(3 * 4,
              13, 'Thirteen',
              'Nothing matches') AS result
FROM dual;

-- Evaluation:
--   expression result is 12;
--   12 does not match 13;
--   default result is returned.
--
-- Result:
--   Nothing matches


-- ============================================================
-- Several search-result pairs
-- ============================================================
-- DECODE can compare expression with several values.
--
-- Пример:
SELECT DECODE(3 * 4,
              13, 'Thirteen',
              14, 'Fourteen',
              12, 'Twelve',
              'Unknown') AS result
FROM dual;

-- Oracle checks:
--   12 = 13 -> no;
--   12 = 14 -> no;
--   12 = 12 -> yes.
--
-- Result:
--   Twelve


-- ============================================================
-- First match wins
-- ============================================================
-- Oracle checks search values from left to right.
-- The first matching pair determines the result.
--
-- Пример:
SELECT DECODE(6,
              6, 'First six',
              6, 'Second six',
              'No match') AS result
FROM dual;

-- Result:
--   First six
--
-- The second matching pair is not used.


-- ============================================================
-- Expressions inside DECODE
-- ============================================================
-- expression and search values can be calculations.
--
-- Пример:
SELECT DECODE(2 + 2 * 2,
              5,      'Five',
              12 / 2, 'Six from expression',
              6,      'Six from literal',
              'No match') AS result
FROM dual;

-- Mathematical priority is applied first:
--   2 * 2 = 4;
--   2 + 4 = 6.
--
-- Search expressions:
--   5 is not equal to 6;
--   12 / 2 is equal to 6.
--
-- Result:
--   Six from expression
--
-- Literal search value 6 also matches,
-- but it appears later and is not used.


-- ============================================================
-- Default after calculated comparisons
-- ============================================================
-- Пример:
SELECT DECODE(2 + 2 * 2 * 10,
              5,      'Five',
              12 / 2, 'Six from expression',
              6,      'Six from literal',
              'No known result') AS result
FROM dual;

-- Calculation:
--   2 * 2 * 10 = 40;
--   2 + 40 = 42.
--
-- 42 matches none of the search values,
-- so DECODE returns the default text.


-- ============================================================
-- NULL comparison in DECODE
-- ============================================================
-- DECODE has special Oracle behavior:
--   NULL can match NULL inside DECODE.
--
-- Пример:
SELECT DECODE(NULL,
              5,    'Five',
              NULL, 'Value is NULL',
              'No match') AS result
FROM dual;

-- Result:
--   Value is NULL
--
-- This is different from a normal condition such as:
--   NULL = NULL
--
-- Normal equality with NULL is not TRUE,
-- but DECODE treats two NULL values as a match.


-- ============================================================
-- Checked expression is not returned automatically
-- ============================================================
-- DECODE returns a result from a matching pair
-- or the default result.
--
-- It does not return expression automatically.
--
-- Пример:
SELECT DECODE(10,
              10, 100,
              0) AS result
FROM dual;

-- Result is 100, not 10.


-- ============================================================
-- Search values must be compatible
-- ============================================================
-- expression and search values must be comparable.
--
-- Use a consistent comparison type:
--   NUMBER with NUMBER;
--   text with text;
--   DATE with DATE.
--
-- Numeric example:
SELECT DECODE(18,
              18, 'Match',
              'No match') AS result
FROM dual;

-- Character example:
SELECT DECODE('18',
              '18', 'Match',
              'No match') AS result
FROM dual;

-- Explicit conversion is clearer than mixing
-- unrelated data types in comparison values.


-- ============================================================
-- First search value affects comparison type
-- ============================================================
-- Oracle uses the first search value
-- when determining the comparison type.
--
-- Therefore, keep all search values compatible
-- with expression and with each other.
--
-- Clear example:
SELECT DECODE(TO_NUMBER('18'),
              18, 'Eighteen',
              19, 'Nineteen',
              'Other') AS result
FROM dual;

-- expression and search values are NUMBER.


-- ============================================================
-- Result values must be compatible
-- ============================================================
-- Every result branch should produce
-- the same or a compatible data type.
--
-- Good character results:
SELECT DECODE(1,
              1, 'One',
              2, 'Two',
              'Other') AS result
FROM dual;

-- Good numeric results:
SELECT DECODE(1,
              1, 100,
              2, 200,
              0) AS result
FROM dual;

-- Avoid mixing numeric results with non-numeric text
-- when Oracle would need an unsafe conversion.


-- ============================================================
-- First result affects return type
-- ============================================================
-- Oracle uses the first result expression
-- when determining the result type.
--
-- For predictable code:
--   keep all result values numeric;
--   or keep all result values character;
--   or keep all result values DATE.
--
-- If different types are truly needed,
-- convert them explicitly to one common type.


-- ============================================================
-- DECODE performs equality matching
-- ============================================================
-- DECODE directly compares expression with search values.
-- It is suitable for exact matches.
--
-- Examples of exact values:
--   department_id = 10;
--   job_id = 'IT_PROG';
--   commission_pct = 0.1;
--   value is NULL.
--
-- DECODE does not directly express conditions such as:
--   salary > 10000;
--   salary BETWEEN 5000 AND 10000;
--   first_name LIKE 'A%'.
--
-- Those are not equality matches.


-- ============================================================
-- Character comparison
-- ============================================================
-- Character matching is case-sensitive.
--
-- Пример:
SELECT DECODE('Oracle',
              'ORACLE', 'Match',
              'No match') AS result
FROM dual;

-- Result:
--   No match
--
-- Normalize text when letter case should be ignored:
SELECT DECODE(UPPER('Oracle'),
              'ORACLE', 'Match',
              'No match') AS result
FROM dual;

-- Result:
--   Match


-- ============================================================
-- DECODE with commission_pct
-- ============================================================
-- commission_pct can be classified by exact values.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       DECODE(e.commission_pct,
              NULL, 'No commission',
              0.1,  'Small',
              0.4,  'Big',
                    'Middle') AS commission_group
FROM employees e
WHERE e.employee_id BETWEEN 140 AND 180;

-- Logic:
--   NULL -> No commission;
--   0.1  -> Small;
--   0.4  -> Big;
--   any other value -> Middle.


-- ============================================================
-- DECODE with department_id
-- ============================================================
-- Numeric codes can be translated to readable text.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.department_id,
       DECODE(e.department_id,
              10, 'Administration',
              20, 'Marketing',
              50, 'Shipping',
                  'Other department') AS department_name
FROM employees e;

-- department_id is checked against exact numeric values.


-- ============================================================
-- DECODE with job_id
-- ============================================================
-- Character codes can also be translated.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.job_id,
       DECODE(e.job_id,
              'IT_PROG', 'Programmer',
              'SA_REP',  'Sales representative',
              'ST_CLERK','Stock clerk',
                         'Other job') AS job_name
FROM employees e;


-- ============================================================
-- Result branches can contain calculations
-- ============================================================
-- A matching result can be a numeric expression.
--
-- Пример:
SELECT e.employee_id,
       e.salary,
       e.commission_pct,
       DECODE(e.commission_pct,
              NULL, 0,
                    e.salary * e.commission_pct) AS commission_amount
FROM employees e;

-- If commission_pct is NULL:
--   result is 0.
--
-- Otherwise:
--   default result calculates salary * commission_pct.


-- ============================================================
-- Different calculation for exact values
-- ============================================================
-- Пример:
SELECT e.employee_id,
       e.salary,
       e.department_id,
       DECODE(e.department_id,
              10, e.salary * 1.10,
              20, e.salary * 1.15,
              50, e.salary * 1.05,
                  e.salary) AS adjusted_salary
FROM employees e;

-- The selected calculation depends
-- on the exact department_id value.


-- ============================================================
-- Function result as checked expression
-- ============================================================
-- expression can be returned by another function.
--
-- Пример:
SELECT e.employee_id,
       e.job_id,
       DECODE(SUBSTR(e.job_id, 1, 2),
              'IT', 'Technology',
              'SA', 'Sales',
              'ST', 'Stock',
                    'Other') AS job_area
FROM employees e;

-- Evaluation:
--   SUBSTR returns first two characters of job_id;
--   DECODE compares that result with text codes.


-- ============================================================
-- DECODE inside another function
-- ============================================================
-- DECODE result can become an argument
-- of another single-row function.
--
-- Пример:
SELECT e.employee_id,
       UPPER(
           DECODE(e.commission_pct,
                  NULL, 'No commission',
                        'Has commission')
       ) AS commission_status
FROM employees e;

-- DECODE chooses text first.
-- UPPER then converts that text to uppercase.


-- ============================================================
-- DECODE in WHERE
-- ============================================================
-- DECODE can produce a value used by a condition.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.commission_pct
FROM employees e
WHERE DECODE(e.commission_pct,
             NULL, 0,
                   1) = 1;

-- DECODE returns:
--   0 when commission_pct is NULL;
--   1 when commission_pct is not NULL.
--
-- This query keeps employees with commission_pct.
-- For a simple NULL filter, IS NOT NULL is clearer.
-- This example demonstrates DECODE result in a condition.


-- ============================================================
-- DECODE does not change table data
-- ============================================================
-- DECODE creates a calculated result only.
--
-- Пример:
SELECT e.employee_id,
       e.department_id AS original_department,
       DECODE(e.department_id,
              10, 'Administration',
              20, 'Marketing',
                  'Other') AS displayed_department
FROM employees e;

-- department_id remains unchanged in employees.


-- ============================================================
-- Alias for DECODE result
-- ============================================================
-- DECODE expressions can be long.
-- Give the result a clear alias.
--
-- Пример:
SELECT e.first_name,
       DECODE(e.commission_pct,
              NULL, 'No commission',
                    'Has commission') AS commission_status
FROM employees e;

-- commission_status describes the meaning
-- of the selected result.


-- ============================================================
-- Formatting a long DECODE expression
-- ============================================================
-- Put expression on the first line.
-- Put each search-result pair on its own line.
-- Put default result last.
--
-- Example layout:
SELECT DECODE(e.department_id,
              10, 'Administration',
              20, 'Marketing',
              50, 'Shipping',
                  'Other department') AS department_name
FROM employees e;

-- This layout makes pairs and default easy to see.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Forgetting search-result pairs.
--    Every search value needs its result value.
--
-- 2. Thinking that the last argument is always a search value.
--    An unpaired last argument is the default result.
--
-- 3. Expecting expression to be returned automatically.
--    DECODE returns matched result or default.
--
-- 4. Ignoring the order of duplicate matches.
--    First matching pair wins.
--
-- 5. Mixing incompatible search types.
--    expression and search values must be comparable.
--
-- 6. Mixing incompatible result types.
--    Keep all possible results compatible.
--
-- 7. Trying to use DECODE directly for ranges.
--    DECODE is designed for equality matching.
--
-- 8. Forgetting special NULL behavior.
--    In DECODE, NULL can match NULL.
--
-- 9. Forgetting a default result.
--    Without a match and default, result is NULL.
--
-- 10. Thinking that DECODE changes stored data.
--     It changes only the calculated query result.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Match calculation result 12 with text 'Twelve'.
SELECT DECODE(3 * 4,
              12, 'Twelve') AS result
FROM dual;

-- 2. Return NULL when no value matches and default is absent.
SELECT DECODE(3 * 4,
              13, 'Thirteen') AS result
FROM dual;

-- 3. Use several calculated searches and a default result.
SELECT DECODE(2 + 2 * 2,
              5,      'Five',
              12 / 2, 'Six from expression',
              6,      'Six from literal',
              'No match') AS result
FROM dual;

-- 4. Classify commission_pct by exact values.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       DECODE(e.commission_pct,
              NULL, 'No commission',
              0.1,  'Small',
              0.4,  'Big',
                    'Middle') AS commission_group
FROM employees e;

-- 5. Translate department_id to department text.
SELECT e.employee_id,
       e.first_name,
       e.department_id,
       DECODE(e.department_id,
              10, 'Administration',
              20, 'Marketing',
              50, 'Shipping',
                  'Other department') AS department_name
FROM employees e;

-- 6. Translate selected job_id values to job names.
SELECT e.employee_id,
       e.first_name,
       e.job_id,
       DECODE(e.job_id,
              'IT_PROG', 'Programmer',
              'SA_REP',  'Sales representative',
              'ST_CLERK','Stock clerk',
                         'Other job') AS job_name
FROM employees e;

-- 7. Calculate commission amount or return 0.
SELECT e.employee_id,
       e.salary,
       e.commission_pct,
       DECODE(e.commission_pct,
              NULL, 0,
                    e.salary * e.commission_pct) AS commission_amount
FROM employees e;

-- 8. Classify job area by first two characters of job_id.
SELECT e.employee_id,
       e.job_id,
       DECODE(SUBSTR(e.job_id, 1, 2),
              'IT', 'Technology',
              'SA', 'Sales',
              'ST', 'Stock',
                    'Other') AS job_area
FROM employees e;

-- 9. Show whether manager_id is NULL.
SELECT e.employee_id,
       e.first_name,
       e.manager_id,
       DECODE(e.manager_id,
              NULL, 'No manager',
                    'Has manager') AS manager_status
FROM employees e;

-- 10. Find employees whose commission_pct is not NULL.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct
FROM employees e
WHERE DECODE(e.commission_pct,
             NULL, 0,
                   1) = 1;


-- ============================================================
-- Mini summary
-- ============================================================
-- DECODE compares one expression with search values
-- and returns the result of the first match.
--
-- Syntax:
--   DECODE(expression,
--          search_1, result_1,
--          search_2, result_2,
--          ...,
--          default_result)
--
-- Important:
--   search and result arguments are written in pairs;
--   search values are checked from left to right;
--   first match wins;
--   optional default is returned when nothing matches;
--   without match and default, result is NULL;
--   NULL matches NULL inside DECODE;
--   expression and search values must be comparable;
--   all result branches should have compatible types;
--   DECODE performs exact equality matching;
--   DECODE in SELECT does not change table data.
