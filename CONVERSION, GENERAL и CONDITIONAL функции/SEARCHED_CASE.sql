-- ============================================================
-- Conditional expressions
-- Searched CASE
-- ============================================================
-- Searched CASE is a conditional SQL expression.
--
-- Простыми словами:
--   searched CASE checks complete conditions
--   and returns the result of the first TRUE condition.
--
-- Every WHEN branch can contain its own condition.
-- Different branches can check different columns,
-- functions, operators and expressions.
--
-- В этом уроке только searched CASE.
-- Simple CASE уже рассматривается в отдельном уроке.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   CASE
--       WHEN condition_1 THEN result_1
--       WHEN condition_2 THEN result_2
--       ...
--       WHEN condition_n THEN result_n
--       ELSE default_result
--   END
--
-- Где:
--   condition_n     - complete condition;
--   result_n        - result when condition is TRUE;
--   default_result  - optional result when no condition is TRUE.
--
-- There is no checked expression directly after CASE.
-- END is required.
-- ELSE is optional.


-- ============================================================
-- Main idea
-- ============================================================
-- Пример:
SELECT CASE
           WHEN 3 * 4 = 12 THEN 100
       END AS result
FROM dual;

-- Evaluation:
--   3 * 4 = 12;
--   condition is TRUE;
--   result is 100.


-- ============================================================
-- Character result
-- ============================================================
-- THEN can return character text.
--
-- Пример:
SELECT CASE
           WHEN 3 * 4 = 12 THEN 'Twelve'
       END AS result
FROM dual;

-- Result:
--   Twelve
--
-- The condition produces TRUE or FALSE.
-- The THEN branch produces the final value.


-- ============================================================
-- Several WHEN conditions
-- ============================================================
-- Searched CASE checks conditions from top to bottom.
--
-- Пример:
SELECT CASE
           WHEN 3 * 4 = 11     THEN 'Eleven'
           WHEN 3 * 4 = 12     THEN 'Twelve from literal'
           WHEN 3 * 4 = 24 / 2 THEN 'Twelve from expression'
       END AS result
FROM dual;

-- The first condition is FALSE.
-- The second condition is TRUE.
--
-- Result:
--   Twelve from literal


-- ============================================================
-- First TRUE condition wins
-- ============================================================
-- More than one condition can be TRUE.
-- Only the first TRUE branch is returned.
--
-- Пример:
SELECT CASE
           WHEN 10 > 5 THEN 'First true condition'
           WHEN 10 > 1 THEN 'Second true condition'
           ELSE 'No condition'
       END AS result
FROM dual;

-- Both conditions are TRUE.
-- Result comes from the first one.
--
-- Result:
--   First true condition


-- ============================================================
-- No TRUE condition and no ELSE
-- ============================================================
-- If every condition is FALSE or UNKNOWN
-- and ELSE is absent, result is NULL.
--
-- Пример:
SELECT CASE
           WHEN 3 * 5 = 11     THEN 'Eleven'
           WHEN 3 * 5 = 12     THEN 'Twelve from literal'
           WHEN 3 * 5 = 24 / 2 THEN 'Twelve from expression'
       END AS result
FROM dual;

-- 3 * 5 is 15.
-- No condition is TRUE.
--
-- Result:
--   NULL


-- ============================================================
-- ELSE result
-- ============================================================
-- ELSE provides a default result
-- when no WHEN condition is TRUE.
--
-- Пример:
SELECT CASE
           WHEN 3 * 5 = 11     THEN 'Eleven'
           WHEN 3 * 5 = 12     THEN 'Twelve from literal'
           WHEN 3 * 5 = 24 / 2 THEN 'Twelve from expression'
           ELSE 'Fifteen'
       END AS result
FROM dual;

-- Result:
--   Fifteen


-- ============================================================
-- Independent conditions
-- ============================================================
-- Every WHEN branch can check a different expression.
--
-- Пример:
SELECT CASE
           WHEN 3 * 4 = 11       THEN 'Numeric condition'
           WHEN 'OK' = 'OK'      THEN 'Text condition'
           WHEN 50 / 2 * 3 = 100 THEN 'Another calculation'
           ELSE 'No condition'
       END AS result
FROM dual;

-- The first condition is FALSE.
-- The second condition is TRUE.
--
-- Result:
--   Text condition
--
-- Unlike simple CASE,
-- searched CASE does not compare every branch
-- with one shared expression.


-- ============================================================
-- Conditions must be valid
-- ============================================================
-- Each WHEN must contain a condition
-- that Oracle can evaluate as TRUE, FALSE or UNKNOWN.
--
-- Invalid comparison example:
--
-- SELECT CASE
--            WHEN 3 * 5 = 'OK' THEN 'Match'
--            ELSE 'No match'
--        END AS result
-- FROM dual;
--
-- Left side is NUMBER.
-- Right side is non-numeric text.
-- Oracle can raise a conversion error.
--
-- Compare compatible values inside each condition.


-- ============================================================
-- Return data types
-- ============================================================
-- All THEN results and ELSE result
-- must have the same or compatible data types.
--
-- Good character results:
SELECT CASE
           WHEN 3 * 5 = 11 THEN 'Eleven'
           WHEN 3 * 5 = 15 THEN 'Fifteen'
           ELSE 'Other'
       END AS result
FROM dual;

-- Good numeric results:
SELECT CASE
           WHEN 3 * 5 = 11 THEN 110
           WHEN 3 * 5 = 15 THEN 150
           ELSE 0
       END AS result
FROM dual;


-- ============================================================
-- Incompatible return values
-- ============================================================
-- This structure mixes NUMBER result
-- with non-numeric character results:
--
-- SELECT CASE
--            WHEN 3 * 5 = 11 THEN 110
--            WHEN 3 * 5 = 12 THEN 'Twelve'
--            ELSE 'Fifteen'
--        END AS result
-- FROM dual;
--
-- Oracle needs one common result type.
-- It can raise a data type or conversion error.
--
-- Convert the numeric result explicitly if final result is text:
SELECT CASE
           WHEN 3 * 5 = 11 THEN TO_CHAR(110)
           WHEN 3 * 5 = 12 THEN 'Twelve'
           ELSE 'Fifteen'
       END AS result
FROM dual;


-- ============================================================
-- TRUE, FALSE and UNKNOWN
-- ============================================================
-- A SQL condition can produce:
--   TRUE;
--   FALSE;
--   UNKNOWN.
--
-- Searched CASE enters a WHEN branch only when
-- that condition is TRUE.
--
-- FALSE and UNKNOWN conditions are skipped.
-- UNKNOWN often appears when a comparison contains NULL.


-- ============================================================
-- Incorrect NULL comparison
-- ============================================================
-- Equality does not correctly check NULL.
--
-- This branch is not selected for NULL:
--
-- CASE
--     WHEN commission_pct = NULL THEN 'No commission'
--     ELSE 'Other'
-- END
--
-- commission_pct = NULL produces UNKNOWN,
-- not TRUE.


-- ============================================================
-- Correct NULL condition
-- ============================================================
-- Use IS NULL or IS NOT NULL.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       CASE
           WHEN e.commission_pct IS NULL THEN 'No commission'
           ELSE 'Has commission'
       END AS commission_status
FROM employees e;

-- IS NULL is TRUE when commission_pct is missing.


-- ============================================================
-- Comparison operators
-- ============================================================
-- Searched CASE can use comparison operators
-- inside each WHEN condition.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.salary,
       CASE
           WHEN e.salary >= 15000 THEN 'High salary'
           WHEN e.salary >= 8000  THEN 'Middle salary'
           ELSE 'Lower salary'
       END AS salary_group
FROM employees e;

-- Conditions are checked from top to bottom.


-- ============================================================
-- Order of overlapping conditions
-- ============================================================
-- Conditions can overlap.
-- More specific or higher threshold conditions
-- usually need to appear first.
--
-- Correct order:
SELECT e.employee_id,
       e.salary,
       CASE
           WHEN e.salary >= 15000 THEN 'High salary'
           WHEN e.salary >= 8000  THEN 'Middle salary'
           ELSE 'Lower salary'
       END AS salary_group
FROM employees e;

-- Salary 17000 satisfies both:
--   salary >= 15000;
--   salary >= 8000.
--
-- The first TRUE condition returns 'High salary'.
--
-- If salary >= 8000 were written first,
-- salary 17000 would incorrectly receive 'Middle salary'.


-- ============================================================
-- BETWEEN in a WHEN condition
-- ============================================================
-- A condition can check a range.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.salary,
       CASE
           WHEN e.salary BETWEEN 15000 AND 25000 THEN 'High range'
           WHEN e.salary BETWEEN 8000 AND 14999  THEN 'Middle range'
           ELSE 'Lower range'
       END AS salary_range
FROM employees e;

-- BETWEEN includes both boundary values.


-- ============================================================
-- IN in a WHEN condition
-- ============================================================
-- A condition can check membership in a list.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.department_id,
       CASE
           WHEN e.department_id IN (10, 20, 30) THEN 'Office group'
           WHEN e.department_id IN (50, 80)     THEN 'Operations group'
           ELSE 'Other group'
       END AS department_group
FROM employees e;


-- ============================================================
-- LIKE in a WHEN condition
-- ============================================================
-- A condition can check a text pattern.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       CASE
           WHEN e.first_name LIKE 'A%' THEN 'Starts with A'
           WHEN e.first_name LIKE 'S%' THEN 'Starts with S'
           ELSE 'Other first letter'
       END AS name_group
FROM employees e;


-- ============================================================
-- AND in a WHEN condition
-- ============================================================
-- AND requires both parts to be TRUE.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.commission_pct,
       CASE
           WHEN e.salary >= 10000
            AND e.commission_pct IS NOT NULL
               THEN 'High salary with commission'
           ELSE 'Other employee'
       END AS employee_group
FROM employees e;


-- ============================================================
-- OR in a WHEN condition
-- ============================================================
-- OR requires at least one part to be TRUE.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.department_id,
       CASE
           WHEN e.department_id = 10
             OR e.department_id = 20
               THEN 'Selected department'
           ELSE 'Other department'
       END AS department_group
FROM employees e;


-- ============================================================
-- NOT in a WHEN condition
-- ============================================================
-- NOT reverses a condition result.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.department_id,
       CASE
           WHEN e.department_id NOT IN (10, 20, 30)
               THEN 'Outside office group'
           ELSE 'Office group'
       END AS department_group
FROM employees e;


-- ============================================================
-- Function calls inside conditions
-- ============================================================
-- A WHEN condition can use function results.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       LENGTH(e.first_name) AS name_length,
       CASE
           WHEN LENGTH(e.first_name) <= 4 THEN 'Very short name'
           WHEN LENGTH(e.first_name) <= 6 THEN 'Short name'
           WHEN LENGTH(e.first_name) <= 8 THEN 'Middle name'
           ELSE 'Long name'
       END AS length_status
FROM employees e;

-- Each condition calls LENGTH for the current row.
-- First TRUE condition determines the result.


-- ============================================================
-- Different columns in different branches
-- ============================================================
-- Each WHEN can check a different part of the row.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.commission_pct,
       CASE
           WHEN LENGTH(e.first_name) <= 5
               THEN 'Short first name'
           WHEN e.salary * 10 > 100000
               THEN 'High annual-style value'
           WHEN e.commission_pct IS NOT NULL
               THEN 'Has commission'
           ELSE 'No condition matched'
       END AS condition_result
FROM employees e;

-- Branches are independent,
-- but only the first TRUE branch is returned.


-- ============================================================
-- Date conditions
-- ============================================================
-- Searched CASE can compare DATE values.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.hire_date,
       CASE
           WHEN e.hire_date < TO_DATE('01-01-2005', 'DD-MM-YYYY')
               THEN 'Hired before 2005'
           WHEN e.hire_date < TO_DATE('01-01-2008', 'DD-MM-YYYY')
               THEN 'Hired from 2005 to 2007'
           ELSE 'Hired in 2008 or later'
       END AS hire_period
FROM employees e;

-- Date boundaries are explicitly converted with TO_DATE.


-- ============================================================
-- THEN branches can contain calculations
-- ============================================================
-- Returned results can be numeric expressions.
--
-- Пример:
SELECT e.employee_id,
       e.salary,
       e.commission_pct,
       CASE
           WHEN e.commission_pct IS NOT NULL
               THEN e.salary * e.commission_pct
           WHEN e.salary >= 10000
               THEN e.salary * 0.10
           ELSE e.salary * 0.05
       END AS bonus
FROM employees e;

-- All possible results are numeric.


-- ============================================================
-- CASE result inside another function
-- ============================================================
-- Complete CASE result can become
-- an argument of another function.
--
-- Пример:
SELECT e.employee_id,
       UPPER(
           CASE
               WHEN e.commission_pct IS NULL THEN 'No commission'
               ELSE 'Has commission'
           END
       ) AS commission_status
FROM employees e;

-- CASE chooses text first.
-- UPPER processes that selected text.


-- ============================================================
-- Searched CASE in WHERE
-- ============================================================
-- CASE result can be used by a WHERE condition.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.commission_pct
FROM employees e
WHERE CASE
          WHEN e.salary >= 10000
           AND e.commission_pct IS NOT NULL THEN 1
          ELSE 0
      END = 1;

-- The query keeps rows for which CASE returns 1.
--
-- Direct WHERE conditions are usually clearer for simple filtering.
-- This example demonstrates CASE as a calculated expression.


-- ============================================================
-- Simple CASE and searched CASE
-- ============================================================
-- Simple CASE:
--
--   CASE expression
--       WHEN value THEN result
--   END
--
-- It compares one expression with exact values.
--
-- Searched CASE:
--
--   CASE
--       WHEN condition THEN result
--   END
--
-- It checks complete independent conditions.
--
-- Use searched CASE when logic needs:
--   comparison operators;
--   ranges;
--   NULL checks;
--   patterns;
--   combined conditions;
--   different columns in different branches.


-- ============================================================
-- CASE does not change table data
-- ============================================================
-- Searched CASE creates a calculated result only.
--
-- Пример:
SELECT e.employee_id,
       e.salary AS original_salary,
       CASE
           WHEN e.salary >= 10000 THEN 'High salary'
           ELSE 'Other salary'
       END AS salary_status
FROM employees e;

-- salary remains unchanged in employees.


-- ============================================================
-- Alias for searched CASE result
-- ============================================================
-- Alias is written after END.
--
-- Пример:
SELECT CASE
           WHEN salary >= 10000 THEN 'High salary'
           ELSE 'Other salary'
       END AS salary_status
FROM employees;

-- salary_status describes the final selected value.


-- ============================================================
-- Formatting a searched CASE expression
-- ============================================================
-- Recommended layout:
--   CASE
--       WHEN condition THEN result
--       WHEN condition THEN result
--       ELSE result
--   END AS alias
--
-- For a long condition:
--   place AND or OR parts on separate aligned lines;
--   indent THEN under the condition;
--   keep CASE and END aligned.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Writing an expression directly after CASE.
--    Searched CASE starts with CASE and then WHEN condition.
--
-- 2. Writing a value instead of a complete condition after WHEN.
--    Searched CASE needs a condition that can become TRUE.
--
-- 3. Checking NULL with = NULL.
--    Use IS NULL or IS NOT NULL.
--
-- 4. Placing broad overlapping conditions first.
--    First TRUE branch wins, so order affects the result.
--
-- 5. Mixing incompatible THEN and ELSE result types.
--    The whole CASE expression needs one compatible result type.
--
-- 6. Forgetting ELSE.
--    Without a TRUE condition and ELSE, result is NULL.
--
-- 7. Forgetting END.
--    Every CASE expression must finish with END.
--
-- 8. Forgetting that UNKNOWN is not TRUE.
--    Conditions involving NULL can be skipped.
--
-- 9. Assuming every TRUE branch is returned.
--    Only the first TRUE branch determines the result.
--
-- 10. Thinking that CASE changes stored table data.
--     It returns a calculated value only.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Return 100 when the calculation condition is TRUE.
SELECT CASE
           WHEN 3 * 4 = 12 THEN 100
       END AS result
FROM dual;

-- 2. Show that the first TRUE condition wins.
SELECT CASE
           WHEN 10 > 5 THEN 'First true condition'
           WHEN 10 > 1 THEN 'Second true condition'
           ELSE 'No condition'
       END AS result
FROM dual;

-- 3. Return ELSE when no condition is TRUE.
SELECT CASE
           WHEN 3 * 5 = 11 THEN 'Eleven'
           WHEN 3 * 5 = 12 THEN 'Twelve'
           ELSE 'Fifteen'
       END AS result
FROM dual;

-- 4. Classify first_name by length ranges.
SELECT e.employee_id,
       e.first_name,
       CASE
           WHEN LENGTH(e.first_name) <= 4 THEN 'Very short name'
           WHEN LENGTH(e.first_name) <= 6 THEN 'Short name'
           WHEN LENGTH(e.first_name) <= 8 THEN 'Middle name'
           ELSE 'Long name'
       END AS length_status
FROM employees e;

-- 5. Classify salary with higher threshold first.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       CASE
           WHEN e.salary >= 15000 THEN 'High salary'
           WHEN e.salary >= 8000  THEN 'Middle salary'
           ELSE 'Lower salary'
       END AS salary_group
FROM employees e;

-- 6. Show commission status using IS NULL.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       CASE
           WHEN e.commission_pct IS NULL THEN 'No commission'
           ELSE 'Has commission'
       END AS commission_status
FROM employees e;

-- 7. Check salary and commission_pct in one AND condition.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.commission_pct,
       CASE
           WHEN e.salary >= 10000
            AND e.commission_pct IS NOT NULL
               THEN 'High salary with commission'
           ELSE 'Other employee'
       END AS employee_group
FROM employees e;

-- 8. Classify employees by hire_date periods.
SELECT e.employee_id,
       e.first_name,
       e.hire_date,
       CASE
           WHEN e.hire_date < TO_DATE('01-01-2005', 'DD-MM-YYYY')
               THEN 'Hired before 2005'
           WHEN e.hire_date < TO_DATE('01-01-2008', 'DD-MM-YYYY')
               THEN 'Hired from 2005 to 2007'
           ELSE 'Hired in 2008 or later'
       END AS hire_period
FROM employees e;

-- 9. Calculate bonus using different conditions.
SELECT e.employee_id,
       e.salary,
       e.commission_pct,
       CASE
           WHEN e.commission_pct IS NOT NULL
               THEN e.salary * e.commission_pct
           WHEN e.salary >= 10000
               THEN e.salary * 0.10
           ELSE e.salary * 0.05
       END AS bonus
FROM employees e;

-- 10. Classify departments using IN lists.
SELECT e.employee_id,
       e.first_name,
       e.department_id,
       CASE
           WHEN e.department_id IN (10, 20, 30) THEN 'Office group'
           WHEN e.department_id IN (50, 80)     THEN 'Operations group'
           ELSE 'Other group'
       END AS department_group
FROM employees e;


-- ============================================================
-- Mini summary
-- ============================================================
-- Searched CASE checks complete conditions
-- and returns the result of the first TRUE condition.
--
-- Syntax:
--   CASE
--       WHEN condition_1 THEN result_1
--       WHEN condition_2 THEN result_2
--       ELSE default_result
--   END
--
-- Important:
--   there is no expression directly after CASE;
--   every WHEN contains a complete condition;
--   conditions are checked from top to bottom;
--   first TRUE condition wins;
--   FALSE and UNKNOWN conditions are skipped;
--   ELSE is optional;
--   without TRUE condition and ELSE, result is NULL;
--   THEN and ELSE results must have compatible types;
--   condition order matters when conditions overlap;
--   CASE in SELECT does not change table data.
