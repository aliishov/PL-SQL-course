-- ============================================================
-- Character functions
-- Case conversion function: LOWER
-- ============================================================
-- LOWER         - single-row character function.
--
-- Простыми словами:
--   LOWER превращает letters в lowercase.
--
-- Single-row function означает:
--   функция получает value из одной row;
--   возвращает result для этой же row.
--
-- LOWER работает со string/text values.
--
-- Синтаксис:
--   LOWER(char_value)
--
-- Где char_value может быть:
--   string literal;
--   column;
--   text expression;
--   result другой expression.
--
-- В этом уроке только LOWER.
-- Другие character functions будут отдельными темами.


-- ============================================================
-- LOWER with column
-- ============================================================
-- Пример:
SELECT first_name,
       LOWER(first_name)
FROM employees;

-- Meaning:
--   показать original first_name;
--   рядом показать first_name в lowercase.
--
-- Если first_name = 'David',
-- LOWER(first_name) вернет:
--   david
--
-- Важно:
--   LOWER не меняет данные в table employees.
--   Он только показывает converted value в result set.


-- ============================================================
-- LOWER with alias
-- ============================================================
-- Для expression лучше давать alias.
--
-- Пример:
SELECT first_name,
       LOWER(first_name) AS first_name_lower
FROM employees;

-- Alias:
--   first_name_lower
--
-- Без alias output column может называться неудобно:
--   LOWER(FIRST_NAME)
--
-- С alias result set читать легче.


-- ============================================================
-- LOWER with string literal
-- ============================================================
-- String literal пишется в single quotes.
--
-- Пример:
SELECT LOWER('PRIVET, KAK DELa?888') AS text_lower
FROM dual;

-- Result:
--   privet, kak dela?888
--
-- LOWER меняет только letters.
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
-- LOWER with concatenation
-- ============================================================
-- LOWER можно использовать с text expression.
--
-- Пример:
SELECT LOWER('PRIVET' || ' KAK DELa?888') AS text_lower
FROM dual;

-- Oracle сначала соединяет strings:
--   'PRIVET' || ' KAK DELa?888'
--
-- Получает:
--   'PRIVET KAK DELa?888'
--
-- Потом LOWER делает letters lowercase:
--   'privet kak dela?888'


-- ============================================================
-- LOWER in SELECT list
-- ============================================================
-- LOWER часто используется в SELECT list,
-- чтобы показать text в lowercase.
--
-- Пример:
SELECT employee_id,
       first_name,
       LOWER(first_name) AS first_name_lower,
       last_name,
       LOWER(last_name) AS last_name_lower
FROM employees;

-- Result set содержит:
--   original values;
--   lowercase versions.
--
-- Table data не меняется.


-- ============================================================
-- LOWER in WHERE
-- ============================================================
-- LOWER можно использовать в WHERE,
-- чтобы сравнивать text без учета uppercase/lowercase.
--
-- Пример:
SELECT *
FROM employees
WHERE LOWER(first_name) = 'david';

-- Meaning:
--   взять first_name из каждой row;
--   преобразовать first_name в lowercase;
--   сравнить с 'david'.
--
-- Такой query может найти:
--   David
--   DAVID
--   david
--   DaViD
--
-- Потому что перед comparison значение приводится к lowercase.
--
-- Важно:
--   literal справа тоже лучше писать в lowercase:
--     'david'


-- ============================================================
-- LOWER with LIKE
-- ============================================================
-- LOWER можно использовать вместе с LIKE,
-- чтобы искать pattern без учета uppercase/lowercase.
--
-- Пример:
SELECT *
FROM employees
WHERE LOWER(first_name) LIKE '%en%';

-- Meaning:
--   first_name приводится к lowercase;
--   потом проверяется pattern '%en%'.
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
--   LOWER помогает привести text к одному case перед search.


-- ============================================================
-- LOWER with full name expression
-- ============================================================
-- LOWER можно применять к expression,
-- который собирает full name.
--
-- Пример:
SELECT first_name || ' ' || last_name AS full_name,
       LOWER(first_name || ' ' || last_name) AS full_name_lower
FROM employees;

-- Oracle сначала вычисляет:
--   first_name || ' ' || last_name
--
-- Потом LOWER превращает result в lowercase.
--
-- Если full_name = 'Steven King',
-- full_name_lower = 'steven king'.


-- ============================================================
-- LOWER with DUAL
-- ============================================================
-- DUAL удобно использовать,
-- чтобы быстро проверить работу function.
--
-- Пример:
SELECT LOWER('ORACLE SQL') AS result_value
FROM dual;

-- Result:
--   oracle sql
--
-- Еще пример:
SELECT LOWER('ABC xyz 123') AS result_value
FROM dual;

-- Result:
--   abc xyz 123


-- ============================================================
-- LOWER and non-letter characters
-- ============================================================
-- LOWER влияет на letters.
--
-- Обычно не меняются:
--   digits;
--   spaces;
--   punctuation;
--   arithmetic symbols.
--
-- Пример:
SELECT LOWER('A1 B2 C3 !!!') AS result_value
FROM dual;

-- Result:
--   a1 b2 c3 !!!
--
-- Digits и punctuation остались такими же.


-- ============================================================
-- LOWER with non-text values
-- ============================================================
-- LOWER предназначен для character values.
--
-- Oracle может попытаться сделать implicit conversion,
-- если передать number expression.
--
-- Пример:
SELECT LOWER(2 + 2 * 2) AS result_value
FROM dual;

-- Oracle сначала считает:
--   2 + 2 * 2 = 6
--
-- Потом может преобразовать 6 в text:
--   '6'
--
-- LOWER для '6' ничего не меняет.
--
-- Важно:
--   Это учебный пример implicit conversion.
--   В реальном коде лучше передавать в LOWER именно text.
--
-- Лучше:
SELECT LOWER('6') AS result_value
FROM dual;


-- ============================================================
-- LOWER and table data
-- ============================================================
-- LOWER в SELECT не обновляет table.
--
-- Пример:
SELECT first_name,
       LOWER(first_name) AS first_name_lower
FROM employees;

-- Если first_name в table = 'David',
-- query покажет:
--   David
--   david
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
WHERE LOWER(first_name) = 'david';

-- Такой query удобен,
-- если в table values могут быть записаны как:
--   David
--   DAVID
--   david
--
-- Осторожно:
--   function на column может влиять на index usage.
--   Для больших tables это уже performance topic.
--   В этом уроке главное понять behavior LOWER.


-- ============================================================
-- Readable formatting
-- ============================================================
-- Однострочный query:
SELECT first_name, LOWER(first_name) FROM employees;

-- Работает, но читается хуже.
--
-- Лучше:
SELECT first_name,
       LOWER(first_name) AS first_name_lower
FROM employees;

-- Если LOWER используется в WHERE:
SELECT employee_id,
       first_name,
       last_name
FROM employees
WHERE LOWER(first_name) = 'david';

-- Хорошая привычка:
--   expression писать на отдельной строке;
--   давать expression alias;
--   literal для LOWER comparison писать lowercase.


-- ============================================================
-- Simple examples
-- ============================================================
-- Column:
SELECT first_name,
       LOWER(first_name) AS first_name_lower
FROM employees;

-- Literal:
SELECT LOWER('PRIVET, KAK DELa?888') AS text_lower
FROM dual;

-- Concatenation:
SELECT LOWER('PRIVET' || ' KAK DELa?888') AS text_lower
FROM dual;

-- WHERE exact comparison:
SELECT *
FROM employees
WHERE LOWER(first_name) = 'david';

-- WHERE pattern search:
SELECT *
FROM employees
WHERE LOWER(first_name) LIKE '%en%';

-- Full name:
SELECT first_name || ' ' || last_name AS full_name,
       LOWER(first_name || ' ' || last_name) AS full_name_lower
FROM employees;


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что LOWER меняет table data.
--    LOWER в SELECT только показывает converted value.
--
-- 2. Не давать alias expression.
--    Лучше:
--      LOWER(first_name) AS first_name_lower
--
-- 3. Сравнивать LOWER(column) с uppercase literal.
--
--    Менее понятно:
--      WHERE LOWER(first_name) = 'DAVID'
--
--    Лучше:
--      WHERE LOWER(first_name) = 'david'
--
-- 4. Передавать numbers в LOWER без причины.
--    LOWER предназначен для text.
--
-- 5. Забывать single quotes для string literal.
--
--    Неправильно:
--      LOWER(PRIVET)
--
--    Правильно:
--      LOWER('PRIVET')


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Выведи first_name и LOWER(first_name)
--   из employees.
--
-- Task 2:
--   Выведи last_name и LOWER(last_name)
--   из employees.
--
-- Task 3:
--   Выведи LOWER('ORACLE SQL')
--   из dual.
--
-- Task 4:
--   Выведи LOWER('PRIVET' || ' KAK DELa?888')
--   из dual.
--
-- Task 5:
--   Найди employees,
--   у которых LOWER(first_name) равен 'david'.
--
-- Task 6:
--   Найди employees,
--   у которых LOWER(first_name) содержит 'en'.
--
-- Task 7:
--   Выведи full_name:
--     first_name || ' ' || last_name
--
--   И рядом full_name_lower через LOWER.
--
-- Task 8:
--   Объясни своими словами:
--     что делает LOWER;
--     почему LOWER не меняет table data;
--     зачем LOWER используют в WHERE.


-- ============================================================
-- Summary
-- ============================================================
-- LOWER:
--   single-row character function;
--   converts letters to lowercase;
--   works with string literals, columns and text expressions;
--   can be used in SELECT list;
--   can be used in WHERE.
--
-- Главное:
--   LOWER помогает привести text к lowercase
--   для output или case-insensitive comparison.

