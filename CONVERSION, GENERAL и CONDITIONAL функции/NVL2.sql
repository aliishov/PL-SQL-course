-- ============================================================
-- General functions
-- NVL2
-- ============================================================
-- NVL2 is a single-row general function.
--
-- Простыми словами:
--   NVL2 checks whether a value is NULL
--   and chooses one of two results.
--
-- If checked value is not NULL,
-- NVL2 returns the second argument.
--
-- If checked value is NULL,
-- NVL2 returns the third argument.
--
-- В этом уроке только NVL2.
-- Other conditional functions будут отдельными темами.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   NVL2(value, result_if_not_null, result_if_null)
--
-- Где:
--   value               - value that Oracle checks;
--   result_if_not_null  - returned when value is not NULL;
--   result_if_null      - returned when value is NULL.
--
-- All three arguments are required.


-- ============================================================
-- Main idea
-- ============================================================
-- Case 1:
--   checked value is not NULL.
--
-- Пример:
SELECT NVL2(17, 18, 19) AS result
FROM dual;

-- Result:
--   18
--
-- Evaluation:
--   17 is not NULL;
--   Oracle chooses the second argument;
--   result is 18.


-- ============================================================
-- When checked value is NULL
-- ============================================================
-- Case 2:
--   checked value is NULL.
--
-- Пример:
SELECT NVL2(NULL, 18, 19) AS result
FROM dual;

-- Result:
--   19
--
-- Evaluation:
--   first argument is NULL;
--   Oracle chooses the third argument;
--   result is 19.


-- ============================================================
-- How to read NVL2
-- ============================================================
-- Read the function in this order:
--
--   1. Check value.
--   2. If value exists, use result_if_not_null.
--   3. If value is missing, use result_if_null.
--
-- Short scheme:
--
--   NOT NULL -> second argument
--   NULL     -> third argument


-- ============================================================
-- NVL2 with a NUMBER column
-- ============================================================
-- commission_pct can contain a number or NULL.
-- NVL2 can return the original value or 0.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       NVL2(e.commission_pct, e.commission_pct, 0) AS commission_value
FROM employees e;

-- If commission_pct is not NULL:
--   second argument returns commission_pct.
--
-- If commission_pct is NULL:
--   third argument returns 0.
--
-- In this example result is similar to:
--   NVL(commission_pct, 0)


-- ============================================================
-- Returning a text status
-- ============================================================
-- NVL2 does not have to return the checked value.
-- It can return a description of its state.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       NVL2(e.commission_pct,
            'Has commission',
            'No commission') AS commission_status
FROM employees e;

-- The first argument is checked only for NULL.
-- The final result comes from the second or third argument.


-- ============================================================
-- First argument and result type
-- ============================================================
-- The checked value does not need to have
-- the same data type as the returned results.
--
-- In this example:
--   commission_pct is NUMBER;
--   both possible results are character text.
--
-- Пример:
SELECT NVL2(commission_pct,
            'Available',
            'Missing') AS commission_state
FROM employees;

-- NUMBER is checked,
-- but VARCHAR2 is returned.


-- ============================================================
-- Result branches must be compatible
-- ============================================================
-- The second and third arguments are two possible results.
-- They should have the same or compatible data types.
--
-- Good numeric branches:
SELECT NVL2(commission_pct, commission_pct, 0) AS commission_value
FROM employees;

-- Good character branches:
SELECT NVL2(phone_number, phone_number, 'No phone') AS phone_value
FROM employees;

-- Bad idea:
--
-- SELECT NVL2(commission_pct, salary, 'No commission')
-- FROM employees;
--
-- One result branch is NUMBER,
-- another is non-numeric text.
-- Oracle can raise a conversion error.


-- ============================================================
-- NVL2 and zero
-- ============================================================
-- Zero is not NULL.
--
-- Пример:
SELECT NVL2(0, 'Not NULL', 'NULL') AS result
FROM dual;

-- Result:
--   Not NULL
--
-- NVL2 checks only whether a value is NULL.
-- It does not check whether number is positive,
-- negative or equal to zero.


-- ============================================================
-- NVL2 and empty string
-- ============================================================
-- Oracle treats an empty character string as NULL.
--
-- Пример:
SELECT NVL2('', 'Has text', 'No text') AS result
FROM dual;

-- Result:
--   No text
--
-- A string containing a space is not empty:
SELECT NVL2(' ', 'Has text', 'No text') AS result
FROM dual;

-- Result:
--   Has text


-- ============================================================
-- Selected result can also be NULL
-- ============================================================
-- NVL2 chooses a branch,
-- but the selected branch itself can contain NULL.
--
-- Пример:
SELECT NVL2(17, NULL, 19) AS result
FROM dual;

-- Result:
--   NULL
--
-- 17 is not NULL,
-- so Oracle chooses the second argument.
-- The second argument is NULL.
--
-- Another example:
SELECT NVL2(NULL, 18, NULL) AS result
FROM dual;

-- Result is also NULL because the third branch is selected.


-- ============================================================
-- NVL and NVL2
-- ============================================================
-- NVL has two arguments:
--
--   NVL(value, replacement_if_null)
--
-- It keeps value when value is not NULL.
--
-- NVL2 has three arguments:
--
--   NVL2(value, result_if_not_null, result_if_null)
--
-- It lets us choose a separate result for both cases.
--
-- Пример:
SELECT e.employee_id,
       NVL(e.commission_pct, 0) AS with_nvl,
       NVL2(e.commission_pct, 1, 0) AS with_nvl2
FROM employees e;

-- with_nvl returns commission_pct itself or 0.
-- with_nvl2 returns a status code 1 or 0.


-- ============================================================
-- NVL2 in calculations
-- ============================================================
-- NVL2 can return different numeric expressions.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.commission_pct,
       NVL2(e.commission_pct,
            e.salary * e.commission_pct,
            0) AS commission_amount
FROM employees e;

-- If commission_pct exists:
--   result is salary * commission_pct.
--
-- If commission_pct is NULL:
--   result is 0.


-- ============================================================
-- Different calculation for each branch
-- ============================================================
-- Both result branches can contain expressions.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.commission_pct,
       NVL2(e.commission_pct,
            e.salary * e.commission_pct,
            e.salary * 0.05) AS bonus
FROM employees e;

-- If employee has commission_pct:
--   bonus uses that percentage.
--
-- If employee has no commission_pct:
--   bonus is 5 percent of salary.


-- ============================================================
-- NVL2 with a character column
-- ============================================================
-- NVL2 can inspect character data.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.phone_number,
       NVL2(e.phone_number,
            e.phone_number,
            'No phone') AS phone_value
FROM employees e;

-- Existing phone_number is returned as it is.
-- Missing phone_number is replaced with text.


-- ============================================================
-- NVL2 with a DATE column
-- ============================================================
-- A DATE column can be checked
-- while result branches return text.
--
-- Пример:
SELECT e.employee_id,
       e.hire_date,
       NVL2(e.hire_date,
            'Hire date exists',
            'Hire date is missing') AS hire_date_status
FROM employees e;

-- hire_date is DATE,
-- but final result is VARCHAR2.


-- ============================================================
-- NVL2 with a function result
-- ============================================================
-- The first argument can be a calculated value.
--
-- Пример:
SELECT e.first_name,
       SUBSTR(e.first_name, 6) AS name_part,
       NVL2(SUBSTR(e.first_name, 6),
            SUBSTR(e.first_name, 6),
            'Name is too short') AS safe_name_part
FROM employees e;

-- Evaluation:
--   SUBSTR returns text or NULL;
--   NVL2 checks that result;
--   NVL2 chooses the second or third branch.


-- ============================================================
-- NVL2 inside another function
-- ============================================================
-- Result of NVL2 can be passed to an outer function.
--
-- Пример:
SELECT e.employee_id,
       UPPER(
           NVL2(e.phone_number,
                e.phone_number,
                'No phone')
       ) AS phone_text
FROM employees e;

-- Evaluation:
--   NVL2 chooses phone text;
--   UPPER processes the chosen result.


-- ============================================================
-- NVL2 in WHERE
-- ============================================================
-- NVL2 can return a value used by a condition.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.commission_pct
FROM employees e
WHERE NVL2(e.commission_pct, 1, 0) = 1;

-- NVL2 returns:
--   1 when commission_pct is not NULL;
--   0 when commission_pct is NULL.
--
-- Therefore, this query returns employees
-- whose commission_pct exists.
--
-- For a simple NULL check, IS NOT NULL is usually clearer.
-- This example shows how NVL2 result can enter a condition.


-- ============================================================
-- Alias for NVL2 result
-- ============================================================
-- A clear alias should describe the chosen result.
--
-- Пример:
SELECT e.first_name,
       NVL2(e.commission_pct,
            'Has commission',
            'No commission') AS commission_status
FROM employees e;

-- commission_status is clearer than a misspelled
-- or generic column name.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Confusing the second and third arguments.
--    Second is for NOT NULL.
--    Third is for NULL.
--
-- 2. Thinking that NVL2 returns the first argument.
--    First argument is checked only for NULL.
--
-- 3. Using incompatible result branches.
--    Second and third arguments should return compatible types.
--
-- 4. Thinking that 0 is NULL.
--    Zero selects result_if_not_null.
--
-- 5. Forgetting that empty string is NULL in Oracle.
--    Empty text selects result_if_null.
--
-- 6. Assuming the selected branch cannot be NULL.
--    NVL2 can return NULL if selected result is NULL.
--
-- 7. Using NVL2 when a simple NULL condition is clearer.
--    For filtering only, IS NULL or IS NOT NULL can be simpler.
--
-- 8. Thinking that NVL2 changes table data.
--    It only returns a calculated value in the query result.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Return 18 because checked value 17 is not NULL.
SELECT NVL2(17, 18, 19) AS result
FROM dual;

-- 2. Return 19 because checked value is NULL.
SELECT NVL2(NULL, 18, 19) AS result
FROM dual;

-- 3. Show 'No text' for an empty string.
SELECT NVL2('', 'Has text', 'No text') AS result
FROM dual;

-- 4. Return commission_pct or 0.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       NVL2(e.commission_pct, e.commission_pct, 0) AS commission_value
FROM employees e;

-- 5. Show a text status for commission_pct.
SELECT e.employee_id,
       e.first_name,
       NVL2(e.commission_pct,
            'Has commission',
            'No commission') AS commission_status
FROM employees e;

-- 6. Calculate commission amount or return 0.
SELECT e.employee_id,
       e.salary,
       e.commission_pct,
       NVL2(e.commission_pct,
            e.salary * e.commission_pct,
            0) AS commission_amount
FROM employees e;

-- 7. Use commission for bonus or 5 percent of salary.
SELECT e.employee_id,
       e.salary,
       e.commission_pct,
       NVL2(e.commission_pct,
            e.salary * e.commission_pct,
            e.salary * 0.05) AS bonus
FROM employees e;

-- 8. Show whether manager_id exists.
SELECT e.employee_id,
       e.first_name,
       NVL2(e.manager_id,
            'Has manager',
            'No manager') AS manager_status
FROM employees e;

-- 9. Return phone_number or text 'No phone'.
SELECT e.employee_id,
       e.first_name,
       NVL2(e.phone_number,
            e.phone_number,
            'No phone') AS phone_value
FROM employees e;

-- 10. Find employees whose commission_pct is not NULL.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct
FROM employees e
WHERE NVL2(e.commission_pct, 1, 0) = 1;


-- ============================================================
-- Mini summary
-- ============================================================
-- NVL2 checks a value for NULL
-- and chooses one of two results.
--
-- Syntax:
--   NVL2(value, result_if_not_null, result_if_null)
--
-- Important:
--   NOT NULL selects the second argument;
--   NULL selects the third argument;
--   first argument is checked but is not returned automatically;
--   second and third arguments should have compatible types;
--   checked value can have a different type from result branches;
--   zero is not NULL;
--   empty string is NULL in Oracle;
--   selected result itself can be NULL;
--   NVL2 can return values, messages or calculations;
--   NVL2 in SELECT does not change table data.
