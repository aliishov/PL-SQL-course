-- ============================================================
-- General functions
-- NVL
-- ============================================================
-- NVL is a single-row general function.
--
-- Простыми словами:
--   NVL replaces NULL with another value.
--
-- If the first value is not NULL,
-- NVL returns the first value.
--
-- If the first value is NULL,
-- NVL returns the second value.
--
-- В этом уроке только NVL.
-- Other functions for working with NULL
-- будут рассматриваться в отдельных темах.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   NVL(value, value_if_null)
--
-- Где:
--   value          - value that Oracle checks for NULL;
--   value_if_null  - replacement returned when value is NULL.
--
-- Both arguments are required.


-- ============================================================
-- Main idea
-- ============================================================
-- Case 1:
--   first value is not NULL.
--
-- Пример:
SELECT NVL(18, 19) AS result
FROM dual;

-- Result:
--   18
--
-- Oracle keeps 18 because it is not NULL.
-- Replacement 19 is not returned.


-- ============================================================
-- When the first value is NULL
-- ============================================================
-- Case 2:
--   first value is NULL.
--
-- Пример:
SELECT NVL(NULL, 19) AS result
FROM dual;

-- Result:
--   19
--
-- Oracle returns the replacement value
-- because the first argument is NULL.


-- ============================================================
-- When both values are NULL
-- ============================================================
-- If both arguments are NULL,
-- NVL also returns NULL.
--
-- Пример:
SELECT NVL(NULL, NULL) AS result
FROM dual;

-- Result:
--   NULL
--
-- NVL cannot produce a non-NULL result
-- when the replacement itself is NULL.


-- ============================================================
-- NULL is not zero
-- ============================================================
-- NULL means that a value is missing or unknown.
-- It is not the same as number 0.
--
-- Пример:
SELECT NVL(0, 100) AS result
FROM dual;

-- Result:
--   0
--
-- Oracle keeps 0 because 0 is a real numeric value.


-- ============================================================
-- Empty string in Oracle
-- ============================================================
-- Oracle treats an empty character string as NULL.
--
-- Пример:
SELECT NVL('', 'No text') AS result
FROM dual;

-- Result:
--   No text
--
-- A string containing a space is different:
SELECT NVL(' ', 'No text') AS result
FROM dual;

-- Oracle keeps the space because it contains a character.


-- ============================================================
-- NVL with a NUMBER column
-- ============================================================
-- commission_pct can contain NULL.
-- NVL can show 0 instead of missing commission.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       NVL(e.commission_pct, 0) AS commission_value
FROM employees e;

-- If commission_pct has a value,
-- commission_value contains the same value.
--
-- If commission_pct is NULL,
-- commission_value contains 0.
--
-- The table is not changed.
-- NVL only changes the value returned by this query.


-- ============================================================
-- NVL with a character column
-- ============================================================
-- Character NULL can be replaced with text.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.phone_number,
       NVL(e.phone_number, 'No phone') AS phone_value
FROM employees e;

-- phone_value is always character data:
--   original phone number;
--   or text 'No phone'.


-- ============================================================
-- NVL with a DATE column
-- ============================================================
-- DATE value should be replaced with another DATE value.
--
-- Пример:
SELECT e.employee_id,
       e.hire_date,
       NVL(e.hire_date, TO_DATE('01-01-2000', 'DD-MM-YYYY')) AS safe_hire_date
FROM employees e;

-- hire_date and replacement have compatible DATE type.
-- TO_DATE explicitly creates the replacement DATE.


-- ============================================================
-- Arguments must have compatible data types
-- ============================================================
-- The original value and replacement should have
-- the same or compatible data types.
--
-- Good numeric example:
SELECT NVL(commission_pct, 0) AS commission_value
FROM employees;

-- Good character example:
SELECT NVL(phone_number, 'No phone') AS phone_value
FROM employees;

-- Bad idea:
--
-- SELECT NVL(commission_pct, 'No commission')
-- FROM employees;
--
-- commission_pct is NUMBER,
-- but 'No commission' is non-numeric text.
-- Oracle can raise a conversion error.


-- ============================================================
-- Result data type
-- ============================================================
-- NVL returns one value from two possible arguments.
-- Oracle must produce one compatible result type.
--
-- For clear and predictable code:
--   NUMBER value -> use NUMBER replacement;
--   VARCHAR2 value -> use character replacement;
--   DATE value -> use DATE replacement.
--
-- Do not depend on hidden conversion between unrelated types.


-- ============================================================
-- NULL in calculations
-- ============================================================
-- A calculation with NULL usually returns NULL.
--
-- Пример:
SELECT e.employee_id,
       e.salary,
       e.commission_pct,
       e.salary * e.commission_pct AS commission_amount
FROM employees e;

-- If commission_pct is NULL,
-- commission_amount is also NULL.
--
-- NVL can replace NULL before the calculation:
SELECT e.employee_id,
       e.salary,
       e.commission_pct,
       e.salary * NVL(e.commission_pct, 0) AS commission_amount
FROM employees e;

-- If commission_pct is NULL,
-- NVL returns 0 and the calculation returns 0.


-- ============================================================
-- Replacing the result of a calculation
-- ============================================================
-- NVL can also check the result after calculation.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.commission_pct,
       NVL(e.salary * e.commission_pct, 500) AS bonus
FROM employees e;

-- Evaluation:
--   salary * commission_pct is calculated first;
--   NVL checks the calculation result;
--   if result is NULL, NVL returns 500.


-- ============================================================
-- Placement of NVL changes the result
-- ============================================================
-- These expressions have different business meaning.
--
-- Variant 1:
SELECT e.employee_id,
       NVL(e.salary * e.commission_pct, 500) AS bonus
FROM employees e;

-- If commission_pct is NULL:
--   calculation result is NULL;
--   final bonus becomes 500.
--
-- Variant 2:
SELECT e.employee_id,
       e.salary * NVL(e.commission_pct, 0) AS bonus
FROM employees e;

-- If commission_pct is NULL:
--   commission_pct becomes 0;
--   final bonus becomes 0.
--
-- Choose the expression that matches the required logic.


-- ============================================================
-- NVL with a function result
-- ============================================================
-- NVL can check a value returned by another function.
--
-- Пример:
SELECT e.first_name,
       SUBSTR(e.first_name, 6) AS name_part,
       NVL(SUBSTR(e.first_name, 6), 'Name is too short') AS safe_name_part
FROM employees e;

-- If first_name has fewer than 6 characters,
-- SUBSTR(first_name, 6) returns NULL.
--
-- NVL then returns:
--   'Name is too short'.
--
-- This is a nested function expression:
--   SUBSTR is evaluated first;
--   NVL is evaluated after it.


-- ============================================================
-- NVL inside another function
-- ============================================================
-- NVL result can become an argument of an outer function.
--
-- Пример:
SELECT e.employee_id,
       UPPER(NVL(e.phone_number, 'No phone')) AS phone_text
FROM employees e;

-- Evaluation:
--   NVL replaces NULL if needed;
--   UPPER processes the resulting text.


-- ============================================================
-- NVL in WHERE
-- ============================================================
-- NVL can be used in a condition.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.commission_pct
FROM employees e
WHERE NVL(e.commission_pct, 0) = 0;

-- This condition finds rows where commission_pct is:
--   NULL;
--   or actually equal to 0.
--
-- Important:
--   NVL combines these two cases into the same result.
-- If they must be distinguished, check NULL separately.


-- ============================================================
-- NVL in SELECT list
-- ============================================================
-- The most common use of NVL is to display
-- a replacement instead of NULL in query output.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       NVL(e.commission_pct, 0) AS commission_pct,
       NVL(e.manager_id, 0) AS manager_id
FROM employees e;

-- Original columns in employees remain unchanged.
-- Replacements exist only in the result set.


-- ============================================================
-- Alias for NVL result
-- ============================================================
-- Give calculated output a clear alias.
--
-- Пример:
SELECT e.first_name,
       NVL(e.commission_pct, 0) AS commission_value
FROM employees e;

-- commission_value explains that this is the value
-- returned after NULL replacement.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Thinking that NVL changes data in the table.
--    NVL only returns a calculated value in the query result.
--
-- 2. Thinking that 0 is NULL.
--    Zero is a real numeric value and is not replaced.
--
-- 3. Using incompatible argument types.
--    NUMBER should use numeric replacement,
--    text should use character replacement,
--    DATE should use date replacement.
--
-- 4. Forgetting NULL arithmetic.
--    Any arithmetic expression with NULL can return NULL.
--
-- 5. Placing NVL in the wrong part of a calculation.
--    NVL(expression, 500) and expression with NVL(value, 0)
--    can produce different results.
--
-- 6. Expecting NVL(NULL, NULL) to return a value.
--    It returns NULL because replacement is also NULL.
--
-- 7. Forgetting that empty text is NULL in Oracle.
--    NVL('', 'text') returns the replacement.
--
-- 8. Hiding two different cases in WHERE.
--    NVL(column, 0) = 0 matches both NULL and real zero.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Keep 18 because it is not NULL.
SELECT NVL(18, 19) AS result
FROM dual;

-- 2. Replace NULL with number 19.
SELECT NVL(NULL, 19) AS result
FROM dual;

-- 3. Replace an empty string with text 'No value'.
SELECT NVL('', 'No value') AS result
FROM dual;

-- 4. Show 0 instead of NULL commission_pct.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       NVL(e.commission_pct, 0) AS commission_value
FROM employees e;

-- 5. Return bonus 500 when salary * commission_pct is NULL.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.commission_pct,
       NVL(e.salary * e.commission_pct, 500) AS bonus
FROM employees e;

-- 6. Replace NULL commission_pct with 0 before multiplication.
SELECT e.employee_id,
       e.salary,
       e.commission_pct,
       e.salary * NVL(e.commission_pct, 0) AS commission_amount
FROM employees e;

-- 7. Show a message when SUBSTR returns NULL.
SELECT e.employee_id,
       e.first_name,
       NVL(SUBSTR(e.first_name, 6), 'Name is too short') AS name_part
FROM employees e;

-- 8. Show 0 when manager_id is NULL.
SELECT e.employee_id,
       e.first_name,
       e.manager_id,
       NVL(e.manager_id, 0) AS manager_value
FROM employees e;

-- 9. Show 'No phone' when phone_number is NULL.
SELECT e.employee_id,
       e.first_name,
       NVL(e.phone_number, 'No phone') AS phone_value
FROM employees e;

-- 10. Find employees whose commission_pct is NULL or 0.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct
FROM employees e
WHERE NVL(e.commission_pct, 0) = 0;


-- ============================================================
-- Mini summary
-- ============================================================
-- NVL replaces NULL with another value.
--
-- Syntax:
--   NVL(value, value_if_null)
--
-- Important:
--   if value is not NULL, NVL returns value;
--   if value is NULL, NVL returns value_if_null;
--   if both arguments are NULL, result is NULL;
--   NULL is not the same as 0;
--   Oracle treats an empty string as NULL;
--   arguments should have compatible data types;
--   NVL can be used with columns, expressions and function results;
--   position of NVL inside a calculation can change the result;
--   NVL in SELECT does not change table data.
