-- ============================================================
-- DUAL table
-- ============================================================
-- DUAL          - специальная table в Oracle.
--
-- Она нужна, когда мы хотим выполнить SELECT expression,
-- но не хотим брать данные из обычной business table.
--
-- Простыми словами:
--   DUAL используют для вывода одного вычисленного значения.
--
-- Примеры:
--   SELECT 1 + 1
--   FROM dual;
--
--   SELECT SYSDATE
--   FROM dual;
--
--   SELECT 'Hello Oracle'
--   FROM dual;
--
-- DUAL часто встречается:
--   в учебных примерах;
--   в тестировании expressions;
--   при вызове functions;
--   при получении системных значений.


-- ============================================================
-- DUAL structure
-- ============================================================
-- DUAL состоит из:
--   1 column;
--   1 row.
--
-- Column называется:
--   DUMMY
--
-- Обычно значение в DUMMY:
--   X
--
-- Посмотреть структуру:
DESCRIBE dual;

-- Возможный result:
--   Name   Null? Type
--   ------ ----- ----------
--   DUMMY        VARCHAR2(1)
--
-- Посмотреть данные:
SELECT *
FROM dual;

-- Result:
--   DUMMY
--   -----
--   X
--
-- Важно:
--   Обычно нас не интересует значение X.
--   Нам важна сама возможность написать FROM dual
--   и получить одну row для expression.


-- ============================================================
-- Why DUAL is useful
-- ============================================================
-- SELECT обычно читает данные из table.
--
-- Пример:
--   SELECT first_name
--   FROM employees;
--
-- Но иногда нам не нужна table.
-- Нужно просто вычислить expression:
--   2 + 2
--   SYSDATE
--   USER
--   'Hello'
--
-- Для этого удобно использовать DUAL:
SELECT 2 + 2 AS result
FROM dual;

-- Oracle берет одну row из DUAL
-- и вычисляет expression один раз.


-- ============================================================
-- Numeric examples with DUAL
-- ============================================================
-- DUAL удобно использовать для быстрых calculations.
--
-- Пример:
SELECT 10 + 5 AS sum_value
FROM dual;

-- Пример:
SELECT 10 * 5 AS multiply_value
FROM dual;

-- Пример:
SELECT (100 + 50) / 2 AS calculation_result
FROM dual;

-- Здесь нет business table.
-- Oracle просто считает expression и возвращает одну row.


-- ============================================================
-- Text examples with DUAL
-- ============================================================
-- DUAL можно использовать для text literals.
--
-- Пример:
SELECT 'Hello Oracle' AS message
FROM dual;

-- String literal пишется в single quotes.
--
-- Можно соединять strings:
SELECT 'Hello' || ' ' || 'Oracle' AS message
FROM dual;

-- Result:
--   Hello Oracle
--
-- Можно проверить text expression перед использованием
-- в настоящем query.


-- ============================================================
-- Date examples with DUAL
-- ============================================================
-- DUAL часто используют для проверки date/time functions.
--
-- Текущая дата и время сервера:
SELECT SYSDATE AS current_date
FROM dual;

-- Текущая дата и время с долями секунды/time zone:
SELECT SYSTIMESTAMP AS current_timestamp
FROM dual;

-- Добавить 7 дней:
SELECT SYSDATE + 7 AS after_7_days
FROM dual;

-- Показать дату в нужном формате:
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS today_text
FROM dual;

-- Важно:
--   SYSDATE возвращает DATE.
--   SYSTIMESTAMP возвращает TIMESTAMP WITH TIME ZONE.


-- ============================================================
-- User/session examples with DUAL
-- ============================================================
-- DUAL можно использовать для получения информации о session.
--
-- Current database user:
SELECT USER AS current_user
FROM dual;

-- Current date in session time zone:
SELECT CURRENT_DATE AS session_date
FROM dual;

-- Current timestamp in session time zone:
SELECT CURRENT_TIMESTAMP AS session_timestamp
FROM dual;

-- Эти examples полезны,
-- когда нужно быстро проверить подключение и session.


-- ============================================================
-- Functions with DUAL
-- ============================================================
-- DUAL удобно использовать для проверки functions.
--
-- String function:
SELECT UPPER('oracle') AS upper_text
FROM dual;

-- Number function:
SELECT ROUND(125.678, 2) AS rounded_number
FROM dual;

-- Date conversion:
SELECT TO_DATE('2026-08-08', 'YYYY-MM-DD') AS lesson_date
FROM dual;

-- Date formatting:
SELECT TO_CHAR(TO_DATE('2026-08-08', 'YYYY-MM-DD'), 'DD.MM.YYYY') AS lesson_date_text
FROM dual;

-- Важно:
--   Если expression не зависит от table data,
--   DUAL дает удобную one-row основу для SELECT.


-- ============================================================
-- DUAL with aliases
-- ============================================================
-- Alias делает output понятнее.
--
-- Без alias:
SELECT 100 * 12
FROM dual;

-- Column heading может быть неудобным:
--   100*12
--
-- С alias:
SELECT 100 * 12 AS annual_value
FROM dual;

-- Alias с пробелом:
SELECT 100 * 12 AS "Annual Value"
FROM dual;

-- В учебном коде лучше использовать понятные aliases.


-- ============================================================
-- Quote q operator
-- ============================================================
-- q quote operator помогает писать strings,
-- внутри которых есть single quote.
--
-- Проблема:
--   It's my life
--
-- Обычная string с apostrophe так не сработает:
--   SELECT 'It's my life'
--   FROM dual;
--
-- Потому что apostrophe после It завершает string.
--
-- Обычный способ:
SELECT 'It''s my life' AS text_value
FROM dual;

-- Два single quotes внутри string означают один apostrophe.
--
-- Способ через q operator:
SELECT q'<It's my life>' AS text_value
FROM dual;

SELECT q'(It's my life)' AS text_value
FROM dual;

SELECT q'ZIt's my lifeZ' AS text_value
FROM dual;

-- Как читать:
--   q'< ... >'
--   q'( ... )'
--   q'Z ... Z'
--
-- Символы после q' задают границы string.
-- Поэтому apostrophe внутри text не ломает string.


-- ============================================================
-- More q operator examples
-- ============================================================
-- Можно использовать разные delimiters.
--
-- Angle brackets:
SELECT q'<Oracle's SQL>' AS text_value
FROM dual;

-- Parentheses:
SELECT q'(Oracle's SQL)' AS text_value
FROM dual;

-- Square brackets:
SELECT q'[Oracle's SQL]' AS text_value
FROM dual;

-- Custom delimiter:
SELECT q'#Oracle's SQL#' AS text_value
FROM dual;

-- Хорошая практика:
--   Выбирай delimiter, которого нет внутри text.
--
-- Например, если text содержит ):
--   лучше не использовать q'( ... )'
--
-- Можно взять другой delimiter:
SELECT q'<Text with ) character>' AS text_value
FROM dual;


-- ============================================================
-- DUAL is not for real table data
-- ============================================================
-- DUAL не используют для хранения business data.
--
-- Для employees:
--   SELECT first_name
--   FROM employees;
--
-- Для departments:
--   SELECT department_name
--   FROM departments;
--
-- Для expression без business table:
--   SELECT 1 + 1
--   FROM dual;
--
-- Главная мысль:
--   DUAL нужен не потому, что в нем важные данные.
--   DUAL нужен как one-row source для expressions.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что DUAL хранит важные business data.
--    Обычно это просто helper table.
--
-- 2. Писать DESCRIBE dual внутри PL/SQL block.
--    DESCRIBE - client command, его запускают отдельно.
--
-- 3. Забывать FROM dual для expression examples.
--
-- 4. Путать string quotes и alias quotes.
--    String:
--      'Hello'
--
--    Alias with spaces:
--      "My Alias"
--
-- 5. Ломать string с apostrophe.
--    Неправильно:
--      'It's my life'
--
--    Правильно:
--      'It''s my life'
--
--    Или:
--      q'<It's my life>'


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Посмотри структуру DUAL:
--     DESCRIBE dual;
--
-- Task 2:
--   Выведи все из DUAL:
--     SELECT *
--     FROM dual;
--
-- Task 3:
--   Выведи 10 + 20 из dual
--   с alias result_value.
--
-- Task 4:
--   Выведи text 'Hello Oracle'
--   с alias message.
--
-- Task 5:
--   Выведи SYSDATE
--   с alias current_date.
--
-- Task 6:
--   Выведи USER
--   с alias current_user.
--
-- Task 7:
--   Выведи строку:
--     It's my life
--
--   Через обычный escaping:
--     'It''s my life'
--
-- Task 8:
--   Выведи строку:
--     It's my life
--
--   Через q operator:
--     q'<It's my life>'


-- ============================================================
-- Summary
-- ============================================================
-- DUAL:
--   специальная one-row table в Oracle;
--   имеет column DUMMY;
--   часто содержит значение X;
--   используется для SELECT expressions без обычной table.
--
-- Используется для:
--   numeric calculations;
--   string literals;
--   date/time functions;
--   session values;
--   function tests;
--   q quote operator examples.
--
-- Главное:
--   Если нужно проверить expression и не нужна business table,
--   используй FROM dual.
