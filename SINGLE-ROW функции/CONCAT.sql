-- ============================================================
-- Character functions
-- String function: CONCAT
-- ============================================================
-- CONCAT        - single-row character function.
--
-- Простыми словами:
--   CONCAT соединяет два values в один text value.
--
-- Single-row function означает:
--   функция получает value из одной row;
--   возвращает result для этой же row.
--
-- Синтаксис:
--   CONCAT(char_value1, char_value2)
--
-- Важно:
--   В Oracle CONCAT принимает ровно 2 arguments.
--
-- Если нужно соединить больше 2 частей:
--   1. используй nested CONCAT;
--   2. или используй operator ||.
--
-- В этом уроке только CONCAT.
-- Другие character functions будут отдельными темами.


-- ============================================================
-- CONCAT with string literals
-- ============================================================
-- String literal пишется в single quotes.
--
-- Пример:
SELECT CONCAT('privet, ', 'druq') AS message
FROM dual;

-- Result:
--   privet, druq
--
-- CONCAT взял:
--   first value  = 'privet, '
--   second value = 'druq'
--
-- И вернул:
--   'privet, druq'


-- ============================================================
-- CONCAT with column values
-- ============================================================
-- CONCAT можно использовать с table columns.
--
-- Пример:
SELECT first_name,
       last_name,
       CONCAT(first_name, last_name) AS full_name_no_space
FROM employees;

-- Если:
--   first_name = 'Steven'
--   last_name  = 'King'
--
-- Result:
--   StevenKing
--
-- Почему нет space?
--   Потому что CONCAT соединяет values exactly как они есть.
--
-- Чтобы добавить space,
-- нужно сделать его отдельной частью.


-- ============================================================
-- CONCAT and spaces
-- ============================================================
-- Space тоже является character.
--
-- Пример через nested CONCAT:
SELECT first_name,
       last_name,
       CONCAT(CONCAT(first_name, ' '), last_name) AS full_name
FROM employees;

-- Как читать:
--   CONCAT(first_name, ' ')
--     сначала добавляет space после first_name.
--
--   CONCAT(result, last_name)
--     потом добавляет last_name.
--
-- Если:
--   first_name = 'Steven'
--   last_name  = 'King'
--
-- Result:
--   Steven King


-- ============================================================
-- CONCAT accepts two arguments
-- ============================================================
-- Oracle CONCAT принимает только 2 arguments.
--
-- Правильно:
SELECT CONCAT('Privet ', 'druq') AS message
FROM dual;

-- Неправильно:
--   SELECT CONCAT('Privet ', 'moy', ' druq')
--   FROM dual;
--
-- Такой вариант содержит 3 arguments.
--
-- Для 3 частей используй nested CONCAT:
SELECT CONCAT('Privet ', CONCAT('moy', ' druq')) AS message
FROM dual;

-- Result:
--   Privet moy druq


-- ============================================================
-- Nested CONCAT
-- ============================================================
-- Nested CONCAT - CONCAT внутри другого CONCAT.
--
-- Пример:
SELECT CONCAT('Privet ', CONCAT('moy', ' druq')) AS message
FROM dual;

-- Inner function:
--   CONCAT('moy', ' druq')
--
-- Result:
--   'moy druq'
--
-- Outer function:
--   CONCAT('Privet ', 'moy druq')
--
-- Final result:
--   'Privet moy druq'
--
-- Nested CONCAT работает,
-- но при большом количестве parts читать его неудобно.


-- ============================================================
-- CONCAT vs || operator
-- ============================================================
-- В Oracle для соединения strings часто используют operator ||.
--
-- CONCAT example:
SELECT CONCAT(CONCAT(first_name, ' '), last_name) AS full_name
FROM employees;

-- Same idea with ||:
SELECT first_name || ' ' || last_name AS full_name
FROM employees;

-- Для 2 parts CONCAT читается нормально.
--
-- Для 3+ parts operator || часто проще:
--   first_name || ' ' || last_name
--
-- Важно:
--   || - это operator.
--   CONCAT - это function.


-- ============================================================
-- CONCAT with numbers
-- ============================================================
-- CONCAT предназначен для character values.
--
-- Но Oracle может сделать implicit conversion,
-- если передать number.
--
-- Пример:
SELECT CONCAT(55, ' druq') AS message
FROM dual;

-- Possible result:
--   55 druq
--
-- Oracle может преобразовать number 55 в text '55',
-- а потом соединить с ' druq'.
--
-- Еще пример:
SELECT first_name,
       salary,
       CONCAT('Salary: ', salary) AS salary_text
FROM employees;

-- Важно:
--   Это implicit conversion.
--   Для красивого форматирования numbers
--   обычно используют отдельные conversion functions.
--   Это будет отдельной темой.


-- ============================================================
-- CONCAT with date values
-- ============================================================
-- CONCAT может работать с DATE через implicit conversion.
--
-- Пример:
SELECT CONCAT('Today is: ', SYSDATE) AS today_text
FROM dual;

-- Oracle может преобразовать SYSDATE в text
-- по date format текущей session.
--
-- Поэтому output может выглядеть по-разному:
--   15-Aug-26
--   2026-08-15
--   15.08.2026
--
-- Это зависит от session settings.
--
-- Важно:
--   Для точного date formatting
--   обычно используют отдельные conversion functions.
--   Это будет отдельной темой.


-- ============================================================
-- CONCAT with expressions
-- ============================================================
-- CONCAT может получать expression как argument.
--
-- Пример:
SELECT first_name,
       salary,
       CONCAT('Double salary: ', salary * 2) AS double_salary_text
FROM employees;

-- Oracle сначала вычисляет expression:
--   salary * 2
--
-- Потом может преобразовать result в text
-- и соединить с 'Double salary: '.
--
-- Еще пример из employees:
SELECT CONCAT(salary * 2, hire_date) AS salary_date_text
FROM employees;

-- Этот example показывает,
-- что CONCAT может принять expressions разных типов.
--
-- Но output может быть не очень красивым,
-- потому что number/date formatting зависит от implicit conversion.


-- ============================================================
-- CONCAT and NULL
-- ============================================================
-- В Oracle concatenation с NULL обычно ведет себя как
-- concatenation с empty text.
--
-- Пример:
SELECT CONCAT('Hello ', NULL) AS message
FROM dual;

-- Result обычно:
--   Hello
--
-- Еще пример:
SELECT CONCAT(NULL, 'Oracle') AS message
FROM dual;

-- Result обычно:
--   Oracle
--
-- Важно:
--   Это отличается от arithmetic with NULL.
--
-- Например:
--   10 + NULL = NULL
--
-- А text concatenation с NULL часто возвращает non-null text part.


-- ============================================================
-- CONCAT in SELECT list
-- ============================================================
-- CONCAT часто используется в SELECT list,
-- чтобы собрать readable text.
--
-- Пример:
SELECT employee_id,
       CONCAT('Employee: ', first_name) AS employee_text
FROM employees;

-- Еще пример:
SELECT employee_id,
       CONCAT(CONCAT(first_name, ' '), last_name) AS full_name
FROM employees;

-- Table data не меняется.
-- CONCAT только создает output value.


-- ============================================================
-- CONCAT in WHERE
-- ============================================================
-- CONCAT можно использовать в WHERE,
-- если нужно фильтровать по assembled text.
--
-- Пример:
SELECT employee_id,
       first_name,
       last_name
FROM employees
WHERE CONCAT(CONCAT(first_name, ' '), last_name) = 'Steven King';

-- Meaning:
--   Oracle собирает full name;
--   потом сравнивает его с 'Steven King'.
--
-- Это учебный пример.
-- В реальных queries часто проще фильтровать по отдельным columns:
--   first_name
--   last_name


-- ============================================================
-- Readable formatting
-- ============================================================
-- Однострочный query:
SELECT CONCAT('privet, ', 'druq') FROM dual;

-- Работает, но лучше давать alias:
SELECT CONCAT('privet, ', 'druq') AS message
FROM dual;

-- Nested CONCAT лучше форматировать аккуратно:
SELECT CONCAT(
         CONCAT(first_name, ' '),
         last_name
       ) AS full_name
FROM employees;

-- Для длинных concatenations часто легче читать ||:
SELECT first_name || ' ' || last_name AS full_name
FROM employees;


-- ============================================================
-- Simple examples
-- ============================================================
-- Two literals:
SELECT CONCAT('privet, ', 'druq') AS message
FROM dual;

-- Number with text:
SELECT CONCAT(55, ' druq') AS message
FROM dual;

-- Date with text:
SELECT CONCAT('Today is: ', SYSDATE) AS today_text
FROM dual;

-- Nested CONCAT:
SELECT CONCAT('Privet ', CONCAT('moy', ' druq')) AS message
FROM dual;

-- Full name:
SELECT first_name,
       last_name,
       CONCAT(CONCAT(first_name, ' '), last_name) AS full_name
FROM employees;

-- Same full name with ||:
SELECT first_name,
       last_name,
       first_name || ' ' || last_name AS full_name
FROM employees;


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Передавать в CONCAT больше 2 arguments.
--
--    Неправильно:
--      CONCAT('A', 'B', 'C')
--
--    Правильно:
--      CONCAT('A', CONCAT('B', 'C'))
--
--    Или:
--      'A' || 'B' || 'C'
--
-- 2. Забывать spaces.
--
--    CONCAT(first_name, last_name)
--    даст:
--      StevenKing
--
--    Для space:
--      CONCAT(CONCAT(first_name, ' '), last_name)
--
-- 3. Думать, что CONCAT меняет table data.
--    CONCAT в SELECT только показывает computed text.
--
-- 4. Полагаться на implicit date formatting.
--    CONCAT('Today is: ', SYSDATE)
--    зависит от session date format.
--
-- 5. Делать nested CONCAT слишком длинным.
--    Для многих parts operator || часто читается лучше.


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Соедини 'Hello ' и 'Oracle'
--   через CONCAT.
--
-- Task 2:
--   Выведи first_name, last_name
--   и full_name через nested CONCAT.
--
-- Task 3:
--   Выведи first_name, salary
--   и text:
--     Salary: salary
--
--   Используй CONCAT.
--
-- Task 4:
--   Выведи:
--     Today is: SYSDATE
--
--   через CONCAT.
--
-- Task 5:
--   Соедини 3 pieces:
--     'Privet '
--     'moy'
--     ' druq'
--
--   Используй nested CONCAT.
--
-- Task 6:
--   Перепиши Task 5 через operator ||.
--
-- Task 7:
--   Проверь:
--     CONCAT('Hello ', NULL)
--
--   Объясни result.
--
-- Task 8:
--   Объясни своими словами:
--     что делает CONCAT;
--     сколько arguments принимает CONCAT в Oracle;
--     когда удобнее использовать ||.


-- ============================================================
-- Summary
-- ============================================================
-- CONCAT:
--   single-row character function;
--   соединяет два values в один text value;
--   accepts exactly 2 arguments in Oracle;
--   can be nested for more parts;
--   can be used in SELECT list;
--   can be used in WHERE.
--
-- Главное:
--   CONCAT(value1, value2) = value1 + value2 as text.
--
-- Для 3+ parts часто проще:
--   value1 || value2 || value3
