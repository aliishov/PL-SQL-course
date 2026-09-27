-- ============================================================
-- Single-row functions
-- Nested functions
-- ============================================================
-- Nested function means:
--   one function is used inside another function.
--
-- Простыми словами:
--   result of inner function becomes an argument
--   for the outer function.
--
-- General form:
--
--   OUTER_FUNCTION(INNER_FUNCTION(value))
--
-- В этом уроке рассматривается только вложение
-- уже изученных single-row functions.


-- ============================================================
-- Main idea
-- ============================================================
-- Пример:
SELECT LENGTH(UPPER('Oracle')) AS result
FROM dual;

-- Oracle evaluates this expression from inside to outside.
--
-- Step 1:
--   UPPER('Oracle')
--   Result: 'ORACLE'
--
-- Step 2:
--   LENGTH('ORACLE')
--   Result: 6
--
-- Final result:
--   6


-- ============================================================
-- Evaluation order
-- ============================================================
-- The innermost function is evaluated first.
-- Then Oracle passes its result to the next function.
--
-- Pattern:
--
--   function_3(function_2(function_1(value)))
--
-- Order:
--   1. function_1(value)
--   2. function_2(result_of_function_1)
--   3. function_3(result_of_function_2)
--
-- Read a nested expression from the deepest parentheses
-- toward the outside.


-- ============================================================
-- Nesting depth
-- ============================================================
-- Depth shows how many function levels are placed
-- one inside another.
--
-- One level:
SELECT UPPER('Oracle') AS result
FROM dual;

-- Two levels:
SELECT LENGTH(UPPER('Oracle')) AS result
FROM dual;

-- Three levels:
SELECT LENGTH(UPPER(TRIM('  Oracle  '))) AS result
FROM dual;

-- Evaluation of the three-level expression:
--   TRIM  -> 'Oracle'
--   UPPER -> 'ORACLE'
--   LENGTH -> 6


-- ============================================================
-- Result type moves to the next function
-- ============================================================
-- Every function returns a value with a data type.
-- The outer function receives that value as its argument.
--
-- Пример:
SELECT LENGTH(UPPER(first_name)) AS name_length
FROM employees;

-- Type flow:
--   first_name               -> VARCHAR2;
--   UPPER(first_name)        -> VARCHAR2;
--   LENGTH(UPPER(...))       -> NUMBER.
--
-- Final expression type is NUMBER
-- because the outer function LENGTH returns NUMBER.


-- ============================================================
-- Compatible data types
-- ============================================================
-- Functions can be nested only when the inner result
-- is valid for the outer function argument.
--
-- Correct chain:
SELECT TO_CHAR(ADD_MONTHS(hire_date, 6), 'DD-MON-YYYY') AS review_date
FROM employees;

-- Type flow:
--   hire_date                -> DATE;
--   ADD_MONTHS(...)          -> DATE;
--   TO_CHAR(DATE, format)    -> VARCHAR2.
--
-- ADD_MONTHS returns DATE,
-- and TO_CHAR can receive DATE.


-- ============================================================
-- Incompatible data types
-- ============================================================
-- This expression is logically incorrect:
--
-- SELECT SUBSTR(SYSDATE, ADD_MONTHS(SYSDATE, 3))
-- FROM dual;
--
-- Problems:
--   SUBSTR expects text as the first argument;
--   SUBSTR expects NUMBER as the position argument;
--   ADD_MONTHS returns DATE, not NUMBER.
--
-- Nesting parentheses is not enough.
-- Result type of each inner function must match
-- what the outer function expects.


-- ============================================================
-- Avoid hidden conversions
-- ============================================================
-- Example such as LENGTH(SYSDATE) asks Oracle
-- to convert DATE to text implicitly.
-- Result can depend on NLS_DATE_FORMAT.
--
-- Clear version:
SELECT LENGTH(TO_CHAR(SYSDATE, 'DD-MM-YYYY')) AS date_text_length
FROM dual;

-- Evaluation:
--   TO_CHAR converts DATE to text using explicit format;
--   LENGTH counts characters in that text.
--
-- Result:
--   10


-- ============================================================
-- Nested character functions
-- ============================================================
-- Character functions can be combined
-- when their input and output types are compatible.
--
-- Пример:
SELECT first_name,
       LOWER(SUBSTR(first_name, 1, 3)) AS short_name
FROM employees;

-- Evaluation:
--   SUBSTR takes first 3 characters;
--   LOWER converts those characters to lowercase.


-- ============================================================
-- TRIM, UPPER and LENGTH
-- ============================================================
-- Several character functions can form one chain.
--
-- Пример:
SELECT LENGTH(UPPER(TRIM('  Oracle SQL  '))) AS result
FROM dual;

-- Step 1:
--   TRIM removes spaces at the beginning and end.
--
-- Step 2:
--   UPPER changes letters to uppercase.
--
-- Step 3:
--   LENGTH counts characters.


-- ============================================================
-- Nested numeric and character functions
-- ============================================================
-- Inner function can return NUMBER
-- for a numeric argument of another function.
--
-- Пример:
SELECT first_name,
       LENGTH(first_name) AS name_length,
       ROUND(123.456789123456, LENGTH(first_name)) AS rounded_number
FROM employees;

-- Evaluation for every row:
--   LENGTH(first_name) returns number of characters;
--   ROUND uses that number as decimal precision.
--
-- Because first_name is different in each row,
-- precision can also be different in each row.


-- ============================================================
-- One inner result as a position
-- ============================================================
-- A function result can become the position argument of SUBSTR.
--
-- Пример:
SELECT first_name,
       employee_id,
       LENGTH(TO_CHAR(employee_id)) AS id_length,
       SUBSTR(first_name, LENGTH(TO_CHAR(employee_id))) AS name_part
FROM employees;

-- Evaluation:
--   TO_CHAR converts employee_id to text;
--   LENGTH counts digits in that text;
--   SUBSTR uses the count as start position.
--
-- TO_CHAR is explicit because employee_id is NUMBER
-- and LENGTH is intended to count its displayed digits.


-- ============================================================
-- Reusing a nested expression
-- ============================================================
-- The same expression can be nested one level deeper.
--
-- Пример:
SELECT first_name,
       employee_id,
       SUBSTR(first_name, LENGTH(TO_CHAR(employee_id))) AS name_part,
       LENGTH(
           SUBSTR(first_name, LENGTH(TO_CHAR(employee_id)))
       ) AS name_part_length
FROM employees;

-- Evaluation of name_part_length:
--   TO_CHAR(employee_id)
--   -> LENGTH(...)
--   -> SUBSTR(...)
--   -> outer LENGTH(...)


-- ============================================================
-- Nested date conversion and formatting
-- ============================================================
-- Text can first become DATE,
-- then DATE can become formatted text.
--
-- Пример:
SELECT TO_DATE('18-09-1987', 'DD-MM-YYYY') AS date_value,
       TO_CHAR(
           TO_DATE('18-09-1987', 'DD-MM-YYYY'),
           'DAY'
       ) AS day_name
FROM dual;

-- Evaluation:
--   TO_DATE converts text to DATE;
--   TO_CHAR converts that DATE to day name text.


-- ============================================================
-- Three levels with a date
-- ============================================================
-- Another outer function can process formatted date text.
--
-- Пример:
SELECT LENGTH(
           TO_CHAR(
               TO_DATE('18-09-1987', 'DD-MM-YYYY'),
               'FMDAY'
           )
       ) AS day_name_length
FROM dual;

-- Evaluation:
--   TO_DATE -> DATE;
--   TO_CHAR -> VARCHAR2 day name;
--   LENGTH  -> NUMBER of characters.
--
-- FM removes extra spaces added by DAY format.


-- ============================================================
-- Function inside one of several arguments
-- ============================================================
-- Inner function does not have to be the first argument.
--
-- Пример:
SELECT first_name,
       ROUND(salary / 12, LENGTH(first_name)) AS monthly_salary
FROM employees;

-- ROUND has two arguments:
--   salary / 12;
--   LENGTH(first_name).
--
-- LENGTH is nested inside the second argument of ROUND.


-- ============================================================
-- Several inner functions in one outer function
-- ============================================================
-- Different arguments can contain their own functions.
--
-- Пример:
SELECT CONCAT(
           UPPER(first_name),
           CONCAT(' ', INITCAP(last_name))
       ) AS full_name
FROM employees;

-- Oracle evaluates UPPER and INITCAP,
-- then inner CONCAT,
-- then outer CONCAT.


-- ============================================================
-- Nested functions with phone_number
-- ============================================================
-- Character result can be converted to NUMBER
-- if all non-numeric characters are removed first.
--
-- Пример:
SELECT employee_id,
       phone_number,
       TO_NUMBER(REPLACE(phone_number, '.', '')) AS phone_as_number
FROM employees
WHERE employee_id < 130
  AND phone_number IS NOT NULL;

-- Evaluation:
--   REPLACE removes dots from phone_number text;
--   TO_NUMBER converts remaining digits to NUMBER.
--
-- This works only when the remaining text contains digits.
-- If other symbols remain, TO_NUMBER can raise an error.


-- ============================================================
-- Alias for nested expressions
-- ============================================================
-- Nested expressions can become long.
-- Use a clear alias for the final result.
--
-- Пример:
SELECT first_name,
       LENGTH(LOWER(first_name)) AS lowercase_name_length
FROM employees;

-- Alias describes the final value,
-- not every internal calculation step.


-- ============================================================
-- Formatting nested expressions
-- ============================================================
-- Short expression can stay on one line:
SELECT LENGTH(UPPER(first_name)) AS name_length
FROM employees;

-- Long expression is easier to read on several lines:
SELECT LENGTH(
           TO_CHAR(
               ADD_MONTHS(hire_date, 6),
               'DD-MON-YYYY'
           )
       ) AS review_date_length
FROM employees;

-- Indentation shows which function belongs
-- inside which parentheses.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Reading expression from left to right.
--    Start with the innermost function.
--
-- 2. Ignoring result data types.
--    Inner result must be valid for the outer argument.
--
-- 3. Relying on implicit conversion.
--    Use TO_CHAR, TO_DATE or TO_NUMBER explicitly when needed.
--
-- 4. Losing track of parentheses.
--    Format long nested expressions on multiple lines.
--
-- 5. Forgetting that calculation happens for every row.
--    With employees columns, result can differ by row.
--
-- 6. Using too many levels without need.
--    Nest functions only when every step has a clear purpose.
--
-- 7. Forgetting an alias.
--    A clear alias makes the final result easier to understand.
--
-- 8. Assuming that nesting changes table data.
--    Functions in SELECT return calculated values only.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Convert current date to text and count its characters.
SELECT LENGTH(TO_CHAR(SYSDATE, 'DD-MM-YYYY')) AS date_text_length
FROM dual;

-- 2. Convert current day name to uppercase and count its characters.
SELECT LENGTH(UPPER(TO_CHAR(SYSDATE, 'FMDAY'))) AS day_name_length
FROM dual;

-- 3. Convert date text to DATE and show its day name.
SELECT TO_CHAR(
           TO_DATE('18-09-1987', 'DD-MM-YYYY'),
           'FMDAY'
       ) AS day_name
FROM dual;

-- 4. Show first 3 letters of each first_name in lowercase.
SELECT employee_id,
       first_name,
       LOWER(SUBSTR(first_name, 1, 3)) AS short_name
FROM employees;

-- 5. Remove outer spaces from last_name and count its characters.
SELECT employee_id,
       last_name,
       LENGTH(TRIM(last_name)) AS last_name_length
FROM employees;

-- 6. Use first_name length as precision for ROUND.
SELECT first_name,
       LENGTH(first_name) AS name_length,
       ROUND(123.456789123456, LENGTH(first_name)) AS rounded_number
FROM employees;

-- 7. Use employee_id length as start position in first_name.
SELECT employee_id,
       first_name,
       SUBSTR(first_name, LENGTH(TO_CHAR(employee_id))) AS name_part
FROM employees;

-- 8. Count characters in the name part created by nested SUBSTR.
SELECT employee_id,
       first_name,
       LENGTH(
           SUBSTR(first_name, LENGTH(TO_CHAR(employee_id)))
       ) AS name_part_length
FROM employees;

-- 9. Add 6 months to hire_date and format the result as text.
SELECT employee_id,
       hire_date,
       TO_CHAR(ADD_MONTHS(hire_date, 6), 'DD-MON-YYYY') AS review_date
FROM employees;

-- 10. Remove dots from phone_number and convert result to NUMBER.
SELECT employee_id,
       phone_number,
       TO_NUMBER(REPLACE(phone_number, '.', '')) AS phone_as_number
FROM employees
WHERE employee_id < 130
  AND phone_number IS NOT NULL;


-- ============================================================
-- Mini summary
-- ============================================================
-- Nested function uses result of one function
-- as an argument of another function.
--
-- General form:
--   OUTER_FUNCTION(INNER_FUNCTION(value))
--
-- Important:
--   Oracle evaluates functions from inside to outside;
--   each inner result moves to the next outer function;
--   data types between functions must be compatible;
--   conversion functions make type changes explicit;
--   nesting can be used in any valid function argument;
--   nested expressions are evaluated separately for every row;
--   aliases and indentation make long expressions readable;
--   functions in SELECT do not change table data.
