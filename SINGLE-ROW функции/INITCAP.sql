-- ============================================================
-- Character functions
-- Case conversion function: INITCAP
-- ============================================================
-- INITCAP       - single-row character function.
--
-- Простыми словами:
--   INITCAP делает первую букву каждого слова uppercase,
--   а остальные буквы lowercase.
--
-- Single-row function означает:
--   функция получает value из одной row;
--   возвращает result для этой же row.
--
-- INITCAP работает со string/text values.
--
-- Синтаксис:
--   INITCAP(char_value)
--
-- Где char_value может быть:
--   string literal;
--   column;
--   text expression;
--   result другой expression.
--
-- В этом уроке только INITCAP.
-- Другие character functions будут отдельными темами.


-- ============================================================
-- INITCAP with column
-- ============================================================
-- Пример:
SELECT first_name,
       INITCAP(first_name)
FROM employees;

-- Meaning:
--   показать original first_name;
--   рядом показать first_name в initcap format.
--
-- Если first_name = 'DAVID',
-- INITCAP(first_name) вернет:
--   David
--
-- Если first_name = 'david',
-- INITCAP(first_name) тоже вернет:
--   David
--
-- Важно:
--   INITCAP не меняет данные в table employees.
--   Он только показывает converted value в result set.


-- ============================================================
-- INITCAP with alias
-- ============================================================
-- Для expression лучше давать alias.
--
-- Пример:
SELECT first_name,
       INITCAP(first_name) AS first_name_initcap
FROM employees;

-- Alias:
--   first_name_initcap
--
-- Без alias output column может называться неудобно:
--   INITCAP(FIRST_NAME)
--
-- С alias result set читать легче.


-- ============================================================
-- INITCAP with string literal
-- ============================================================
-- String literal пишется в single quotes.
--
-- Пример:
SELECT INITCAP('private, kakdela') AS text_initcap
FROM dual;

-- Result:
--   Private, Kakdela
--
-- INITCAP:
--   первую букву слова делает uppercase;
--   остальные буквы слова делает lowercase.
--
-- Еще пример:
SELECT INITCAP('PRIVET, KAK DELa?888') AS text_initcap
FROM dual;

-- Result:
--   Privet, Kak Dela?888
--
-- Digits не меняются.


-- ============================================================
-- INITCAP with concatenation
-- ============================================================
-- INITCAP можно использовать с text expression.
--
-- Пример:
SELECT INITCAP('PRIVET' || ' KAK DELa?888') AS text_initcap
FROM dual;

-- Oracle сначала соединяет strings:
--   'PRIVET' || ' KAK DELa?888'
--
-- Получает:
--   'PRIVET KAK DELa?888'
--
-- Потом INITCAP приводит words к initcap format:
--   'Privet Kak Dela?888'


-- ============================================================
-- INITCAP and words
-- ============================================================
-- INITCAP работает по словам.
--
-- Word обычно начинается после:
--   space;
--   punctuation;
--   other non-letter/non-digit separator.
--
-- Пример:
SELECT INITCAP('hello oracle sql') AS result_value
FROM dual;

-- Result:
--   Hello Oracle Sql
--
-- Пример с separators:
SELECT INITCAP('hello-oracle/sql') AS result_value
FROM dual;

-- Possible result:
--   Hello-Oracle/Sql
--
-- Почему:
--   после - и / начинается новое word.
--
-- Важно:
--   INITCAP не "понимает" human names идеально.
--   Он просто применяет правило capitalization.


-- ============================================================
-- INITCAP in SELECT list
-- ============================================================
-- INITCAP часто используется в SELECT list,
-- чтобы красиво показать names или text.
--
-- Пример:
SELECT employee_id,
       first_name,
       INITCAP(first_name) AS first_name_initcap,
       last_name,
       INITCAP(last_name) AS last_name_initcap
FROM employees;

-- Result set содержит:
--   original values;
--   initcap versions.
--
-- Table data не меняется.


-- ============================================================
-- INITCAP in WHERE
-- ============================================================
-- INITCAP можно использовать в WHERE,
-- чтобы сравнивать text в normalized format.
--
-- Пример:
SELECT *
FROM employees
WHERE INITCAP(first_name) = 'David';

-- Meaning:
--   взять first_name из каждой row;
--   преобразовать first_name в initcap format;
--   сравнить с 'David'.
--
-- Такой query может найти:
--   David
--   DAVID
--   david
--   DaViD
--
-- Потому что перед comparison значение приводится к:
--   David
--
-- Важно:
--   literal справа тоже лучше писать в initcap format:
--     'David'


-- ============================================================
-- INITCAP with LIKE
-- ============================================================
-- INITCAP можно использовать вместе с LIKE.
--
-- Пример:
SELECT *
FROM employees
WHERE INITCAP(first_name) LIKE '%en%';

-- Meaning:
--   first_name приводится к initcap format;
--   потом проверяется pattern '%en%'.
--
-- Такой query может найти names,
-- где en встречается после normalization.
--
-- Примеры possible matches:
--   Steven
--   Ellen
--   Jennifer
--
-- LIKE уже отдельная тема.
-- Здесь главное:
--   INITCAP может участвовать в text expression перед search.


-- ============================================================
-- INITCAP with full name expression
-- ============================================================
-- INITCAP можно применять к expression,
-- который собирает full name.
--
-- Пример:
SELECT first_name || ' ' || last_name AS full_name,
       INITCAP(first_name || ' ' || last_name) AS full_name_initcap
FROM employees;

-- Oracle сначала вычисляет:
--   first_name || ' ' || last_name
--
-- Потом INITCAP превращает result в initcap format.
--
-- Если full_name = 'STEVEN KING',
-- full_name_initcap = 'Steven King'.


-- ============================================================
-- INITCAP with DUAL
-- ============================================================
-- DUAL удобно использовать,
-- чтобы быстро проверить работу function.
--
-- Пример:
SELECT INITCAP('oracle sql') AS result_value
FROM dual;

-- Result:
--   Oracle Sql
--
-- Еще пример:
SELECT INITCAP('abc XYZ 123') AS result_value
FROM dual;

-- Result:
--   Abc Xyz 123


-- ============================================================
-- INITCAP and non-letter characters
-- ============================================================
-- INITCAP влияет на letters.
--
-- Обычно не меняются:
--   digits;
--   spaces;
--   punctuation.
--
-- Но punctuation может разделять words.
--
-- Пример:
SELECT INITCAP('a1 b2 c3 !!!') AS result_value
FROM dual;

-- Result:
--   A1 B2 C3 !!!
--
-- Digits и punctuation остались.
-- Letters стали initcap.


-- ============================================================
-- INITCAP with non-text values
-- ============================================================
-- INITCAP предназначен для character values.
--
-- Oracle может попытаться сделать implicit conversion,
-- если передать number expression.
--
-- Пример:
SELECT INITCAP(2 + 2 * 2) AS result_value
FROM dual;

-- Oracle сначала считает:
--   2 + 2 * 2 = 6
--
-- Потом может преобразовать 6 в text:
--   '6'
--
-- INITCAP для '6' ничего не меняет.
--
-- Важно:
--   Это учебный пример implicit conversion.
--   В реальном коде лучше передавать в INITCAP именно text.
--
-- Лучше:
SELECT INITCAP('6') AS result_value
FROM dual;


-- ============================================================
-- INITCAP and table data
-- ============================================================
-- INITCAP в SELECT не обновляет table.
--
-- Пример:
SELECT first_name,
       INITCAP(first_name) AS first_name_initcap
FROM employees;

-- Если first_name в table = 'DAVID',
-- query покажет:
--   DAVID
--   David
--
-- Но в table значение останется:
--   DAVID
--
-- Чтобы изменить данные в table,
-- нужен UPDATE.
-- В этом уроке UPDATE не разбираем.


-- ============================================================
-- Name formatting idea
-- ============================================================
-- Частая задача:
--   показать names в красивом формате.
--
-- Пример:
SELECT INITCAP(first_name) AS first_name,
       INITCAP(last_name) AS last_name
FROM employees;

-- Это удобно для output,
-- если values в table могут быть в разном case.
--
-- Осторожно:
--   INITCAP не всегда идеально подходит для real names.
--
-- Например, сложные names могут иметь специальные правила:
--   McDonald
--   O'Connor
--   van Gogh
--
-- INITCAP применяет общее правило,
-- а не человеческую grammar.


-- ============================================================
-- Readable formatting
-- ============================================================
-- Однострочный query:
SELECT first_name, INITCAP(first_name) FROM employees;

-- Работает, но читается хуже.
--
-- Лучше:
SELECT first_name,
       INITCAP(first_name) AS first_name_initcap
FROM employees;

-- Если INITCAP используется в WHERE:
SELECT employee_id,
       first_name,
       last_name
FROM employees
WHERE INITCAP(first_name) = 'David';

-- Хорошая привычка:
--   expression писать на отдельной строке;
--   давать expression alias;
--   literal для INITCAP comparison писать в initcap format.


-- ============================================================
-- Simple examples
-- ============================================================
-- Column:
SELECT first_name,
       INITCAP(first_name) AS first_name_initcap
FROM employees;

-- Literal:
SELECT INITCAP('private, kakdela') AS text_initcap
FROM dual;

-- Concatenation:
SELECT INITCAP('PRIVET' || ' KAK DELa?888') AS text_initcap
FROM dual;

-- WHERE exact comparison:
SELECT *
FROM employees
WHERE INITCAP(first_name) = 'David';

-- WHERE pattern search:
SELECT *
FROM employees
WHERE INITCAP(first_name) LIKE '%en%';

-- Full name:
SELECT first_name || ' ' || last_name AS full_name,
       INITCAP(first_name || ' ' || last_name) AS full_name_initcap
FROM employees;


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что INITCAP меняет table data.
--    INITCAP в SELECT только показывает converted value.
--
-- 2. Не давать alias expression.
--    Лучше:
--      INITCAP(first_name) AS first_name_initcap
--
-- 3. Думать, что INITCAP делает только первую букву всей строки uppercase.
--    INITCAP работает с каждым word.
--
-- 4. Передавать numbers в INITCAP без причины.
--    INITCAP предназначен для text.
--
-- 5. Забывать single quotes для string literal.
--
--    Неправильно:
--      INITCAP(private)
--
--    Правильно:
--      INITCAP('private')
--
-- 6. Думать, что INITCAP идеально форматирует любые human names.
--    Он применяет общее правило capitalization.


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Выведи first_name и INITCAP(first_name)
--   из employees.
--
-- Task 2:
--   Выведи last_name и INITCAP(last_name)
--   из employees.
--
-- Task 3:
--   Выведи INITCAP('oracle sql')
--   из dual.
--
-- Task 4:
--   Выведи INITCAP('PRIVET' || ' KAK DELa?888')
--   из dual.
--
-- Task 5:
--   Найди employees,
--   у которых INITCAP(first_name) равен 'David'.
--
-- Task 6:
--   Найди employees,
--   у которых INITCAP(first_name) содержит 'en'.
--
-- Task 7:
--   Выведи full_name:
--     first_name || ' ' || last_name
--
--   И рядом full_name_initcap через INITCAP.
--
-- Task 8:
--   Объясни своими словами:
--     что делает INITCAP;
--     чем INITCAP отличается от UPPER;
--     чем INITCAP отличается от LOWER;
--     почему INITCAP не меняет table data.


-- ============================================================
-- Summary
-- ============================================================
-- INITCAP:
--   single-row character function;
--   делает первую букву каждого word uppercase;
--   остальные буквы word делает lowercase;
--   works with string literals, columns and text expressions;
--   can be used in SELECT list;
--   can be used in WHERE.
--
-- Главное:
--   INITCAP помогает показать text в capitalized format,
--   especially for names and readable output.

