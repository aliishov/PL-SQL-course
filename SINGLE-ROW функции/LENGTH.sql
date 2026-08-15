-- ============================================================
-- Character functions
-- String function: LENGTH
-- ============================================================
-- LENGTH        - single-row character function.
--
-- Простыми словами:
--   LENGTH возвращает количество characters в text value.
--
-- Single-row function означает:
--   функция получает value из одной row;
--   возвращает result для этой же row.
--
-- Синтаксис:
--   LENGTH(char_value)
--
-- Где char_value может быть:
--   string literal;
--   column;
--   text expression;
--   result другого expression.
--
-- Result type:
--   NUMBER
--
-- В этом уроке только LENGTH.
-- Другие character functions будут отдельными темами.


-- ============================================================
-- LENGTH with column
-- ============================================================
-- Пример:
SELECT first_name,
       LENGTH(first_name) AS first_name_length
FROM employees;

-- Meaning:
--   показать first_name;
--   рядом показать количество characters в first_name.
--
-- Если first_name = 'David',
-- LENGTH(first_name) вернет:
--   5
--
-- Важно:
--   LENGTH не меняет данные в table employees.
--   Он только возвращает number в result set.


-- ============================================================
-- LENGTH with alias
-- ============================================================
-- Для expression лучше давать alias.
--
-- Пример:
SELECT first_name,
       LENGTH(first_name) AS dlina
FROM employees;

-- Alias:
--   dlina
--
-- Без alias output column может называться неудобно:
--   LENGTH(FIRST_NAME)
--
-- С alias result set читать легче.


-- ============================================================
-- LENGTH with string literal
-- ============================================================
-- String literal пишется в single quotes.
--
-- Пример:
SELECT LENGTH('Raul') AS text_length
FROM dual;

-- Result:
--   4
--
-- Почему:
--   R
--   a
--   u
--   l
--
-- Всего 4 characters.


-- ============================================================
-- LENGTH counts spaces
-- ============================================================
-- Spaces тоже считаются characters.
--
-- Пример:
SELECT LENGTH('Raul Aliishov') AS text_length
FROM dual;

-- Result:
--   13
--
-- Почему:
--   Raul       = 4 characters
--   space      = 1 character
--   Aliishov   = 8 characters
--   total      = 13
--
-- Пример с несколькими spaces:
SELECT LENGTH('Raul       Aliishov') AS text_length
FROM dual;

-- Между Raul и Aliishov есть несколько spaces.
-- Каждый space входит в length.
--
-- Поэтому эта строка длиннее,
-- чем 'Raul Aliishov'.


-- ============================================================
-- LENGTH and empty string
-- ============================================================
-- В Oracle empty string обычно считается NULL.
--
-- Пример:
SELECT LENGTH('') AS empty_text_length
FROM dual;

-- Result обычно:
--   NULL
--
-- Почему:
--   '' в Oracle рассматривается как NULL.
--
-- Это важный Oracle-specific nuance.


-- ============================================================
-- LENGTH and NULL
-- ============================================================
-- Если value = NULL,
-- LENGTH возвращает NULL.
--
-- Пример:
SELECT LENGTH(NULL) AS null_length
FROM dual;

-- Result:
--   NULL
--
-- Почему не 0?
--   NULL означает absence of value.
--
-- 0 characters и NULL - разные идеи.
--
-- LENGTH(NULL) не знает length,
-- потому что value отсутствует.


-- ============================================================
-- LENGTH with concatenation
-- ============================================================
-- LENGTH можно использовать с text expression.
--
-- Пример:
SELECT 'Name is ' || first_name || ' and surname is ' || last_name AS full_name,
       LENGTH('Name is ' || first_name || ' and surname is ' || last_name) AS full_name_length
FROM employees;

-- Oracle сначала собирает text expression:
--   'Name is ' || first_name || ' and surname is ' || last_name
--
-- Потом LENGTH считает количество characters
-- в получившемся text.
--
-- Важно:
--   spaces внутри literals тоже считаются.


-- ============================================================
-- LENGTH with numbers
-- ============================================================
-- LENGTH предназначен для character values.
--
-- Но Oracle может попытаться сделать implicit conversion,
-- если передать number.
--
-- Пример:
SELECT salary,
       LENGTH(salary) AS salary_length
FROM employees;

-- Oracle может преобразовать salary в text
-- и потом посчитать количество characters.
--
-- Еще пример:
SELECT salary,
       LENGTH(salary * 100) AS salary_expression_length
FROM employees;

-- Oracle сначала вычисляет:
--   salary * 100
--
-- Потом может преобразовать result в text
-- и посчитать length.
--
-- Важно:
--   Это implicit conversion.
--   В реальном коде лучше понимать,
--   какой format number получит при conversion.


-- ============================================================
-- LENGTH with dates
-- ============================================================
-- LENGTH может получить DATE через implicit conversion,
-- но result зависит от session date format.
--
-- Пример:
SELECT hire_date,
       LENGTH(hire_date) AS hire_date_length
FROM employees;

-- Oracle может преобразовать hire_date в text.
--
-- Например:
--   15-Aug-26
--   2026-08-15
--   15.08.2026
--
-- Разный text format может дать разный length.
--
-- Важно:
--   Для точного date formatting
--   обычно используют отдельные conversion functions.
--   Это будет отдельной темой.


-- ============================================================
-- LENGTH in WHERE
-- ============================================================
-- LENGTH можно использовать в WHERE,
-- чтобы фильтровать rows по длине text.
--
-- Пример:
SELECT country_name
FROM countries
WHERE LENGTH(country_name) > 8;

-- Meaning:
--   показать countries,
--   у которых country_name длиннее 8 characters.
--
-- Oracle для каждой row проверяет:
--   LENGTH(country_name) > 8
--
-- Если condition TRUE,
-- row попадает в result set.


-- ============================================================
-- LENGTH in ORDER BY
-- ============================================================
-- LENGTH можно использовать в ORDER BY,
-- чтобы сортировать rows по длине text.
--
-- Пример:
SELECT country_name
FROM countries
ORDER BY LENGTH(country_name);

-- Meaning:
--   показать country_name;
--   отсортировать countries от короткого name к длинному.
--
-- Еще пример:
SELECT country_name,
       LENGTH(country_name) AS country_name_length
FROM countries
ORDER BY country_name_length;

-- Alias из SELECT list можно использовать в ORDER BY.


-- ============================================================
-- LENGTH in SELECT list
-- ============================================================
-- LENGTH часто используют в SELECT list,
-- чтобы рядом с text показать его length.
--
-- Пример:
SELECT employee_id,
       first_name,
       LENGTH(first_name) AS first_name_length,
       last_name,
       LENGTH(last_name) AS last_name_length
FROM employees;

-- Result set содержит:
--   original text values;
--   number of characters.
--
-- Table data не меняется.


-- ============================================================
-- LENGTH with DUAL
-- ============================================================
-- DUAL удобно использовать,
-- чтобы быстро проверить работу function.
--
-- Пример:
SELECT LENGTH('Oracle SQL') AS text_length
FROM dual;

-- Result:
--   10
--
-- Почему:
--   Oracle = 6
--   space  = 1
--   SQL    = 3
--   total  = 10


-- ============================================================
-- LENGTH and character semantics
-- ============================================================
-- LENGTH считает characters.
--
-- Это не всегда то же самое, что bytes.
--
-- В Unicode один character может занимать больше одного byte.
--
-- В этом уроке главное:
--   LENGTH отвечает на вопрос:
--     "Сколько characters в text?"
--
-- Byte-length и related functions будут отдельной темой,
-- если понадобятся.


-- ============================================================
-- Readable formatting
-- ============================================================
-- Однострочный query:
SELECT first_name, LENGTH(first_name) FROM employees;

-- Работает, но читается хуже.
--
-- Лучше:
SELECT first_name,
       LENGTH(first_name) AS first_name_length
FROM employees;

-- Если LENGTH используется в WHERE:
SELECT country_name
FROM countries
WHERE LENGTH(country_name) > 8;

-- Хорошая привычка:
--   expression писать на отдельной строке;
--   давать expression alias;
--   ясно называть length column.


-- ============================================================
-- Simple examples
-- ============================================================
-- Column:
SELECT first_name,
       LENGTH(first_name) AS first_name_length
FROM employees;

-- Literal:
SELECT LENGTH('Raul') AS text_length
FROM dual;

-- Literal with spaces:
SELECT LENGTH('Raul       Aliishov') AS text_length
FROM dual;

-- Number implicit conversion:
SELECT salary,
       LENGTH(salary) AS salary_length
FROM employees;

-- Date implicit conversion:
SELECT hire_date,
       LENGTH(hire_date) AS hire_date_length
FROM employees;

-- Concatenation:
SELECT 'Name is ' || first_name || ' and surname is ' || last_name AS full_name,
       LENGTH('Name is ' || first_name || ' and surname is ' || last_name) AS full_name_length
FROM employees;

-- WHERE:
SELECT country_name
FROM countries
WHERE LENGTH(country_name) > 8;

-- ORDER BY:
SELECT country_name
FROM countries
ORDER BY LENGTH(country_name);


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что LENGTH не считает spaces.
--    Spaces считаются characters.
--
-- 2. Думать, что LENGTH(NULL) возвращает 0.
--    LENGTH(NULL) возвращает NULL.
--
-- 3. Думать, что empty string в Oracle имеет length 0.
--    В Oracle '' обычно считается NULL.
--
-- 4. Использовать LENGTH(date_column)
--    и забывать, что date сначала преобразуется в text.
--
-- 5. Использовать LENGTH(number_column)
--    и забывать про implicit conversion.
--
-- 6. Не давать alias expression.
--
--    Лучше:
--      LENGTH(first_name) AS first_name_length


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Выведи first_name и LENGTH(first_name)
--   из employees.
--
-- Task 2:
--   Выведи last_name и LENGTH(last_name)
--   из employees.
--
-- Task 3:
--   Выведи LENGTH('Raul')
--   из dual.
--
-- Task 4:
--   Сравни:
--     LENGTH('Raul Aliishov')
--     LENGTH('Raul       Aliishov')
--
--   Объясни difference.
--
-- Task 5:
--   Выведи full_name:
--     'Name is ' || first_name || ' and surname is ' || last_name
--
--   И рядом full_name_length через LENGTH.
--
-- Task 6:
--   Выведи countries,
--   где LENGTH(country_name) больше 8.
--
-- Task 7:
--   Выведи countries
--   и отсортируй их по LENGTH(country_name).
--
-- Task 8:
--   Проверь:
--     LENGTH(NULL)
--     LENGTH('')
--
--   Объясни result.
--
-- Task 9:
--   Объясни своими словами:
--     что делает LENGTH;
--     почему spaces считаются;
--     почему LENGTH не меняет table data.


-- ============================================================
-- Summary
-- ============================================================
-- LENGTH:
--   single-row character function;
--   returns number of characters;
--   works with string literals, columns and text expressions;
--   spaces are counted;
--   NULL returns NULL;
--   can be used in SELECT list;
--   can be used in WHERE;
--   can be used in ORDER BY.
--
-- Главное:
--   LENGTH(text_value) отвечает на вопрос:
--     "Сколько characters в этом text?"

