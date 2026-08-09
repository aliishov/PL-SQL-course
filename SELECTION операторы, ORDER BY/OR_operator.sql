-- ============================================================
-- OR operator
-- ============================================================
-- OR            - logical operator для соединения нескольких conditions.
--
-- Простыми словами:
--   OR означает "или".
--
-- OR используется в WHERE,
-- когда row должна подходить хотя бы под одно condition.
--
-- Синтаксис:
--   SELECT column_name1,
--          column_name2
--   FROM table_name
--   WHERE condition1
--      OR condition2;
--
-- Главное правило:
--   Если используется OR,
--   достаточно, чтобы хотя бы одно condition было TRUE.
--
-- Если оба conditions не подходят,
-- row не попадает в result set.


-- ============================================================
-- One condition vs OR
-- ============================================================
-- Query с одним condition:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE salary > 10000;

-- Meaning:
--   показать employees,
--   у которых salary больше 10000.
--
-- Query с двумя conditions через OR:
SELECT employee_id,
       first_name,
       salary,
       department_id
FROM employees
WHERE salary > 10000
   OR department_id = 90;

-- Meaning:
--   показать employees,
--   у которых salary больше 10000
--   или department_id равен 90.
--
-- Row попадет в result set,
-- если подходит хотя бы одно из этих conditions.


-- ============================================================
-- OR with number conditions
-- ============================================================
-- OR часто используется,
-- когда есть несколько допустимых numeric values.
--
-- Example:
SELECT employee_id,
       first_name,
       salary,
       department_id
FROM employees
WHERE department_id = 60
   OR department_id = 90;

-- Meaning:
--   показать employees,
--   у которых department_id равен 60
--   или department_id равен 90.
--
-- Если department_id = 60, row подходит.
-- Если department_id = 90, row тоже подходит.
-- Если department_id другой, row не подходит.


-- ============================================================
-- OR with text conditions
-- ============================================================
-- OR можно использовать с text comparisons.
--
-- Example:
SELECT employee_id,
       first_name,
       job_id
FROM employees
WHERE job_id = 'IT_PROG'
   OR job_id = 'ST_CLERK';

-- Meaning:
--   показать employees,
--   у которых job_id равен 'IT_PROG'
--   или job_id равен 'ST_CLERK'.
--
-- Text values пишутся в single quotes.
--
-- Еще example:
SELECT employee_id,
       first_name,
       last_name
FROM employees
WHERE first_name = 'Steven'
   OR first_name = 'David';

-- Meaning:
--   first_name должен быть 'Steven'
--   или first_name должен быть 'David'.


-- ============================================================
-- OR with date conditions
-- ============================================================
-- OR можно использовать с DATE comparisons.
--
-- Example:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE hire_date = TO_DATE('2005-01-01', 'YYYY-MM-DD')
   OR hire_date = TO_DATE('2006-01-01', 'YYYY-MM-DD');

-- Meaning:
--   показать employees,
--   у которых hire_date равен 01 January 2005
--   или 01 January 2006.
--
-- Для dates лучше использовать TO_DATE
-- с явным format mask.


-- ============================================================
-- OR with different columns
-- ============================================================
-- OR может соединять conditions по разным columns.
--
-- Example:
SELECT employee_id,
       first_name,
       salary,
       department_id
FROM employees
WHERE salary > 10000
   OR department_id = 90;

-- Meaning:
--   row подходит, если:
--     salary больше 10000
--     или department_id равен 90.
--
-- Даже если salary меньше или равен 10000,
-- row все равно попадет в result set,
-- если department_id = 90.


-- ============================================================
-- OR with more than two conditions
-- ============================================================
-- Можно соединять больше двух conditions.
--
-- Example:
SELECT employee_id,
       first_name,
       department_id
FROM employees
WHERE department_id = 10
   OR department_id = 20
   OR department_id = 30;

-- Meaning:
--   показать employees,
--   у которых department_id равен:
--     10
--     или 20
--     или 30.
--
-- Row подходит,
-- если совпало хотя бы одно condition.


-- ============================================================
-- How OR filters rows
-- ============================================================
-- Пример:
SELECT employee_id,
       first_name,
       salary,
       department_id
FROM employees
WHERE salary > 10000
   OR department_id = 90;

-- Oracle проверяет каждую row:
--
--   salary > 10000?
--   department_id = 90?
--
-- Если хотя бы один ответ "yes",
-- row остается.
--
-- Если оба ответа "no",
-- row убирается из result set.
--
-- OR делает filter шире,
-- потому что добавляет еще один способ попасть в result set.


-- ============================================================
-- Truth table
-- ============================================================
-- OR работает так:
--
--   condition1 | condition2 | result
--   -----------+------------+--------
--   TRUE       | TRUE       | TRUE
--   TRUE       | FALSE      | TRUE
--   FALSE      | TRUE       | TRUE
--   FALSE      | FALSE      | FALSE
--
-- Главное:
--   OR возвращает TRUE,
--   если хотя бы одно condition TRUE.
--
-- В WHERE row попадает в result set,
-- когда final condition TRUE.


-- ============================================================
-- Formatting OR
-- ============================================================
-- Однострочный query:
SELECT first_name, salary, department_id FROM employees WHERE salary > 10000 OR department_id = 90;

-- Работает, но читается хуже.
--
-- Лучше:
SELECT first_name,
       salary,
       department_id
FROM employees
WHERE salary > 10000
   OR department_id = 90;

-- Хорошая привычка:
--   первое condition писать после WHERE;
--   каждое следующее condition писать с новой строки;
--   OR ставить перед новым condition.
--
-- Так легче читать query
-- и добавлять новые alternatives.


-- ============================================================
-- OR and repeated column name
-- ============================================================
-- Если сравниваешь одну column с несколькими values,
-- column name нужно повторять в каждом condition.
--
-- Неправильно:
--   WHERE department_id = 60
--      OR 90;
--
-- Правильно:
SELECT employee_id,
       first_name,
       department_id
FROM employees
WHERE department_id = 60
   OR department_id = 90;

-- Oracle должен видеть full condition:
--   department_id = 60
--   department_id = 90


-- ============================================================
-- Simple examples
-- ============================================================
-- Number alternatives:
SELECT employee_id,
       first_name,
       department_id
FROM employees
WHERE department_id = 60
   OR department_id = 90;

-- Text alternatives:
SELECT employee_id,
       first_name,
       job_id
FROM employees
WHERE job_id = 'IT_PROG'
   OR job_id = 'ST_CLERK';

-- Date alternatives:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE hire_date = TO_DATE('2005-01-01', 'YYYY-MM-DD')
   OR hire_date = TO_DATE('2006-01-01', 'YYYY-MM-DD');

-- Different columns:
SELECT employee_id,
       first_name,
       salary,
       department_id
FROM employees
WHERE salary > 10000
   OR department_id = 90;


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что OR требует все conditions.
--    OR требует хотя бы одно TRUE condition.
--
-- 2. Забывать повторять column name.
--
--    Неправильно:
--      WHERE department_id = 60
--         OR 90
--
--    Правильно:
--      WHERE department_id = 60
--         OR department_id = 90
--
-- 3. Делать слишком много OR conditions
--    и получать слишком широкий result set.
--
--    Чем больше OR alternatives,
--    тем больше rows может попасть в output.
--
-- 4. Писать text values без single quotes.
--
--    Неправильно:
--      job_id = IT_PROG
--
--    Правильно:
--      job_id = 'IT_PROG'
--
-- 5. Писать весь query в одну длинную строку.
--    Для OR лучше переносить каждое condition на новую строку.


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Выведи employees,
--   у которых department_id равен 60
--   или department_id равен 90.
--
-- Task 2:
--   Выведи employees,
--   у которых job_id равен 'IT_PROG'
--   или job_id равен 'ST_CLERK'.
--
-- Task 3:
--   Выведи employees,
--   у которых first_name равен 'Steven'
--   или first_name равен 'David'.
--
-- Task 4:
--   Выведи employees,
--   у которых hire_date равен 2005-01-01
--   или hire_date равен 2006-01-01.
--   Используй TO_DATE.
--
-- Task 5:
--   Выведи employees,
--   у которых salary больше 10000
--   или department_id равен 90.
--
-- Task 6:
--   Объясни своими словами:
--     что делает OR;
--     почему OR делает filter шире;
--     почему при OR достаточно одного TRUE condition.


-- ============================================================
-- Summary
-- ============================================================
-- OR:
--   соединяет несколько conditions;
--   используется в WHERE;
--   означает "или";
--   требует, чтобы хотя бы одно condition было TRUE.
--
-- Главное:
--   condition1 OR condition2
--
-- Row попадет в result set,
-- если подходит condition1
-- или подходит condition2.
