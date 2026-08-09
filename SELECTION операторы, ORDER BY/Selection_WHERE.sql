-- ============================================================
-- WHERE clause
-- ============================================================
-- WHERE         - часть SELECT command, которая фильтрует rows.
--
-- Простыми словами:
--   WHERE отвечает на вопрос:
--     "Какие строки должны попасть в result set?"
--
-- WHERE относится к concept SELECTION.
--
-- SELECTION     - позволяет ограничить количество строк в результате.
--
-- В этом уроке только сама идея WHERE:
--   где пишется WHERE;
--   что такое condition;
--   как WHERE влияет на result set;
--   как читать простые examples.
--
-- Отдельные операторы и сложные условия будут в других уроках.


-- ============================================================
-- Basic syntax
-- ============================================================
-- Синтаксис:
--   SELECT expression(s) | column(s)
--   FROM table_name
--   WHERE condition;
--
-- В более обычной записи:
--   SELECT column_name1,
--          column_name2
--   FROM table_name
--   WHERE condition;
--
-- WHERE пишется после FROM.
--
-- SELECT list говорит:
--   какие columns или expressions показать.
--
-- FROM говорит:
--   из какой table взять rows.
--
-- WHERE говорит:
--   какие rows оставить.


-- ============================================================
-- SELECT without WHERE
-- ============================================================
-- Query без WHERE возвращает все rows из table.
--
-- Пример:
SELECT *
FROM employees;

-- Meaning:
--   показать все columns;
--   взять rows из employees;
--   не ограничивать rows.
--
-- Такой query полезен для знакомства с table,
-- но на больших tables может вернуть слишком много rows.


-- ============================================================
-- SELECT with WHERE
-- ============================================================
-- Query с WHERE возвращает только rows,
-- для которых condition подходит.
--
-- Пример:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary = 17000;

-- Meaning:
--   показать first_name, last_name, salary;
--   взять данные из employees;
--   оставить только rows, где salary равен 17000.
--
-- Result set будет меньше,
-- потому что WHERE отфильтровал rows.


-- ============================================================
-- What is condition
-- ============================================================
-- Condition      - правило, по которому Oracle решает,
--                  оставить row или убрать row из result set.
--
-- Пример condition:
--   salary = 17000
--
-- Для каждой row Oracle проверяет:
--   salary этой row равен 17000?
--
-- Если condition подходит:
--   row попадает в result set.
--
-- Если condition не подходит:
--   row не попадает в result set.
--
-- Важно:
--   WHERE фильтрует rows.
--   WHERE не выбирает columns.
--
-- Columns выбираются в SELECT list.


-- ============================================================
-- Filtering by number value
-- ============================================================
-- Number values пишутся без quotes.
--
-- Пример:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary = 17000;

-- Здесь 17000 - number value.
--
-- Еще пример:
SELECT *
FROM departments
WHERE location_id = 1700;

-- Здесь WHERE оставляет только departments,
-- у которых location_id равен 1700.


-- ============================================================
-- Filtering by text value
-- ============================================================
-- Text values пишутся в single quotes.
--
-- Пример:
SELECT first_name,
       salary
FROM employees
WHERE last_name = 'King';

-- Здесь 'King' - text value.
--
-- Еще пример:
SELECT *
FROM job_history
WHERE job_id = 'ST_CLERK';

-- Здесь 'ST_CLERK' - text value.
--
-- Важно:
--   Single quotes нужны для text values.
--
-- Правильно:
--   'King'
--
-- Неправильно:
--   King
--
-- Если написать King без quotes,
-- Oracle будет думать, что это имя column или object.


-- ============================================================
-- Filtering by DATE value
-- ============================================================
-- DATE values лучше писать через явное преобразование.
--
-- Пример:
SELECT *
FROM employees
WHERE hire_date = TO_DATE('2005-09-21', 'YYYY-MM-DD');

-- Meaning:
--   оставить employees,
--   у которых hire_date равен 21 September 2005.
--
-- Почему лучше так:
--   формат даты указан явно;
--   query легче читать;
--   меньше зависимости от настроек session.
--
-- Менее надежный вариант:
--   WHERE hire_date = '21-Sep-05'
--
-- Такой вариант может зависеть от настроек формата даты.


-- ============================================================
-- Comparing one column with another column
-- ============================================================
-- В condition можно сравнить значение одной column
-- со значением другой column из той же row.
--
-- Пример:
SELECT *
FROM employees
WHERE employee_id = manager_id;

-- Meaning:
--   оставить rows,
--   где employee_id равен manager_id.
--
-- Это не самый частый business example,
-- но он показывает важную идею:
--   справа в condition может быть не только literal,
--   но и другая column.


-- ============================================================
-- WHERE keeps table data unchanged
-- ============================================================
-- WHERE в SELECT только ограничивает output.
--
-- Пример:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary = 17000;

-- Этот query не меняет table employees.
--
-- Он только показывает rows,
-- которые подходят под condition.
--
-- Данные в table остаются такими же.


-- ============================================================
-- Reading WHERE query
-- ============================================================
-- Пример:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary = 17000;

-- Как читать:
--   1. FROM employees
--      берем rows из employees.
--
--   2. WHERE salary = 17000
--      оставляем только rows с salary 17000.
--
--   3. SELECT first_name, last_name, salary
--      показываем только эти columns.
--
-- В SQL query написан сверху вниз,
-- но для понимания часто удобно сначала смотреть FROM,
-- потом WHERE,
-- потом SELECT list.


-- ============================================================
-- Formatting WHERE query
-- ============================================================
-- Однострочный query:
SELECT first_name, last_name, salary FROM employees WHERE salary = 17000;

-- Работает, но читается хуже.
--
-- Лучше:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary = 17000;

-- Хорошая привычка:
--   SELECT на отдельной строке.
--   FROM на отдельной строке.
--   WHERE на отдельной строке.
--   Columns в SELECT list можно писать каждая с новой строки.


-- ============================================================
-- WHERE with result set
-- ============================================================
-- Result set    - результат SELECT query.
--
-- WHERE влияет на количество rows в result set.
--
-- Пример без WHERE:
SELECT employee_id,
       first_name,
       salary
FROM employees;

-- Может вернуть много rows.
--
-- Пример с WHERE:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE salary = 17000;

-- Вернет только rows,
-- где salary равен 17000.
--
-- Columns остались те же:
--   employee_id
--   first_name
--   salary
--
-- Rows стало меньше.


-- ============================================================
-- WHERE with SELECT *
-- ============================================================
-- WHERE можно использовать и с SELECT *.
--
-- Пример:
SELECT *
FROM employees
WHERE salary = 17000;

-- Meaning:
--   показать все columns,
--   но только для rows с salary 17000.
--
-- SELECT * отвечает:
--   какие columns показать.
--
-- WHERE отвечает:
--   какие rows оставить.


-- ============================================================
-- Simple examples
-- ============================================================
-- Example 1:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary = 17000;

-- Example 2:
SELECT first_name,
       salary
FROM employees
WHERE last_name = 'King';

-- Example 3:
SELECT *
FROM employees
WHERE hire_date = TO_DATE('2005-09-21', 'YYYY-MM-DD');

-- Example 4:
SELECT *
FROM departments
WHERE location_id = 1700;

-- Example 5:
SELECT *
FROM employees
WHERE employee_id = manager_id;

-- Example 6:
SELECT *
FROM job_history
WHERE job_id = 'ST_CLERK';


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Писать WHERE перед FROM.
--
--    Неправильно:
--      SELECT first_name
--      WHERE salary = 17000
--      FROM employees;
--
--    Правильно:
--      SELECT first_name
--      FROM employees
--      WHERE salary = 17000;
--
-- 2. Забывать quotes для text value.
--
--    Неправильно:
--      WHERE last_name = King
--
--    Правильно:
--      WHERE last_name = 'King'
--
-- 3. Писать date как обычный text без явного формата.
--
--    Менее надежно:
--      WHERE hire_date = '21-Sep-05'
--
--    Лучше:
--      WHERE hire_date = TO_DATE('2005-09-21', 'YYYY-MM-DD')
--
-- 4. Думать, что WHERE выбирает columns.
--    WHERE выбирает rows.
--    Columns выбираются после SELECT.
--
-- 5. Думать, что SELECT with WHERE меняет данные.
--    SELECT with WHERE только читает данные.


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Выведи first_name, last_name, salary
--   из employees,
--   где salary равен 17000.
--
-- Task 2:
--   Выведи first_name и salary
--   из employees,
--   где last_name равен 'King'.
--
-- Task 3:
--   Выведи все columns
--   из employees,
--   где hire_date равен 21 September 2005.
--   Используй TO_DATE с форматом 'YYYY-MM-DD'.
--
-- Task 4:
--   Выведи все columns
--   из departments,
--   где location_id равен 1700.
--
-- Task 5:
--   Выведи все columns
--   из job_history,
--   где job_id равен 'ST_CLERK'.
--
-- Task 6:
--   Объясни своими словами:
--     что делает WHERE;
--     чем SELECT list отличается от WHERE;
--     почему text value пишется в single quotes.


-- ============================================================
-- Summary
-- ============================================================
-- WHERE:
--   фильтрует rows;
--   пишется после FROM;
--   использует condition;
--   влияет на количество rows в result set;
--   не меняет данные в table.
--
-- Главное:
--   SELECT list = какие columns показать.
--   FROM        = из какой table взять rows.
--   WHERE       = какие rows оставить.

