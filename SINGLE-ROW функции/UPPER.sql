-- ============================================================
-- Character functions
-- Case conversion function: UPPER
-- ============================================================
-- UPPER         - single-row character function.
--
-- Простыми словами:
--   UPPER превращает letters в uppercase.
--
-- Single-row function означает:
--   функция получает value из одной row;
--   возвращает result для этой же row.
--
-- UPPER работает со string/text values.
--
-- Синтаксис:
--   UPPER(char_value)
--
-- Где char_value может быть:
--   string literal;
--   column;
--   text expression;
--   result другой expression.
--
-- В этом уроке только UPPER.
-- Другие character functions будут отдельными темами.


-- ============================================================
-- UPPER with column
-- ============================================================
-- Пример:
SELECT first_name,
       UPPER(first_name)
FROM employees;

-- Meaning:
--   показать original first_name;
--   рядом показать first_name в uppercase.
--
-- Если first_name = 'David',
-- UPPER(first_name) вернет:
--   DAVID
--
-- Важно:
--   UPPER не меняет данные в table employees.
--   Он только показывает converted value в result set.


-- ============================================================
-- UPPER with alias
-- ============================================================
-- Для expression лучше давать alias.
--
-- Пример:
SELECT first_name,
       UPPER(first_name) AS first_name_upper
FROM employees;

-- Alias:
--   first_name_upper
--
-- Без alias output column может называться неудобно:
--   UPPER(FIRST_NAME)
--
-- С alias result set читать легче.


-- ============================================================
-- UPPER with string literal
-- ============================================================
-- String literal пишется в single quotes.
--
-- Пример:
SELECT UPPER('PRIVET, KAK DELa?888') AS text_upper
FROM dual;

-- Result:
--   PRIVET, KAK DELA?888
--
-- UPPER меняет только letters.
--
-- Не меняются:
--   spaces;
--   commas;
--   question marks;
--   digits.
--
-- Поэтому:
--   888 остается 888.


-- ============================================================
-- UPPER with concatenation
-- ============================================================
-- UPPER можно использовать с text expression.
--
-- Пример:
SELECT UPPER('PRIVET' || ' KAK DELa?888') AS text_upper
FROM dual;

-- Oracle сначала соединяет strings:
--   'PRIVET' || ' KAK DELa?888'
--
-- Получает:
--   'PRIVET KAK DELa?888'
--
-- Потом UPPER делает letters uppercase:
--   'PRIVET KAK DELA?888'


-- ============================================================
-- UPPER in SELECT list
-- ============================================================
-- UPPER часто используется в SELECT list,
-- чтобы показать text в uppercase.
--
-- Пример:
SELECT employee_id,
       first_name,
       UPPER(first_name) AS first_name_upper,
       last_name,
       UPPER(last_name) AS last_name_upper
FROM employees;

-- Result set содержит:
--   original values;
--   uppercase versions.
--
-- Table data не меняется.


-- ============================================================
-- UPPER in WHERE
-- ============================================================
-- UPPER можно использовать в WHERE,
-- чтобы сравнивать text без учета uppercase/lowercase.
--
-- Пример:
SELECT *
FROM employees
WHERE UPPER(first_name) = 'DAVID';

-- Meaning:
--   взять first_name из каждой row;
--   преобразовать first_name в uppercase;
--   сравнить с 'DAVID'.
--
-- Такой query может найти:
--   David
--   DAVID
--   david
--   DaViD
--
-- Потому что перед comparison значение приводится к uppercase.
--
-- Важно:
--   literal справа тоже лучше писать в uppercase:
--     'DAVID'


-- ============================================================
-- UPPER with LIKE
-- ============================================================
-- UPPER можно использовать вместе с LIKE,
-- чтобы искать pattern без учета uppercase/lowercase.
--
-- Пример:
SELECT *
FROM employees
WHERE UPPER(first_name) LIKE '%EN%';

-- Meaning:
--   first_name приводится к uppercase;
--   потом проверяется pattern '%EN%'.
--
-- Такой query может найти names,
-- где en встречается в любом case.
--
-- Примеры possible matches:
--   Steven
--   Ellen
--   Jennifer
--
-- LIKE уже отдельная тема.
-- Здесь главное:
--   UPPER помогает привести text к одному case перед search.


-- ============================================================
-- UPPER with full name expression
-- ============================================================
-- UPPER можно применять к expression,
-- который собирает full name.
--
-- Пример:
SELECT first_name || ' ' || last_name AS full_name,
       UPPER(first_name || ' ' || last_name) AS full_name_upper
FROM employees;

-- Oracle сначала вычисляет:
--   first_name || ' ' || last_name
--
-- Потом UPPER превращает result в uppercase.
--
-- Если full_name = 'Steven King',
-- full_name_upper = 'STEVEN KING'.


-- ============================================================
-- UPPER with DUAL
-- ============================================================
-- DUAL удобно использовать,
-- чтобы быстро проверить работу function.
--
-- Пример:
SELECT UPPER('oracle sql') AS result_value
FROM dual;

-- Result:
--   ORACLE SQL
--
-- Еще пример:
SELECT UPPER('abc XYZ 123') AS result_value
FROM dual;

-- Result:
--   ABC XYZ 123


-- ============================================================
-- UPPER and non-letter characters
-- ============================================================
-- UPPER влияет на letters.
--
-- Обычно не меняются:
--   digits;
--   spaces;
--   punctuation;
--   arithmetic symbols.
--
-- Пример:
SELECT UPPER('a1 b2 c3 !!!') AS result_value
FROM dual;

-- Result:
--   A1 B2 C3 !!!
--
-- Digits и punctuation остались такими же.


-- ============================================================
-- UPPER with non-text values
-- ============================================================
-- UPPER предназначен для character values.
--
-- Oracle может попытаться сделать implicit conversion,
-- если передать number expression.
--
-- Пример:
SELECT UPPER(2 + 2 * 2) AS result_value
FROM dual;

-- Oracle сначала считает:
--   2 + 2 * 2 = 6
--
-- Потом может преобразовать 6 в text:
--   '6'
--
-- UPPER для '6' ничего не меняет.
--
-- Важно:
--   Это учебный пример implicit conversion.
--   В реальном коде лучше передавать в UPPER именно text.
--
-- Лучше:
SELECT UPPER('6') AS result_value
FROM dual;


-- ============================================================
-- UPPER and table data
-- ============================================================
-- UPPER в SELECT не обновляет table.
--
-- Пример:
SELECT first_name,
       UPPER(first_name) AS first_name_upper
FROM employees;

-- Если first_name в table = 'David',
-- query покажет:
--   David
--   DAVID
--
-- Но в table значение останется:
--   David
--
-- Чтобы изменить данные в table,
-- нужен UPDATE.
-- В этом уроке UPDATE не разбираем.


-- ============================================================
-- Case-insensitive search idea
-- ============================================================
-- Частая задача:
--   пользователь вводит text в разном case,
--   а мы хотим найти row независимо от case.
--
-- Пример:
SELECT employee_id,
       first_name,
       last_name
FROM employees
WHERE UPPER(first_name) = 'DAVID';

-- Такой query удобен,
-- если в table values могут быть записаны как:
--   David
--   DAVID
--   david
--
-- Осторожно:
--   function на column может влиять на index usage.
--   Для больших tables это уже performance topic.
--   В этом уроке главное понять behavior UPPER.


-- ============================================================
-- Readable formatting
-- ============================================================
-- Однострочный query:
SELECT first_name, UPPER(first_name) FROM employees;

-- Работает, но читается хуже.
--
-- Лучше:
SELECT first_name,
       UPPER(first_name) AS first_name_upper
FROM employees;

-- Если UPPER используется в WHERE:
SELECT employee_id,
       first_name,
       last_name
FROM employees
WHERE UPPER(first_name) = 'DAVID';

-- Хорошая привычка:
--   expression писать на отдельной строке;
--   давать expression alias;
--   literal для UPPER comparison писать uppercase.


-- ============================================================
-- Simple examples
-- ============================================================
-- Column:
SELECT first_name,
       UPPER(first_name) AS first_name_upper
FROM employees;

-- Literal:
SELECT UPPER('PRIVET, KAK DELa?888') AS text_upper
FROM dual;

-- Concatenation:
SELECT UPPER('PRIVET' || ' KAK DELa?888') AS text_upper
FROM dual;

-- WHERE exact comparison:
SELECT *
FROM employees
WHERE UPPER(first_name) = 'DAVID';

-- WHERE pattern search:
SELECT *
FROM employees
WHERE UPPER(first_name) LIKE '%EN%';

-- Full name:
SELECT first_name || ' ' || last_name AS full_name,
       UPPER(first_name || ' ' || last_name) AS full_name_upper
FROM employees;


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что UPPER меняет table data.
--    UPPER в SELECT только показывает converted value.
--
-- 2. Не давать alias expression.
--    Лучше:
--      UPPER(first_name) AS first_name_upper
--
-- 3. Сравнивать UPPER(column) с lowercase literal.
--
--    Менее понятно:
--      WHERE UPPER(first_name) = 'david'
--
--    Лучше:
--      WHERE UPPER(first_name) = 'DAVID'
--
-- 4. Передавать numbers в UPPER без причины.
--    UPPER предназначен для text.
--
-- 5. Забывать single quotes для string literal.
--
--    Неправильно:
--      UPPER(privet)
--
--    Правильно:
--      UPPER('privet')
--
-- 6. Писать lowercase pattern после UPPER(column).
--
--    Менее понятно:
--      WHERE UPPER(first_name) LIKE '%en%'
--
--    Лучше:
--      WHERE UPPER(first_name) LIKE '%EN%'


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Выведи first_name и UPPER(first_name)
--   из employees.
--
-- Task 2:
--   Выведи last_name и UPPER(last_name)
--   из employees.
--
-- Task 3:
--   Выведи UPPER('oracle sql')
--   из dual.
--
-- Task 4:
--   Выведи UPPER('PRIVET' || ' KAK DELa?888')
--   из dual.
--
-- Task 5:
--   Найди employees,
--   у которых UPPER(first_name) равен 'DAVID'.
--
-- Task 6:
--   Найди employees,
--   у которых UPPER(first_name) содержит 'EN'.
--
-- Task 7:
--   Выведи full_name:
--     first_name || ' ' || last_name
--
--   И рядом full_name_upper через UPPER.
--
-- Task 8:
--   Объясни своими словами:
--     что делает UPPER;
--     почему UPPER не меняет table data;
--     зачем UPPER используют в WHERE.


-- ============================================================
-- Summary
-- ============================================================
-- UPPER:
--   single-row character function;
--   converts letters to uppercase;
--   works with string literals, columns and text expressions;
--   can be used in SELECT list;
--   can be used in WHERE.
--
-- Главное:
--   UPPER помогает привести text к uppercase
--   для output или case-insensitive comparison.

