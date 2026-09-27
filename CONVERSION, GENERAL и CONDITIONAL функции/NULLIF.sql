-- ============================================================
-- Conditional functions
-- NULLIF
-- ============================================================
-- NULLIF is a single-row conditional function.
--
-- Простыми словами:
--   NULLIF compares two values.
--
-- If the values are equal,
-- NULLIF returns NULL.
--
-- If the values are not equal,
-- NULLIF returns the first value.
--
-- В этом уроке только NULLIF.
-- Other conditional functions будут отдельными темами.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   NULLIF(value_1, value_2)
--
-- Где:
--   value_1 - first value and possible final result;
--   value_2 - value used for comparison.
--
-- Both arguments are required.
--
-- Short rule:
--
--   value_1 = value_2  -> NULL
--   value_1 != value_2 -> value_1


-- ============================================================
-- Equal values
-- ============================================================
-- If both values are equal,
-- NULLIF returns NULL.
--
-- Пример:
SELECT NULLIF(18, 18) AS result
FROM dual;

-- Result:
--   NULL
--
-- Oracle compares 18 with 18.
-- They are equal, so result becomes NULL.


-- ============================================================
-- Different values
-- ============================================================
-- If values are different,
-- NULLIF returns the first value.
--
-- Пример:
SELECT NULLIF(17, 18) AS result
FROM dual;

-- Result:
--   17
--
-- Oracle does not return the second value.
-- The second argument is used only for comparison.


-- ============================================================
-- The result is never the second argument
-- ============================================================
-- NULLIF has only two possible results:
--   NULL;
--   value_1.
--
-- Пример:
SELECT NULLIF(100, 200) AS result
FROM dual;

-- Result:
--   100
--
-- Result cannot be 200 because value_2
-- is never returned by NULLIF.


-- ============================================================
-- Result data type
-- ============================================================
-- When values are different,
-- result comes from value_1.
--
-- For character and date examples in this lesson,
-- the result type follows the first argument.
--
-- When both arguments are numeric,
-- Oracle can use numeric precedence to choose a common type.
-- For predictable beginner examples,
-- use arguments of the same data type.
--
-- Numeric example:
SELECT NULLIF(10, 20) AS numeric_result
FROM dual;

-- Character example:
SELECT NULLIF('Oracle', 'SQL') AS character_result
FROM dual;

-- Date example:
SELECT NULLIF(hire_date, TO_DATE('01-01-2000', 'DD-MM-YYYY')) AS date_result
FROM employees;


-- ============================================================
-- Arguments must be comparable
-- ============================================================
-- Oracle must be able to compare value_1 with value_2.
--
-- Use values with the same or compatible data types:
--   NUMBER with NUMBER;
--   text with text;
--   DATE with DATE.
--
-- This makes the comparison clear and predictable.


-- ============================================================
-- NUMBER and text are different types
-- ============================================================
-- Concatenation operator || returns character text.
--
-- Expression:
--   1 || 5
--
-- Result:
--   '15' as VARCHAR2.
--
-- Therefore, this is a bad comparison:
--
-- SELECT NULLIF(15, 1 || 5)
-- FROM dual;
--
-- First argument is NUMBER.
-- Second argument is VARCHAR2.
-- Oracle can raise a data type error.
--
-- Correct numeric version:
SELECT NULLIF(15, TO_NUMBER(1 || 5)) AS result
FROM dual;

-- Both arguments are NUMBER.


-- ============================================================
-- Convert both values to text when comparing text
-- ============================================================
-- This comparison also mixes data types:
--
-- SELECT NULLIF(1 || 8, 18)
-- FROM dual;
--
-- 1 || 8 returns VARCHAR2,
-- but 18 is NUMBER.
--
-- Correct character version:
SELECT NULLIF(1 || 8, TO_CHAR(18)) AS result
FROM dual;

-- Both arguments contain text '18'.
-- Result is NULL because they are equal.


-- ============================================================
-- Character literal and numeric literal
-- ============================================================
-- This is also a mixed comparison:
--
-- SELECT NULLIF('18', 18)
-- FROM dual;
--
-- '18' is VARCHAR2.
-- 18 is NUMBER.
--
-- Correct text comparison:
SELECT NULLIF('18', TO_CHAR(18)) AS result
FROM dual;

-- Correct numeric comparison:
SELECT NULLIF(TO_NUMBER('18'), 18) AS result
FROM dual;

-- In both versions the values are equal,
-- so result is NULL.


-- ============================================================
-- Comparing text that looks like dates
-- ============================================================
-- These values are text, not DATE:
SELECT NULLIF('18-SEP-87', '18/09/87') AS result
FROM dual;

-- Result:
--   18-SEP-87
--
-- The strings may describe the same calendar date,
-- but their characters are different.
-- NULLIF performs a text comparison here.


-- ============================================================
-- Comparing real DATE values
-- ============================================================
-- Convert both text values to DATE
-- before comparing their date meaning.
--
-- Пример:
SELECT NULLIF(
           TO_DATE('18-09-1987', 'DD-MM-YYYY'),
           TO_DATE('1987/09/18', 'YYYY/MM/DD')
       ) AS result
FROM dual;

-- Result:
--   NULL
--
-- Both TO_DATE calls create the same DATE value.
-- Different source formats do not matter after conversion.


-- ============================================================
-- Avoid implicit date conversion
-- ============================================================
-- Do not rely on examples such as:
--
-- SELECT NULLIF(TO_DATE('18-SEP-87'), TO_DATE('18/SEP/87'))
-- FROM dual;
--
-- Without format masks, conversion depends
-- on NLS_DATE_FORMAT of the current session.
--
-- Better:
SELECT NULLIF(
           TO_DATE('18-09-1987', 'DD-MM-YYYY'),
           TO_DATE('1987/09/18', 'YYYY/MM/DD')
       ) AS result
FROM dual;


-- ============================================================
-- NULL as the first argument
-- ============================================================
-- Oracle does not allow literal NULL directly
-- as the first argument of NULLIF.
--
-- Invalid example:
--
-- SELECT NULLIF(NULL, 18)
-- FROM dual;
--
-- A column or expression can still produce NULL at runtime.
--
-- Пример:
SELECT employee_id,
       commission_pct,
       NULLIF(commission_pct, 0) AS commission_result
FROM employees;

-- If commission_pct is already NULL,
-- result remains NULL.


-- ============================================================
-- NULL as the second argument
-- ============================================================
-- The second argument may be NULL.
-- A non-NULL first value is not equal to NULL.
--
-- Пример:
SELECT NULLIF(18, NULL) AS result
FROM dual;

-- Result:
--   18
--
-- Because equality with NULL is not TRUE,
-- NULLIF returns the first value.


-- ============================================================
-- Turning a specific value into NULL
-- ============================================================
-- NULLIF is useful when one special value
-- should be treated as missing.
--
-- Пример:
SELECT e.employee_id,
       e.commission_pct,
       NULLIF(e.commission_pct, 0) AS normalized_commission
FROM employees e;

-- If commission_pct is 0:
--   result becomes NULL.
--
-- If commission_pct has another value:
--   that value is returned.


-- ============================================================
-- Masking one category
-- ============================================================
-- A particular character value can be converted to NULL.
--
-- Пример:
SELECT e.employee_id,
       e.job_id,
       NULLIF(e.job_id, 'SA_REP') AS job_except_sales_rep
FROM employees e;

-- For job_id = 'SA_REP':
--   result is NULL.
--
-- For other job_id values:
--   original job_id is returned.


-- ============================================================
-- Preventing division by zero
-- ============================================================
-- Division by zero causes an error.
-- NULLIF can turn a zero denominator into NULL.
--
-- Пример:
SELECT e.employee_id,
       e.salary,
       e.employee_id - 100 AS denominator,
       e.salary / NULLIF(e.employee_id - 100, 0) AS safe_result
FROM employees e;

-- For employee_id = 100:
--   employee_id - 100 is 0;
--   NULLIF(0, 0) returns NULL;
--   salary / NULL returns NULL instead of division-by-zero error.
--
-- For other rows:
--   denominator is returned and division continues.


-- ============================================================
-- Comparing calculated values
-- ============================================================
-- Arguments can be expressions and function results.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       NULLIF(LENGTH(e.first_name), LENGTH(e.last_name)) AS length_difference_check
FROM employees e;

-- If both names have the same length:
--   result is NULL.
--
-- If lengths are different:
--   result is LENGTH(first_name).


-- ============================================================
-- Character comparison is exact
-- ============================================================
-- Letter case can make text values different.
--
-- Пример:
SELECT NULLIF('Oracle', 'ORACLE') AS result
FROM dual;

-- Result:
--   Oracle
--
-- To compare without letter-case difference,
-- apply the same function to both values:
SELECT NULLIF(UPPER('Oracle'), UPPER('ORACLE')) AS result
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- Spaces can affect comparison
-- ============================================================
-- Extra spaces can make character values different.
--
-- Пример:
SELECT NULLIF(' Oracle ', 'Oracle') AS result
FROM dual;

-- Result keeps the first text because spaces are different.
--
-- Normalize both values before comparison:
SELECT NULLIF(TRIM(' Oracle '), TRIM('Oracle')) AS result
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- Comparing country code with country name prefix
-- ============================================================
-- country_id can be compared with the first two letters
-- of country_name converted to uppercase.
--
-- Пример:
SELECT c.country_id,
       c.country_name,
       UPPER(SUBSTR(c.country_name, 1, 2)) AS name_prefix,
       NULLIF(
           c.country_id,
           UPPER(SUBSTR(c.country_name, 1, 2))
       ) AS comparison_result
FROM countries c;

-- If country_id matches name_prefix:
--   comparison_result is NULL.
--
-- If they do not match:
--   comparison_result contains country_id.


-- ============================================================
-- NULLIF with NVL2
-- ============================================================
-- NVL2 can translate NULLIF result into a readable status.
--
-- Пример:
SELECT c.country_id,
       c.country_name,
       NVL2(
           NULLIF(
               c.country_id,
               UPPER(SUBSTR(c.country_name, 1, 2))
           ),
           'Match not found',
           'Match found'
       ) AS comparison_status
FROM countries c;

-- Evaluation:
--   SUBSTR takes first two letters of country_name;
--   UPPER converts them to uppercase;
--   NULLIF compares prefix with country_id;
--   NVL2 converts comparison result to a text status.
--
-- If NULLIF returns NULL:
--   values are equal;
--   NVL2 returns 'Match found'.
--
-- If NULLIF returns country_id:
--   values are different;
--   NVL2 returns 'Match not found'.


-- ============================================================
-- NULLIF does not change table data
-- ============================================================
-- NULLIF only creates a calculated result.
--
-- Пример:
SELECT e.employee_id,
       e.job_id AS original_job_id,
       NULLIF(e.job_id, 'SA_REP') AS calculated_job_id
FROM employees e;

-- original_job_id remains stored in the table.
-- calculated_job_id can be NULL only in the query result.


-- ============================================================
-- Alias for NULLIF result
-- ============================================================
-- Use an alias that explains the comparison result.
--
-- Пример:
SELECT e.employee_id,
       NULLIF(e.manager_id, 100) AS manager_except_100
FROM employees e;

-- A clear alias is especially useful
-- because NULLIF expression can otherwise be hard to read.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Thinking that NULLIF returns the second value.
--    It returns only NULL or the first value.
--
-- 2. Reversing the arguments.
--    NULLIF(a, b) returns a when values are different.
--
-- 3. Comparing incompatible data types.
--    Convert both values explicitly to comparable types.
--
-- 4. Comparing date-looking text as real dates.
--    Use TO_DATE with explicit format masks first.
--
-- 5. Using literal NULL as the first argument.
--    Oracle does not allow it in NULLIF.
--
-- 6. Forgetting exact character comparison.
--    Letter case and spaces can change equality.
--
-- 7. Expecting NULLIF to change stored table values.
--    It changes only the calculated query result.
--
-- 8. Forgetting that NULL denominator changes division to NULL.
--    This prevents an error but does not produce a numeric quotient.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Compare equal numbers and return NULL.
SELECT NULLIF(18, 18) AS result
FROM dual;

-- 2. Compare different numbers and return the first number.
SELECT NULLIF(17, 18) AS result
FROM dual;

-- 3. Convert differently formatted date text and compare the dates.
SELECT NULLIF(
           TO_DATE('18-09-1987', 'DD-MM-YYYY'),
           TO_DATE('1987/09/18', 'YYYY/MM/DD')
       ) AS result
FROM dual;

-- 4. Turn commission_pct 0 into NULL.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       NULLIF(e.commission_pct, 0) AS normalized_commission
FROM employees e;

-- 5. Turn job_id 'SA_REP' into NULL.
SELECT e.employee_id,
       e.first_name,
       e.job_id,
       NULLIF(e.job_id, 'SA_REP') AS job_except_sales_rep
FROM employees e;

-- 6. Turn manager_id 100 into NULL.
SELECT e.employee_id,
       e.first_name,
       e.manager_id,
       NULLIF(e.manager_id, 100) AS manager_except_100
FROM employees e;

-- 7. Prevent division by zero for employee_id 100.
SELECT e.employee_id,
       e.salary,
       e.salary / NULLIF(e.employee_id - 100, 0) AS safe_result
FROM employees e;

-- 8. Compare the lengths of first_name and last_name.
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       NULLIF(LENGTH(e.first_name), LENGTH(e.last_name)) AS length_check
FROM employees e;

-- 9. Compare country_id with first two letters of country_name.
SELECT c.country_id,
       c.country_name,
       NULLIF(
           c.country_id,
           UPPER(SUBSTR(c.country_name, 1, 2))
       ) AS comparison_result
FROM countries c;

-- 10. Show a readable country code comparison status.
SELECT c.country_id,
       c.country_name,
       NVL2(
           NULLIF(
               c.country_id,
               UPPER(SUBSTR(c.country_name, 1, 2))
           ),
           'Match not found',
           'Match found'
       ) AS comparison_status
FROM countries c;


-- ============================================================
-- Mini summary
-- ============================================================
-- NULLIF compares two values.
--
-- Syntax:
--   NULLIF(value_1, value_2)
--
-- Important:
--   equal values return NULL;
--   different values return value_1;
--   value_2 is used only for comparison;
--   arguments must be comparable;
--   non-numeric result comes from value_1;
--   numeric arguments can use numeric type precedence;
--   date text should be converted with explicit format masks;
--   character comparison can be affected by case and spaces;
--   NULLIF can turn a special value into NULL;
--   NULLIF can prevent division-by-zero errors;
--   NULLIF in SELECT does not change table data.
