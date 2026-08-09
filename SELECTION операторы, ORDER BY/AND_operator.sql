-- ============================================================
-- AND operator
-- ============================================================
-- AND           - logical operator для соединения нескольких conditions.
--
-- Простыми словами:
--   AND означает "и".
--
-- AND используется в WHERE,
-- когда row должна подходить сразу под несколько условий.
--
-- Синтаксис:
--   SELECT column_name1,
--          column_name2
--   FROM table_name
--   WHERE condition1
--     AND condition2;
--
-- Главное правило:
--   Если используется AND,
--   все conditions должны быть TRUE.
--
-- Если хотя бы одно condition не подходит,
-- row не попадает в result set.


-- ============================================================
-- One condition vs two conditions
-- ============================================================
-- Query с одним condition:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary > 10000;

-- Meaning:
--   показать employees,
--   у которых salary больше 10000.
--
-- Query с двумя conditions через AND:
SELECT first_name,
       last_name,
       salary,
       department_id
FROM employees
WHERE salary > 10000
  AND department_id = 90;

-- Meaning:
--   показать employees,
--   у которых:
--     salary больше 10000
--     и department_id равен 90.
--
-- Row попадет в result set только если подходят оба conditions.


-- ============================================================
-- AND with number conditions
-- ============================================================
-- AND часто используется с number comparisons.
--
-- Example:
SELECT employee_id,
       first_name,
       salary,
       department_id
FROM employees
WHERE salary >= 5000
  AND department_id = 60;

-- Meaning:
--   salary должен быть 5000 или больше;
--   department_id должен быть 60.
--
-- Если salary подходит,
-- но department_id другой,
-- row не попадет в result set.
--
-- Если department_id подходит,
-- но salary меньше 5000,
-- row тоже не попадет в result set.


-- ============================================================
-- AND with text conditions
-- ============================================================
-- AND можно использовать с text comparisons.
--
-- Example:
SELECT employee_id,
       first_name,
       last_name,
       job_id
FROM employees
WHERE first_name = 'Steven'
  AND last_name = 'King';

-- Meaning:
--   first_name должен быть 'Steven';
--   last_name должен быть 'King'.
--
-- Text values пишутся в single quotes.
--
-- Example:
SELECT employee_id,
       first_name,
       job_id,
       department_id
FROM employees
WHERE job_id = 'IT_PROG'
  AND department_id = 60;

-- Meaning:
--   job_id должен быть 'IT_PROG';
--   department_id должен быть 60.


-- ============================================================
-- AND with date conditions
-- ============================================================
-- AND можно использовать с DATE comparisons.
--
-- Example:
SELECT employee_id,
       first_name,
       hire_date,
       department_id
FROM employees
WHERE hire_date >= TO_DATE('2005-01-01', 'YYYY-MM-DD')
  AND department_id = 50;

-- Meaning:
--   hire_date должен быть 01 January 2005 или позже;
--   department_id должен быть 50.
--
-- Для dates лучше использовать TO_DATE
-- с явным format mask.


-- ============================================================
-- AND with more than two conditions
-- ============================================================
-- Можно соединять больше двух conditions.
--
-- Example:
SELECT employee_id,
       first_name,
       salary,
       department_id,
       job_id
FROM employees
WHERE salary >= 5000
  AND department_id = 50
  AND job_id = 'ST_CLERK';

-- Meaning:
--   salary должен быть 5000 или больше;
--   department_id должен быть 50;
--   job_id должен быть 'ST_CLERK'.
--
-- Row попадет в result set только если подходят все 3 conditions.


-- ============================================================
-- How AND filters rows
-- ============================================================
-- Пример:
SELECT employee_id,
       first_name,
       salary,
       department_id
FROM employees
WHERE salary > 10000
  AND department_id = 90;

-- Oracle проверяет каждую row:
--
--   salary > 10000?
--   department_id = 90?
--
-- Если оба ответа "yes",
-- row остается.
--
-- Если хотя бы один ответ "no",
-- row убирается из result set.
--
-- AND делает filter строже,
-- потому что каждая новая condition добавляет новое требование.


-- ============================================================
-- Truth table
-- ============================================================
-- AND работает так:
--
--   condition1 | condition2 | result
--   -----------+------------+--------
--   TRUE       | TRUE       | TRUE
--   TRUE       | FALSE      | FALSE
--   FALSE      | TRUE       | FALSE
--   FALSE      | FALSE      | FALSE
--
-- Главное:
--   AND возвращает TRUE только тогда,
--   когда все conditions TRUE.
--
-- В WHERE row попадает в result set,
-- когда final condition TRUE.


-- ============================================================
-- Formatting AND
-- ============================================================
-- Однострочный query:
SELECT first_name, last_name, salary FROM employees WHERE salary > 10000 AND department_id = 90;

-- Работает, но читается хуже.
--
-- Лучше:
SELECT first_name,
       last_name,
       salary,
       department_id
FROM employees
WHERE salary > 10000
  AND department_id = 90;

-- Хорошая привычка:
--   первое condition писать после WHERE;
--   каждое следующее condition писать с новой строки;
--   AND ставить перед новым condition.
--
-- Так легче читать query
-- и добавлять новые conditions.


-- ============================================================
-- Simple examples
-- ============================================================
-- Number + number:
SELECT employee_id,
       first_name,
       salary,
       department_id
FROM employees
WHERE salary > 10000
  AND department_id = 90;

-- Text + number:
SELECT employee_id,
       first_name,
       job_id,
       department_id
FROM employees
WHERE job_id = 'IT_PROG'
  AND department_id = 60;

-- Date + number:
SELECT employee_id,
       first_name,
       hire_date,
       department_id
FROM employees
WHERE hire_date >= TO_DATE('2005-01-01', 'YYYY-MM-DD')
  AND department_id = 50;

-- Three conditions:
SELECT employee_id,
       first_name,
       salary,
       department_id,
       job_id
FROM employees
WHERE salary >= 5000
  AND department_id = 50
  AND job_id = 'ST_CLERK';


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что AND означает "хотя бы одно condition".
--    AND означает, что должны подойти все conditions.
--
-- 2. Забывать повторять column name.
--
--    Неправильно:
--      WHERE salary > 5000
--        AND < 10000
--
--    Правильно:
--      WHERE salary > 5000
--        AND salary < 10000
--
-- 3. Делать слишком много conditions
--    и удивляться, что result set пустой.
--
--    Чем больше AND conditions,
--    тем строже filter.
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
--    Для AND лучше переносить каждое condition на новую строку.


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Выведи employees,
--   у которых salary больше 10000
--   и department_id равен 90.
--
-- Task 2:
--   Выведи employees,
--   у которых job_id равен 'IT_PROG'
--   и department_id равен 60.
--
-- Task 3:
--   Выведи employees,
--   у которых first_name равен 'Steven'
--   и last_name равен 'King'.
--
-- Task 4:
--   Выведи employees,
--   у которых hire_date равен или позже 2005-01-01
--   и department_id равен 50.
--
-- Task 5:
--   Выведи employees,
--   у которых salary равен или больше 5000,
--   department_id равен 50,
--   job_id равен 'ST_CLERK'.
--
-- Task 6:
--   Объясни своими словами:
--     что делает AND;
--     почему AND делает filter строже;
--     почему при AND должны подойти все conditions.


-- ============================================================
-- Summary
-- ============================================================
-- AND:
--   соединяет несколько conditions;
--   используется в WHERE;
--   означает "и";
--   требует, чтобы все conditions были TRUE.
--
-- Главное:
--   condition1 AND condition2
--
-- Row попадет в result set только тогда,
-- когда подходит condition1
-- и одновременно подходит condition2.
