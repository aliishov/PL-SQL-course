-- ============================================================
-- SELECT command
-- ============================================================
-- SELECT        - команда для чтения данных из table/view.
--
-- Главная идея:
--   SELECT показывает result set.
--   SELECT не меняет данные в table.
--
-- SELECT не делает:
--   INSERT
--   UPDATE
--   DELETE
--   COMMIT
--   ROLLBACK
--
-- SELECT только читает данные и показывает результат.
--
-- В этом уроке только базовый SELECT и PROJECTION.
-- Более сложные части SELECT будут в отдельных уроках.


-- ============================================================
-- Basic syntax
-- ============================================================
-- Базовый синтаксис:
--   SELECT column_list
--   FROM table_name;
--
-- Пример:
--   SELECT *
--   FROM employees;
--
-- Как читать:
--   SELECT - что показать.
--   FROM   - откуда взять данные.
--
-- table_name - имя таблицы.
-- column_list - список столбцов или выражений.
--
-- Semicolon ; ставится в конце SQL statement.
-- Он говорит инструменту, что команда закончилась.


-- ============================================================
-- SELECT all columns
-- ============================================================
-- Синтаксис:
--   SELECT *
--   FROM table_name;
--
-- * означает все columns из table.
--
-- Пример:
SELECT * FROM employees;

-- То же самое в более читаемом формате:
SELECT *
FROM employees;

-- Такой SELECT покажет все columns из employees.
--
-- Это удобно для первого знакомства с table.
-- Но в реальном коде часто лучше указывать нужные columns явно.


-- ============================================================
-- PROJECTION
-- ============================================================
-- PROJECTION    - выбор определенных columns из table.
--
-- Простыми словами:
--   Projection отвечает на вопрос:
--     "Какие столбцы показать?"
--
-- Синтаксис:
--   SELECT column_name
--   FROM table_name;
--
-- Или:
--   SELECT column_name1,
--          column_name2,
--          column_name3
--   FROM table_name;
--
-- Пример с одной column:
SELECT first_name FROM employees;

-- Тот же пример в читаемом формате:
SELECT first_name
FROM employees;

-- Пример с несколькими columns:
SELECT first_name, last_name, salary FROM employees;

-- Тот же пример в читаемом формате:
SELECT first_name,
       last_name,
       salary
FROM employees;

-- Важно:
--   Таблица employees может иметь много columns.
--   Но result set покажет только те columns,
--   которые перечислены после SELECT.


-- ============================================================
-- Column order
-- ============================================================
-- Порядок columns в result set зависит от порядка в SELECT list.
--
-- Пример 1:
SELECT first_name,
       last_name,
       salary
FROM employees;

-- Result set будет:
--   first_name
--   last_name
--   salary
--
-- Пример 2:
SELECT salary,
       first_name,
       last_name
FROM employees;

-- Result set будет:
--   salary
--   first_name
--   last_name
--
-- Oracle не обязан показывать columns в порядке table.
-- Он показывает их в порядке, который ты написал в SELECT.


-- ============================================================
-- Readable formatting
-- ============================================================
-- Однострочный SELECT:
SELECT employee_id, first_name, last_name, salary FROM employees;

-- Работает, но длинные queries так читать сложнее.
--
-- Более удобный стиль:
SELECT employee_id,
       first_name,
       last_name,
       salary
FROM employees;

-- Хорошая привычка:
--   SELECT пишем на отдельной строке.
--   Каждую column пишем на отдельной строке.
--   FROM пишем на отдельной строке.
--
-- Так легче:
--   читать query;
--   добавлять columns;
--   удалять columns;
--   находить ошибки.


-- ============================================================
-- Projection with expressions
-- ============================================================
-- В SELECT list можно писать не только columns,
-- но и простые expressions.
--
-- Expression - это значение, которое Oracle вычисляет.
--
-- Пример:
SELECT first_name,
       salary,
       salary * 12
FROM employees;

-- Здесь:
--   first_name - обычная column.
--   salary     - обычная column.
--   salary * 12 - expression.
--
-- Table employees не меняется.
-- Oracle просто вычисляет expression для result set.
--
-- Еще пример:
SELECT first_name,
       last_name,
       first_name || ' ' || last_name
FROM employees;

-- Оператор || соединяет strings.
-- Например:
--   'Steven' || ' ' || 'King' = 'Steven King'


-- ============================================================
-- Column aliases
-- ============================================================
-- Alias         - временное имя column/expression в result set.
--
-- Alias нужен, чтобы output был понятнее.
--
-- Пример:
SELECT first_name AS name,
       salary * 12 AS annual_salary
FROM employees;

-- Здесь:
--   name          - alias для first_name.
--   annual_salary - alias для salary * 12.
--
-- AS можно не писать:
SELECT first_name name,
       salary * 12 annual_salary
FROM employees;

-- Но в учебном коде AS часто понятнее.
--
-- Alias с пробелом:
SELECT salary * 12 AS "Annual Salary"
FROM employees;

-- Double quotes нужны, если alias содержит space
-- или если важно сохранить lowercase/uppercase.


-- ============================================================
-- String literals in SELECT
-- ============================================================
-- String literal пишется в single quotes.
--
-- Пример:
SELECT 'Hello Oracle' AS message
FROM dual;

-- DUAL - специальная one-row table в Oracle.
-- Ее часто используют, когда нужно вывести expression,
-- но не нужна настоящая business table.
--
-- Еще пример:
SELECT 'Employee: ' || first_name AS employee_name
FROM employees;

-- Здесь literal 'Employee: ' соединяется со значением first_name.


-- ============================================================
-- Simple calculations in SELECT
-- ============================================================
-- В SELECT можно делать простую арифметику.
--
-- Пример:
SELECT salary,
       salary + 100 AS salary_plus_100,
       salary * 12 AS annual_salary
FROM employees;

-- Арифметические операторы:
--   +  plus
--   -  minus
--   *  multiply
--   /  divide
--
-- Для управления порядком вычислений используй parentheses.
--
-- Пример:
SELECT salary,
       (salary + 100) * 12 AS increased_annual_salary
FROM employees;


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Забыть FROM:
--      SELECT first_name;
--
--    Для table нужно:
--      SELECT first_name
--      FROM employees;
--
-- 2. Поставить comma после последней column:
--      SELECT first_name,
--             last_name,
--      FROM employees;
--
--    Правильно:
--      SELECT first_name,
--             last_name
--      FROM employees;
--
-- 3. Писать string literals в double quotes:
--      SELECT "Hello"
--      FROM dual;
--
--    Лучше:
--      SELECT 'Hello'
--      FROM dual;
--
-- 4. Всегда использовать SELECT *.
--    Для обучения можно.
--    Для нормального query лучше выбрать нужные columns.
--
-- 5. Забыть semicolon в конце command.
--    В SQL Developer/SQL*Plus часто нужен:
--      SELECT *
--      FROM employees;


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Выведи все columns из employees.
--
-- Task 2:
--   Выведи только first_name из employees.
--
-- Task 3:
--   Выведи first_name, last_name, salary из employees.
--
-- Task 4:
--   Выведи salary и salary * 12.
--   Дай expression alias annual_salary.
--
-- Task 5:
--   Выведи full_name через:
--     first_name || ' ' || last_name
--
-- Task 6:
--   Выведи текст 'Hello Oracle' из dual.
--
-- Task 7:
--   Напиши SELECT в читаемом формате:
--     каждая column на отдельной строке.
