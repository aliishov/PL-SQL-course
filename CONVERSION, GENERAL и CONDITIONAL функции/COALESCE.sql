-- ============================================================
-- General functions
-- COALESCE
-- ============================================================
-- COALESCE is a single-row general function.
--
-- Простыми словами:
--   COALESCE returns the first value that is not NULL.
--
-- Oracle checks arguments from left to right
-- and stops logically at the first non-NULL value.
--
-- If every argument is NULL,
-- result is NULL.
--
-- В этом уроке только COALESCE.
-- Other functions for NULL and conditions
-- рассматриваются в отдельных темах.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   COALESCE(value_1, value_2, ..., value_n)
--
-- COALESCE requires at least two arguments.
-- There can be more than two arguments.
--
-- Each argument is a possible result.
-- Priority is determined by argument position.


-- ============================================================
-- Main idea
-- ============================================================
-- Oracle checks values from left to right.
--
-- Пример:
SELECT COALESCE(1, NULL, 2) AS result
FROM dual;

-- Result:
--   1
--
-- Evaluation:
--   first argument is 1;
--   1 is not NULL;
--   COALESCE returns 1.
--
-- Later arguments are not needed for the final value.


-- ============================================================
-- Skipping NULL values
-- ============================================================
-- COALESCE skips NULL arguments
-- until it finds a non-NULL value.
--
-- Пример:
SELECT COALESCE(NULL, NULL, 2) AS result
FROM dual;

-- Result:
--   2
--
-- Evaluation:
--   first argument is NULL;
--   second argument is NULL;
--   third argument is 2;
--   result is 2.


-- ============================================================
-- First non-NULL value wins
-- ============================================================
-- Values after the first non-NULL value
-- do not replace it.
--
-- Пример:
SELECT COALESCE(NULL, 10, 20, 30) AS result
FROM dual;

-- Result:
--   10
--
-- 20 and 30 are also not NULL,
-- but they have lower priority because they appear later.


-- ============================================================
-- When every argument is NULL
-- ============================================================
-- If COALESCE cannot find a non-NULL value,
-- it returns NULL.
--
-- Пример:
SELECT COALESCE(NULL, NULL, NULL, NULL) AS result
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- Character values
-- ============================================================
-- COALESCE can work with character values.
--
-- Пример:
SELECT COALESCE(NULL, NULL, 'OK', 'Hello') AS result
FROM dual;

-- Result:
--   OK
--
-- 'OK' is the first non-NULL character value.


-- ============================================================
-- Empty string in Oracle
-- ============================================================
-- Oracle treats an empty character string as NULL.
--
-- Пример:
SELECT COALESCE('', NULL, 'No text') AS result
FROM dual;

-- Result:
--   No text
--
-- A string containing a space is not empty:
SELECT COALESCE('', ' ', 'No text') AS result
FROM dual;

-- Result is a space because it is not NULL.


-- ============================================================
-- Arguments must have compatible data types
-- ============================================================
-- All possible returned values must be compatible.
--
-- Good numeric example:
SELECT COALESCE(NULL, 10, 20) AS result
FROM dual;

-- Good character example:
SELECT COALESCE(NULL, 'Oracle', 'SQL') AS result
FROM dual;

-- Bad idea:
--
-- SELECT COALESCE(1, NULL, 'OK')
-- FROM dual;
--
-- Numeric value 1 and non-numeric text 'OK'
-- do not form a safe common result type.
-- Oracle can raise a data type or conversion error.


-- ============================================================
-- Type checking happens before result choice
-- ============================================================
-- The first argument can already be non-NULL,
-- but all possible result expressions still need
-- compatible data types.
--
-- Therefore, this is not safe:
--
-- SELECT COALESCE(1, 'Text')
-- FROM dual;
--
-- Do not assume that later incompatible arguments
-- are ignored during type resolution.


-- ============================================================
-- Explicit conversion for a common type
-- ============================================================
-- If all results should be text,
-- convert numeric values explicitly.
--
-- Пример:
SELECT COALESCE(TO_CHAR(1), NULL, 'OK') AS result
FROM dual;

-- Result:
--   1
--
-- All non-NULL possibilities are now character values.
--
-- If all results should be NUMBER,
-- convert numeric text explicitly:
SELECT COALESCE(1, NULL, TO_NUMBER('2')) AS result
FROM dual;

-- All non-NULL possibilities are NUMBER values.


-- ============================================================
-- Numeric type selection
-- ============================================================
-- When arguments are numeric,
-- Oracle can use numeric precedence to choose a common type.
--
-- For beginner examples, use NUMBER expressions together.
-- This keeps the result type predictable.


-- ============================================================
-- COALESCE with two arguments
-- ============================================================
-- With two compatible arguments,
-- COALESCE often produces the same result as NVL.
--
-- Пример:
SELECT e.employee_id,
       e.commission_pct,
       NVL(e.commission_pct, 0) AS nvl_result,
       COALESCE(e.commission_pct, 0) AS coalesce_result
FROM employees e;

-- If commission_pct exists:
--   both return commission_pct.
--
-- If commission_pct is NULL:
--   both return 0.
--
-- Conceptual difference:
--   NVL accepts exactly two arguments;
--   COALESCE can accept a longer priority list.


-- ============================================================
-- COALESCE is not always identical to NVL
-- ============================================================
-- COALESCE(value_1, value_2) and NVL(value_1, value_2)
-- often return the same value for compatible arguments.
--
-- But their type-conversion and evaluation rules
-- are not identical in every advanced case.
--
-- In this lesson remember:
--   use compatible types;
--   use COALESCE when several fallback values are needed.


-- ============================================================
-- COALESCE with NUMBER columns
-- ============================================================
-- Several numeric columns can form a priority list.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       e.manager_id,
       e.salary,
       COALESCE(
           e.commission_pct,
           e.manager_id,
           e.salary
       ) AS first_available_number
FROM employees e;

-- Priority:
--   1. commission_pct;
--   2. manager_id;
--   3. salary.
--
-- All three columns are numeric,
-- so they can participate in one COALESCE expression.
--
-- This example demonstrates priority.
-- In real work, combined values should also have related meaning.


-- ============================================================
-- COALESCE with character columns
-- ============================================================
-- Character values can also form a fallback chain.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.phone_number,
       e.email,
       COALESCE(
           e.phone_number,
           e.email,
           'No contact'
       ) AS contact_value
FROM employees e;

-- Priority:
--   phone_number first;
--   email second;
--   fixed text last.
--
-- The final constant guarantees a non-NULL result.


-- ============================================================
-- Last argument as a default value
-- ============================================================
-- A common pattern is to place a fixed default last.
--
-- Пример:
SELECT e.employee_id,
       COALESCE(
           e.phone_number,
           e.email,
           'Unknown'
       ) AS contact_value
FROM employees e;

-- Oracle uses 'Unknown' only when
-- all earlier character values are NULL.


-- ============================================================
-- COALESCE with DATE values
-- ============================================================
-- DATE expressions should use DATE fallbacks.
--
-- Пример:
SELECT e.employee_id,
       e.hire_date,
       COALESCE(
           e.hire_date,
           TO_DATE('01-01-2000', 'DD-MM-YYYY')
       ) AS safe_hire_date
FROM employees e;

-- Both possible results are DATE values.


-- ============================================================
-- COALESCE with calculations
-- ============================================================
-- Each argument can be an expression.
--
-- Пример:
SELECT e.employee_id,
       e.salary,
       e.commission_pct,
       COALESCE(
           e.salary * e.commission_pct,
           e.salary * 0.05,
           500
       ) AS bonus
FROM employees e;

-- Priority:
--   1. salary multiplied by commission_pct;
--   2. five percent of salary;
--   3. fixed value 500.
--
-- If commission_pct is NULL,
-- first expression returns NULL
-- and Oracle moves to the second expression.


-- ============================================================
-- Left-to-right short-circuit evaluation
-- ============================================================
-- COALESCE evaluates values using short-circuit logic.
-- It looks for the first non-NULL result from left to right.
--
-- Put the preferred expression first.
-- Put fallback expressions after it in priority order.
--
-- Type compatibility is still checked
-- for the complete COALESCE expression.


-- ============================================================
-- COALESCE with a function result
-- ============================================================
-- A function result can be one of the possible values.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       COALESCE(
           SUBSTR(e.first_name, 6),
           e.first_name,
           'No name'
       ) AS name_value
FROM employees e;

-- If SUBSTR returns text, it has first priority.
-- If SUBSTR returns NULL, original first_name is used.
-- Fixed text is the final fallback.


-- ============================================================
-- COALESCE inside another function
-- ============================================================
-- COALESCE result can become an argument
-- of another single-row function.
--
-- Пример:
SELECT e.employee_id,
       UPPER(
           COALESCE(
               e.phone_number,
               e.email,
               'No contact'
           )
       ) AS contact_value
FROM employees e;

-- Evaluation:
--   COALESCE chooses character value;
--   UPPER processes the chosen value.


-- ============================================================
-- COALESCE with NULLIF
-- ============================================================
-- NULLIF can turn one special value into NULL.
-- COALESCE can then provide a fallback.
--
-- Пример:
SELECT e.employee_id,
       e.job_id,
       COALESCE(
           NULLIF(e.job_id, 'SA_REP'),
           'Hidden job'
       ) AS job_value
FROM employees e;

-- Evaluation:
--   NULLIF returns NULL for job_id = 'SA_REP';
--   COALESCE then returns 'Hidden job'.
--
-- Other job_id values are returned unchanged.


-- ============================================================
-- COALESCE in WHERE
-- ============================================================
-- COALESCE can provide a value used in a condition.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.commission_pct
FROM employees e
WHERE COALESCE(e.commission_pct, 0) > 0;

-- If commission_pct is NULL,
-- COALESCE returns 0.
--
-- Therefore, only rows with a positive commission_pct
-- satisfy this condition.


-- ============================================================
-- COALESCE does not change table data
-- ============================================================
-- COALESCE creates a calculated result only.
--
-- Пример:
SELECT e.employee_id,
       e.commission_pct AS original_commission,
       COALESCE(e.commission_pct, 0) AS displayed_commission
FROM employees e;

-- original_commission remains unchanged in employees.
-- displayed_commission exists only in the query result.


-- ============================================================
-- Alias for COALESCE result
-- ============================================================
-- A long fallback chain should have a clear alias.
--
-- Пример:
SELECT e.employee_id,
       COALESCE(
           e.phone_number,
           e.email,
           'No contact'
       ) AS preferred_contact
FROM employees e;

-- preferred_contact describes the meaning
-- of the final selected value.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Thinking that COALESCE returns the last non-NULL value.
--    It returns the first non-NULL value from the left.
--
-- 2. Ignoring argument order.
--    Earlier values have higher priority.
--
-- 3. Mixing incompatible data types.
--    All possible results must have a compatible common type.
--
-- 4. Expecting a value when all arguments are NULL.
--    Result is NULL unless a non-NULL fallback exists.
--
-- 5. Using only one argument.
--    COALESCE requires at least two arguments.
--
-- 6. Thinking that empty text is not NULL.
--    Oracle treats an empty string as NULL.
--
-- 7. Assuming COALESCE with two arguments
--    is identical to NVL in every technical detail.
--
-- 8. Thinking that COALESCE changes stored values.
--    It returns a calculated value only.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Return the first non-NULL number.
SELECT COALESCE(1, NULL, 2) AS result
FROM dual;

-- 2. Skip two NULL values and return 2.
SELECT COALESCE(NULL, NULL, 2) AS result
FROM dual;

-- 3. Return NULL when every argument is NULL.
SELECT COALESCE(NULL, NULL, NULL, NULL) AS result
FROM dual;

-- 4. Choose the first available numeric employee value.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       e.manager_id,
       e.salary,
       COALESCE(
           e.commission_pct,
           e.manager_id,
           e.salary
       ) AS first_available_number
FROM employees e;

-- 5. Choose phone_number, email or fixed contact text.
SELECT e.employee_id,
       e.first_name,
       COALESCE(
           e.phone_number,
           e.email,
           'No contact'
       ) AS preferred_contact
FROM employees e;

-- 6. Calculate commission, five percent bonus or fixed bonus.
SELECT e.employee_id,
       e.salary,
       e.commission_pct,
       COALESCE(
           e.salary * e.commission_pct,
           e.salary * 0.05,
           500
       ) AS bonus
FROM employees e;

-- 7. Return hire_date or a default DATE value.
SELECT e.employee_id,
       e.hire_date,
       COALESCE(
           e.hire_date,
           TO_DATE('01-01-2000', 'DD-MM-YYYY')
       ) AS safe_hire_date
FROM employees e;

-- 8. Use SUBSTR result, original first_name or fixed text.
SELECT e.employee_id,
       e.first_name,
       COALESCE(
           SUBSTR(e.first_name, 6),
           e.first_name,
           'No name'
       ) AS name_value
FROM employees e;

-- 9. Replace job_id 'SA_REP' through NULLIF and COALESCE.
SELECT e.employee_id,
       e.job_id,
       COALESCE(
           NULLIF(e.job_id, 'SA_REP'),
           'Hidden job'
       ) AS job_value
FROM employees e;

-- 10. Find employees with a positive commission_pct.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct
FROM employees e
WHERE COALESCE(e.commission_pct, 0) > 0;


-- ============================================================
-- Mini summary
-- ============================================================
-- COALESCE returns the first non-NULL value from the left.
--
-- Syntax:
--   COALESCE(value_1, value_2, ..., value_n)
--
-- Important:
--   at least two arguments are required;
--   arguments are checked in left-to-right priority order;
--   the first non-NULL value becomes the result;
--   later values are fallbacks;
--   all NULL arguments produce NULL;
--   result expressions must have compatible data types;
--   empty string is NULL in Oracle;
--   with two compatible arguments, result often matches NVL;
--   COALESCE is useful for longer fallback chains;
--   COALESCE in SELECT does not change table data.
