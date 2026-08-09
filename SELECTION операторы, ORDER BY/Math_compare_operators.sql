-- ============================================================
-- Math / comparison operators in WHERE
-- ============================================================
-- Comparison operators используются в WHERE condition,
-- чтобы сравнить value из row с другим value.
--
-- Простыми словами:
--   Oracle проверяет condition для каждой row.
--   Если comparison подходит, row попадает в result set.
--
-- В этом уроке только базовые comparison operators:
--   =
--   >
--   <
--   >=
--   <=
--   !=
--   <>
--
-- Другие операторы будут отдельными темами.


-- ============================================================
-- Operator =
-- ============================================================
-- =             - равно.
--
-- Используется, когда нужно найти rows
-- с точным совпадением value.
--
-- Number example:
SELECT *
FROM employees
WHERE salary = 17000;

-- Meaning:
--   показать employees,
--   у которых salary равен 17000.
--
-- Text example:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE last_name = 'King';

-- Text values пишутся в single quotes.
--
-- Date example:
SELECT *
FROM job_history
WHERE start_date = TO_DATE('2006-03-24', 'YYYY-MM-DD');

-- Для date value лучше использовать TO_DATE
-- с явным format mask.


-- ============================================================
-- Operator >
-- ============================================================
-- >             - больше.
--
-- Используется, когда value слева должно быть больше value справа.
--
-- Number example:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary > 10000;

-- Meaning:
--   показать employees,
--   у которых salary больше 10000.
--
-- Text example:
SELECT *
FROM employees
WHERE first_name > 'Steven';

-- Для text values сравнение идет по правилам сортировки/сравнения строк
-- в текущей database/session.
--
-- Date example:
SELECT *
FROM job_history
WHERE start_date > TO_DATE('2005-01-01', 'YYYY-MM-DD');

-- Meaning:
--   показать rows,
--   где start_date позже 01 January 2005.


-- ============================================================
-- Operator <
-- ============================================================
-- <             - меньше.
--
-- Используется, когда value слева должно быть меньше value справа.
--
-- Number example:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary < 10000;

-- Meaning:
--   показать employees,
--   у которых salary меньше 10000.
--
-- Text example:
SELECT *
FROM employees
WHERE first_name < 'Steven';

-- Date example:
SELECT *
FROM job_history
WHERE start_date < TO_DATE('2005-01-01', 'YYYY-MM-DD');

-- Meaning:
--   показать rows,
--   где start_date раньше 01 January 2005.


-- ============================================================
-- Operator >=
-- ============================================================
-- >=            - больше или равно.
--
-- Используется, когда value слева может быть:
--   больше value справа;
--   равно value справа.
--
-- Number example:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary >= 10000;

-- Meaning:
--   показать employees,
--   у которых salary 10000 или больше.
--
-- Date example:
SELECT *
FROM job_history
WHERE start_date >= TO_DATE('2005-01-01', 'YYYY-MM-DD');

-- Meaning:
--   start_date равен 01 January 2005
--   или позже этой даты.


-- ============================================================
-- Operator <=
-- ============================================================
-- <=            - меньше или равно.
--
-- Используется, когда value слева может быть:
--   меньше value справа;
--   равно value справа.
--
-- Number example:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary <= 10000;

-- Meaning:
--   показать employees,
--   у которых salary 10000 или меньше.
--
-- Date example:
SELECT *
FROM job_history
WHERE start_date <= TO_DATE('2005-01-01', 'YYYY-MM-DD');

-- Meaning:
--   start_date равен 01 January 2005
--   или раньше этой даты.


-- ============================================================
-- Operator !=
-- ============================================================
-- !=            - не равно.
--
-- Используется, когда нужно исключить точное совпадение value.
--
-- Number example:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE salary != 17000;

-- Meaning:
--   показать employees,
--   у которых salary не равен 17000.
--
-- Text example:
SELECT employee_id,
       first_name,
       job_id
FROM employees
WHERE job_id != 'IT_PROG';

-- Meaning:
--   показать employees,
--   у которых job_id не равен 'IT_PROG'.


-- ============================================================
-- Operator <>
-- ============================================================
-- <>            - не равно.
--
-- В Oracle <> и != часто дают одинаковый смысл.
--
-- Example:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE salary <> 17000;

-- Meaning:
--   показать employees,
--   у которых salary не равен 17000.
--
-- Text example:
SELECT employee_id,
       first_name,
       job_id
FROM employees
WHERE job_id <> 'IT_PROG';

-- Хорошая практика:
--   В SQL часто используют <> как стандартный вариант.
--   != тоже обычно работает в Oracle.


-- ============================================================
-- Comparing column with column
-- ============================================================
-- В WHERE можно сравнивать column с другой column.
--
-- Example:
SELECT *
FROM employees
WHERE employee_id = manager_id;

-- Meaning:
--   показать rows,
--   где employee_id равен manager_id.
--
-- Другой example:
SELECT *
FROM employees
WHERE salary > employee_id;

-- Это учебный пример.
-- Он показывает, что справа от operator
-- может быть не только literal,
-- но и другая column.


-- ============================================================
-- Comparing with expressions
-- ============================================================
-- В comparison можно использовать simple expression.
--
-- Example:
SELECT *
FROM employees
WHERE employee_id = 101;

-- То же value можно получить через expression:
SELECT *
FROM employees
WHERE employee_id = 100 + 1;

-- Oracle сначала вычисляет expression:
--   100 + 1 = 101
--
-- Потом сравнивает:
--   employee_id = 101
--
-- Еще example:
SELECT *
FROM employees
WHERE salary > 5000 * 2;

-- Oracle вычисляет:
--   5000 * 2 = 10000
--
-- Потом проверяет:
--   salary > 10000


-- ============================================================
-- Number, text, date values
-- ============================================================
-- Number value:
--   17000
--   10000
--   5000
--
-- Text value:
--   'King'
--   'Steven'
--   'IT_PROG'
--
-- Date value:
--   TO_DATE('2005-01-01', 'YYYY-MM-DD')
--
-- Examples:
SELECT *
FROM employees
WHERE salary = 17000;

SELECT *
FROM employees
WHERE first_name = 'Steven';

SELECT *
FROM job_history
WHERE start_date = TO_DATE('2005-01-01', 'YYYY-MM-DD');

-- Важно:
--   numbers пишутся без quotes;
--   text пишется в single quotes;
--   dates лучше писать через TO_DATE с format mask.


-- ============================================================
-- Result of comparison
-- ============================================================
-- Comparison condition для каждой row может подойти
-- или не подойти.
--
-- Example:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary > 10000;

-- Для каждой row Oracle проверяет:
--   salary этой row больше 10000?
--
-- Если да:
--   row попадает в result set.
--
-- Если нет:
--   row не попадает в result set.
--
-- WHERE фильтрует rows.
-- SELECT list выбирает columns.


-- ============================================================
-- Simple examples
-- ============================================================
-- Equal:
SELECT *
FROM employees
WHERE salary = 17000;

-- Greater than:
SELECT first_name,
       last_name
FROM employees
WHERE salary > 10000;

-- Less than:
SELECT first_name,
       last_name
FROM employees
WHERE salary < 10000;

-- Greater than or equal:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary >= 10000;

-- Less than or equal:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary <= 10000;

-- Not equal:
SELECT employee_id,
       job_id
FROM employees
WHERE job_id <> 'IT_PROG';


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Писать text value без single quotes.
--
--    Неправильно:
--      WHERE first_name = Steven
--
--    Правильно:
--      WHERE first_name = 'Steven'
--
-- 2. Писать date как обычный text без format mask.
--
--    Менее надежно:
--      WHERE start_date > '01-Jan-05'
--
--    Лучше:
--      WHERE start_date > TO_DATE('2005-01-01', 'YYYY-MM-DD')
--
-- 3. Путать = и !=.
--
--    =  означает равно.
--    != означает не равно.
--
-- 4. Путать > и <.
--
--    salary > 10000 - больше 10000.
--    salary < 10000 - меньше 10000.
--
-- 5. Думать, что comparison меняет data.
--    Comparison в SELECT только фильтрует result set.


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Выведи всех employees,
--   у которых salary равен 17000.
--
-- Task 2:
--   Выведи first_name, last_name
--   для employees,
--   у которых salary больше 10000.
--
-- Task 3:
--   Выведи first_name, last_name
--   для employees,
--   у которых salary меньше 10000.
--
-- Task 4:
--   Выведи employees,
--   у которых first_name равен 'Steven'.
--
-- Task 5:
--   Выведи rows из job_history,
--   где start_date позже 01 January 2005.
--   Используй TO_DATE.
--
-- Task 6:
--   Выведи employees,
--   у которых job_id не равен 'IT_PROG'.
--   Используй <>.
--
-- Task 7:
--   Сделай тот же query,
--   но используй !=.
--
-- Task 8:
--   Объясни разницу:
--     salary > 10000
--     salary >= 10000


-- ============================================================
-- Summary
-- ============================================================
-- Basic comparison operators:
--   =   равно
--   >   больше
--   <   меньше
--   >=  больше или равно
--   <=  меньше или равно
--   !=  не равно
--   <>  не равно
--
-- Используются:
--   в WHERE condition;
--   для numbers;
--   для text;
--   для dates;
--   для comparison column with column;
--   для comparison with simple expression.
--
-- Главное:
--   comparison operators помогают WHERE решить,
--   какие rows оставить в result set.
