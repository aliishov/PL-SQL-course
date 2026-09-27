-- ============================================================
-- Conditional expressions
-- Simple CASE
-- ============================================================
-- Simple CASE is a conditional SQL expression.
--
-- Простыми словами:
--   simple CASE calculates one expression,
--   compares it with several values
--   and returns the result of the first match.
--
-- It is designed for exact equality comparisons.
--
-- В этом уроке только simple CASE.
-- Conditions with >, <, BETWEEN, LIKE, AND and OR
-- belong to a separate searched CASE lesson.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   CASE expression
--       WHEN comparison_1 THEN result_1
--       WHEN comparison_2 THEN result_2
--       ...
--       WHEN comparison_n THEN result_n
--       ELSE default_result
--   END
--
-- Где:
--   expression      - value that Oracle calculates once;
--   comparison_n    - value compared with expression;
--   result_n        - result of a matching WHEN branch;
--   default_result  - optional result when nothing matches.
--
-- END is required.
-- ELSE is optional.


-- ============================================================
-- Main idea
-- ============================================================
-- Пример:
SELECT CASE 3 * 4
           WHEN 12 THEN 100
       END AS result
FROM dual;

-- Evaluation:
--   3 * 4 = 12;
--   12 matches WHEN 12;
--   result is 100.


-- ============================================================
-- Character result
-- ============================================================
-- THEN can return text.
--
-- Пример:
SELECT CASE 3 * 4
           WHEN 12 THEN 'Twelve'
       END AS result
FROM dual;

-- Result:
--   Twelve
--
-- Checked expression is NUMBER,
-- but returned result can be VARCHAR2.
-- Comparison values and return values have separate roles.


-- ============================================================
-- Several WHEN branches
-- ============================================================
-- Simple CASE can compare expression
-- with several possible values.
--
-- Пример:
SELECT CASE 3 * 4
           WHEN 10 THEN 'Ten'
           WHEN 11 THEN 'Eleven'
           WHEN 12 THEN 'Twelve'
       END AS result
FROM dual;

-- Oracle compares calculated value 12 with each WHEN value
-- from top to bottom until it finds a match.


-- ============================================================
-- First match wins
-- ============================================================
-- If several WHEN expressions produce the same value,
-- the first matching branch is used.
--
-- Пример:
SELECT CASE 3 * 4
           WHEN 11     THEN 'Eleven'
           WHEN 12     THEN 'Twelve from literal'
           WHEN 24 / 2 THEN 'Twelve from expression'
       END AS result
FROM dual;

-- Both 12 and 24 / 2 are equal to checked value 12.
--
-- Result:
--   Twelve from literal
--
-- The first matching WHEN branch wins.


-- ============================================================
-- No match and no ELSE
-- ============================================================
-- If nothing matches and ELSE is absent,
-- simple CASE returns NULL.
--
-- Пример:
SELECT CASE 3 * 5
           WHEN 11     THEN 'Eleven'
           WHEN 12     THEN 'Twelve from literal'
           WHEN 24 / 2 THEN 'Twelve from expression'
       END AS result
FROM dual;

-- 3 * 5 is 15.
-- There is no WHEN 15.
--
-- Result:
--   NULL


-- ============================================================
-- ELSE result
-- ============================================================
-- ELSE provides a default result
-- when no WHEN value matches.
--
-- Пример:
SELECT CASE 3 * 5
           WHEN 11     THEN 'Eleven'
           WHEN 12     THEN 'Twelve from literal'
           WHEN 24 / 2 THEN 'Twelve from expression'
           ELSE 'Fifteen'
       END AS result
FROM dual;

-- Result:
--   Fifteen
--
-- ELSE is used because 15 matches none of the WHEN values.


-- ============================================================
-- END is required
-- ============================================================
-- Every CASE expression must finish with END.
--
-- Correct:
SELECT CASE 1
           WHEN 1 THEN 'One'
           ELSE 'Other'
       END AS result
FROM dual;

-- Invalid structure:
--
-- SELECT CASE 1
--            WHEN 1 THEN 'One'
--        AS result
-- FROM dual;
--
-- END is missing.


-- ============================================================
-- CASE is an expression
-- ============================================================
-- Simple CASE returns one value.
-- It can be placed in a SELECT list
-- like a column or another expression.
--
-- Пример:
SELECT employee_id,
       department_id,
       CASE department_id
           WHEN 10 THEN 'Administration'
           WHEN 20 THEN 'Marketing'
           ELSE 'Other department'
       END AS department_name
FROM employees;

-- One CASE result is produced for every row.


-- ============================================================
-- Comparison data types
-- ============================================================
-- expression and all WHEN comparison values
-- must have the same or compatible data types.
--
-- Good numeric comparison:
SELECT CASE 15
           WHEN 10 THEN 'Ten'
           WHEN 15 THEN 'Fifteen'
           ELSE 'Other'
       END AS result
FROM dual;

-- Good character comparison:
SELECT CASE '15'
           WHEN '10' THEN 'Ten'
           WHEN '15' THEN 'Fifteen'
           ELSE 'Other'
       END AS result
FROM dual;


-- ============================================================
-- Incompatible WHEN values
-- ============================================================
-- This structure mixes NUMBER comparison values
-- with non-numeric text:
--
-- SELECT CASE 3 * 5
--            WHEN 11   THEN 'Eleven'
--            WHEN 'OK' THEN 'Text branch'
--            WHEN 15   THEN 'Fifteen'
--            ELSE 'Other'
--        END AS result
-- FROM dual;
--
-- Checked expression is NUMBER,
-- but 'OK' is non-numeric character text.
-- Oracle can raise a data type or conversion error.
--
-- Keep all WHEN comparison values numeric here.


-- ============================================================
-- Return data types
-- ============================================================
-- All THEN results and ELSE result
-- must have the same or compatible data types.
--
-- Good character results:
SELECT CASE 15
           WHEN 11 THEN 'Eleven'
           WHEN 15 THEN 'Fifteen'
           ELSE 'Other'
       END AS result
FROM dual;

-- Good numeric results:
SELECT CASE 15
           WHEN 11 THEN 110
           WHEN 15 THEN 150
           ELSE 0
       END AS result
FROM dual;


-- ============================================================
-- Incompatible return values
-- ============================================================
-- This structure mixes a numeric result
-- with non-numeric character results:
--
-- SELECT CASE 3 * 5
--            WHEN 11 THEN 110
--            WHEN 12 THEN 'Twelve'
--            ELSE 'Fifteen'
--        END AS result
-- FROM dual;
--
-- Oracle needs one result data type for the whole CASE.
-- It can raise a data type or conversion error.
--
-- Convert results explicitly when one common type is needed:
SELECT CASE 3 * 5
           WHEN 11 THEN TO_CHAR(110)
           WHEN 12 THEN 'Twelve'
           ELSE 'Fifteen'
       END AS result
FROM dual;

-- All possible results are now character values.


-- ============================================================
-- Numeric result type
-- ============================================================
-- When all returned values are numeric,
-- Oracle can use numeric precedence to choose a common type.
--
-- For predictable beginner examples,
-- use NUMBER results together.


-- ============================================================
-- Simple CASE uses exact equality
-- ============================================================
-- Simple CASE compares one expression
-- with each WHEN value using equality logic.
--
-- It is suitable for values such as:
--   department_id = 10;
--   job_id = 'IT_PROG';
--   LENGTH(first_name) = 5.
--
-- Simple CASE does not directly accept a full condition like:
--   salary > 10000;
--   salary BETWEEN 5000 AND 10000;
--   first_name LIKE 'A%'.
--
-- Those conditions belong to searched CASE.


-- ============================================================
-- NULL does not match NULL in simple CASE
-- ============================================================
-- Simple CASE uses equality comparison.
-- In normal SQL equality, NULL is not equal to NULL.
--
-- Пример:
SELECT CASE TO_NUMBER(NULL)
           WHEN TO_NUMBER(NULL) THEN 'Match'
           ELSE 'No match'
       END AS result
FROM dual;

-- Result:
--   No match
--
-- This is different from DECODE,
-- where NULL can match NULL.


-- ============================================================
-- Handling NULL before simple CASE
-- ============================================================
-- A NULL value can be replaced before comparison.
--
-- Пример:
SELECT employee_id,
       commission_pct,
       CASE NVL(commission_pct, -1)
           WHEN -1  THEN 'No commission'
           WHEN 0.1 THEN 'Small commission'
           WHEN 0.4 THEN 'Big commission'
           ELSE 'Other commission'
       END AS commission_group
FROM employees;

-- Evaluation:
--   NVL converts NULL commission_pct to -1;
--   simple CASE compares the resulting number;
--   WHEN -1 represents the missing-value case.
--
-- Use a replacement value that cannot be a real data value.


-- ============================================================
-- Character comparison is case-sensitive
-- ============================================================
-- Letter case affects exact text matching.
--
-- Пример:
SELECT CASE 'Oracle'
           WHEN 'ORACLE' THEN 'Match'
           ELSE 'No match'
       END AS result
FROM dual;

-- Result:
--   No match
--
-- Normalize the checked expression when needed:
SELECT CASE UPPER('Oracle')
           WHEN 'ORACLE' THEN 'Match'
           ELSE 'No match'
       END AS result
FROM dual;

-- Result:
--   Match


-- ============================================================
-- Function result as CASE expression
-- ============================================================
-- The checked expression can be returned by a function.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       LENGTH(e.first_name) AS name_length,
       CASE LENGTH(e.first_name)
           WHEN 4 THEN 'Too short name'
           WHEN 5 THEN 'Short name'
           WHEN 6 THEN 'Middle length name'
           WHEN 7 THEN 'Long name'
           WHEN 8 THEN 'Too long name'
           ELSE 'Length undefined'
       END AS length_status
FROM employees e;

-- Evaluation for every row:
--   LENGTH returns number of characters;
--   CASE compares that number with WHEN values;
--   matching text status is returned.


-- ============================================================
-- Simple CASE with department_id
-- ============================================================
-- Numeric codes can be translated to text.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.department_id,
       CASE e.department_id
           WHEN 10 THEN 'Administration'
           WHEN 20 THEN 'Marketing'
           WHEN 50 THEN 'Shipping'
           ELSE 'Other department'
       END AS department_name
FROM employees e;


-- ============================================================
-- Simple CASE with job_id
-- ============================================================
-- Character codes can be translated to readable names.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.job_id,
       CASE e.job_id
           WHEN 'IT_PROG' THEN 'Programmer'
           WHEN 'SA_REP'  THEN 'Sales representative'
           WHEN 'ST_CLERK' THEN 'Stock clerk'
           ELSE 'Other job'
       END AS job_name
FROM employees e;


-- ============================================================
-- THEN can contain calculations
-- ============================================================
-- Each branch can return a numeric expression.
--
-- Пример:
SELECT e.employee_id,
       e.salary,
       e.department_id,
       CASE e.department_id
           WHEN 10 THEN e.salary * 1.10
           WHEN 20 THEN e.salary * 1.15
           WHEN 50 THEN e.salary * 1.05
           ELSE e.salary
       END AS adjusted_salary
FROM employees e;

-- All possible results are numeric.
-- The selected calculation depends on department_id.


-- ============================================================
-- Function result inside WHEN comparison
-- ============================================================
-- WHEN values can also be expressions.
--
-- Пример:
SELECT CASE 12
           WHEN 3 * 4  THEN 'First match'
           WHEN 24 / 2 THEN 'Second match'
           ELSE 'No match'
       END AS result
FROM dual;

-- Both comparison expressions produce 12.
-- The first branch wins.


-- ============================================================
-- Character function as checked expression
-- ============================================================
-- Пример:
SELECT e.employee_id,
       e.job_id,
       CASE SUBSTR(e.job_id, 1, 2)
           WHEN 'IT' THEN 'Technology'
           WHEN 'SA' THEN 'Sales'
           WHEN 'ST' THEN 'Stock'
           ELSE 'Other'
       END AS job_area
FROM employees e;

-- SUBSTR is evaluated first.
-- CASE then compares its character result.


-- ============================================================
-- CASE result inside another function
-- ============================================================
-- The complete CASE expression returns one value.
-- That value can become an argument of another function.
--
-- Пример:
SELECT e.employee_id,
       UPPER(
           CASE e.department_id
               WHEN 10 THEN 'Administration'
               WHEN 20 THEN 'Marketing'
               ELSE 'Other department'
           END
       ) AS department_name
FROM employees e;

-- CASE chooses text first.
-- UPPER processes the selected text after that.


-- ============================================================
-- Simple CASE in WHERE
-- ============================================================
-- CASE result can be used by a WHERE condition.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.department_id
FROM employees e
WHERE CASE e.department_id
          WHEN 50 THEN 1
          ELSE 0
      END = 1;

-- CASE returns 1 only for department_id 50.
-- The outer comparison keeps those rows.
--
-- For a simple equality filter,
-- WHERE department_id = 50 is clearer.
-- This example demonstrates CASE as an expression.


-- ============================================================
-- Simple CASE and DECODE
-- ============================================================
-- Both can map exact values to results.
--
-- Simple CASE:
--   uses WHEN ... THEN branches;
--   ends with END;
--   optional default is written with ELSE;
--   NULL does not match NULL through equality.
--
-- DECODE:
--   uses comma-separated search-result pairs;
--   has no END keyword;
--   treats NULL and NULL as a match.
--
-- In both forms, the first match wins.


-- ============================================================
-- Simple CASE does not change table data
-- ============================================================
-- CASE creates a calculated result only.
--
-- Пример:
SELECT e.employee_id,
       e.department_id AS original_department,
       CASE e.department_id
           WHEN 10 THEN 'Administration'
           WHEN 20 THEN 'Marketing'
           ELSE 'Other'
       END AS displayed_department
FROM employees e;

-- department_id remains unchanged in employees.


-- ============================================================
-- Alias for CASE result
-- ============================================================
-- Alias is written after END.
--
-- Пример:
SELECT CASE department_id
           WHEN 10 THEN 'Administration'
           WHEN 20 THEN 'Marketing'
           ELSE 'Other'
       END AS department_name
FROM employees;

-- department_name describes the final selected value.


-- ============================================================
-- Formatting a simple CASE expression
-- ============================================================
-- Recommended layout:
--   CASE expression
--       WHEN value THEN result
--       WHEN value THEN result
--       ELSE result
--   END AS alias
--
-- Keep CASE and END aligned.
-- Put every WHEN branch on a separate line.
-- This makes comparison values and results easy to scan.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Forgetting END.
--    Every CASE expression must finish with END.
--
-- 2. Forgetting THEN after WHEN value.
--    Correct form is WHEN value THEN result.
--
-- 3. Mixing incompatible comparison types.
--    expression and all WHEN values must be comparable.
--
-- 4. Mixing incompatible return types.
--    THEN and ELSE results need one compatible result type.
--
-- 5. Expecting NULL to match WHEN NULL.
--    Simple CASE uses equality, so NULL does not match NULL.
--
-- 6. Forgetting ELSE.
--    Without a match and ELSE, result is NULL.
--
-- 7. Ignoring branch order.
--    First matching WHEN branch wins.
--
-- 8. Trying to place a full condition after WHEN.
--    Simple CASE compares exact values only.
--
-- 9. Writing alias before END.
--    Alias belongs after the completed CASE expression.
--
-- 10. Thinking that CASE changes stored table data.
--     It returns a calculated value only.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Return numeric value 100 when 3 * 4 equals 12.
SELECT CASE 3 * 4
           WHEN 12 THEN 100
       END AS result
FROM dual;

-- 2. Show that the first of two equal matches wins.
SELECT CASE 3 * 4
           WHEN 11     THEN 'Eleven'
           WHEN 12     THEN 'Twelve from literal'
           WHEN 24 / 2 THEN 'Twelve from expression'
           ELSE 'No match'
       END AS result
FROM dual;

-- 3. Return ELSE when 3 * 5 matches no WHEN value.
SELECT CASE 3 * 5
           WHEN 11 THEN 'Eleven'
           WHEN 12 THEN 'Twelve'
           ELSE 'Fifteen'
       END AS result
FROM dual;

-- 4. Classify first_name by its exact length.
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

-- 5. Translate department_id to department text.
SELECT e.employee_id,
       e.first_name,
       e.department_id,
       CASE e.department_id
           WHEN 10 THEN 'Administration'
           WHEN 20 THEN 'Marketing'
           WHEN 50 THEN 'Shipping'
           ELSE 'Other department'
       END AS department_name
FROM employees e;

-- 6. Translate selected job_id values to job names.
SELECT e.employee_id,
       e.first_name,
       e.job_id,
       CASE e.job_id
           WHEN 'IT_PROG' THEN 'Programmer'
           WHEN 'SA_REP'  THEN 'Sales representative'
           WHEN 'ST_CLERK' THEN 'Stock clerk'
           ELSE 'Other job'
       END AS job_name
FROM employees e;

-- 7. Classify commission_pct after replacing NULL with -1.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       CASE NVL(e.commission_pct, -1)
           WHEN -1  THEN 'No commission'
           WHEN 0.1 THEN 'Small commission'
           WHEN 0.4 THEN 'Big commission'
           ELSE 'Other commission'
       END AS commission_group
FROM employees e;

-- 8. Calculate adjusted salary for exact department_id values.
SELECT e.employee_id,
       e.salary,
       e.department_id,
       CASE e.department_id
           WHEN 10 THEN e.salary * 1.10
           WHEN 20 THEN e.salary * 1.15
           WHEN 50 THEN e.salary * 1.05
           ELSE e.salary
       END AS adjusted_salary
FROM employees e;

-- 9. Classify job area by first two characters of job_id.
SELECT e.employee_id,
       e.job_id,
       CASE SUBSTR(e.job_id, 1, 2)
           WHEN 'IT' THEN 'Technology'
           WHEN 'SA' THEN 'Sales'
           WHEN 'ST' THEN 'Stock'
           ELSE 'Other'
       END AS job_area
FROM employees e;

-- 10. Use simple CASE result to keep department_id 50.
SELECT e.employee_id,
       e.first_name,
       e.department_id
FROM employees e
WHERE CASE e.department_id
          WHEN 50 THEN 1
          ELSE 0
      END = 1;


-- ============================================================
-- Mini summary
-- ============================================================
-- Simple CASE compares one expression
-- with several exact values.
--
-- Syntax:
--   CASE expression
--       WHEN comparison_1 THEN result_1
--       WHEN comparison_2 THEN result_2
--       ELSE default_result
--   END
--
-- Important:
--   expression is compared with WHEN values;
--   comparison is based on equality;
--   first matching WHEN branch wins;
--   ELSE is optional;
--   without match and ELSE, result is NULL;
--   END is required;
--   comparison values must have compatible types;
--   return values must have compatible types;
--   NULL does not match NULL in simple CASE;
--   CASE in SELECT does not change table data.
