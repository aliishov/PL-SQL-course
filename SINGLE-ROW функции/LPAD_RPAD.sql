-- Character functions
-- Case manipulations functions
-- LPAD(s, n, p)
-- RPAD(s, n, p)

SELECT LPAD('Raul', 7, '#') 
FROM dual;

SELECT RPAD('Raul', 7, '#') 
FROM dual;

SELECT first_name , 
       LPAD(first_name, 25, '$')
FROM employees;

SELECT first_name , 
       LPAD(first_name, 25, '$'),
       RPAD(first_name, 25, '$')
FROM employees;

SELECT first_name , 
       LPAD(first_name, 25, 'ABC')
FROM employees;

SELECT RPAD('privet', 6, '!')
FROM dual;

SELECT RPAD('privet', 5, '!')
FROM dual;

SELECT RPAD(SYSDATE, 6, '!')
FROM dual;

SELECT RPAD(first_name, 15, ' ') || LPAD (salary, 8, ' ')
FROM employees;
-- ============================================================
-- Character functions
-- String functions: LPAD and RPAD
-- ============================================================
-- LPAD          - single-row character function.
--                 Добавляет characters слева до указанной длины.
--
-- RPAD          - single-row character function.
--                 Добавляет characters справа до указанной длины.
--
-- Простыми словами:
--   LPAD = left padding.
--   RPAD = right padding.
--
-- Padding       - добавление символов,
--                 чтобы text стал нужной length.
--
-- Синтаксис:
--   LPAD(char_value, total_length, pad_string)
--   RPAD(char_value, total_length, pad_string)
--
-- Где:
--   char_value    - исходный text;
--   total_length  - итоговая длина result;
--   pad_string    - чем заполнить недостающие characters.
--
-- В этом уроке только LPAD и RPAD.
-- Другие character functions будут отдельными темами.


-- ============================================================
-- LPAD basic idea
-- ============================================================
-- LPAD добавляет pad_string слева.
--
-- Пример:
SELECT LPAD('Oracle', 10, '*') AS padded_text
FROM dual;

-- Result:
--   ****Oracle
--
-- Почему:
--   'Oracle' имеет length 6.
--   total_length = 10.
--   Нужно добавить 4 characters.
--   LPAD добавляет их слева.
--
-- Итоговая length result:
--   10


-- ============================================================
-- RPAD basic idea
-- ============================================================
-- RPAD добавляет pad_string справа.
--
-- Пример:
SELECT RPAD('Oracle', 10, '*') AS padded_text
FROM dual;

-- Result:
--   Oracle****
--
-- Почему:
--   'Oracle' имеет length 6.
--   total_length = 10.
--   Нужно добавить 4 characters.
--   RPAD добавляет их справа.
--
-- Итоговая length result:
--   10


-- ============================================================
-- LPAD and RPAD side by side
-- ============================================================
-- Пример:
SELECT 'Oracle' AS original_text,
       LPAD('Oracle', 10, '*') AS left_padded,
       RPAD('Oracle', 10, '*') AS right_padded
FROM dual;

-- Result:
--   original_text = Oracle
--   left_padded   = ****Oracle
--   right_padded  = Oracle****
--
-- Главное отличие:
--   LPAD добавляет слева.
--   RPAD добавляет справа.


-- ============================================================
-- Default padding character
-- ============================================================
-- Третий argument pad_string можно не указывать.
--
-- Тогда Oracle обычно использует space.
--
-- Пример:
SELECT LPAD('Oracle', 10) AS left_padded,
       RPAD('Oracle', 10) AS right_padded
FROM dual;

-- Result выглядит так:
--   '    Oracle'
--   'Oracle    '
--
-- Spaces сложно увидеть глазами.
-- Поэтому для обучения часто используют '*', '.', '0' или '-'.


-- ============================================================
-- LPAD with zero
-- ============================================================
-- LPAD часто используют для codes,
-- где нужно добавить zeros слева.
--
-- Пример:
SELECT LPAD('25', 5, '0') AS code_value
FROM dual;

-- Result:
--   00025
--
-- Meaning:
--   сделать text длиной 5 characters;
--   недостающие characters заполнить zeros слева.
--
-- Еще пример:
SELECT employee_id,
       LPAD(employee_id, 6, '0') AS employee_code
FROM employees;

-- Если employee_id = 101,
-- employee_code может быть:
--   000101


-- ============================================================
-- RPAD for visual alignment
-- ============================================================
-- RPAD удобно использовать,
-- чтобы выровнять text справа padding symbols.
--
-- Пример:
SELECT RPAD(first_name, 15, '.') AS first_name_padded,
       salary
FROM employees;

-- Если first_name = 'David',
-- first_name_padded:
--   David..........
--
-- Это может быть удобно для readable text output.
--
-- Table data не меняется.
-- RPAD только создает output value.


-- ============================================================
-- LPAD / RPAD with columns
-- ============================================================
-- LPAD и RPAD можно использовать с table columns.
--
-- Пример:
SELECT first_name,
       LPAD(first_name, 15, '*') AS first_name_lpad,
       RPAD(first_name, 15, '*') AS first_name_rpad
FROM employees;

-- Для каждой row Oracle:
--   берет first_name;
--   добавляет symbols до length 15;
--   возвращает result для этой row.
--
-- Это single-row behavior.


-- ============================================================
-- Total length means final length
-- ============================================================
-- Второй argument - это итоговая length result,
-- а не количество symbols, которые нужно добавить.
--
-- Пример:
SELECT LPAD('SQL', 5, '*') AS padded_text
FROM dual;

-- Result:
--   **SQL
--
-- Почему не *****SQL?
--   Потому что 5 означает final length,
--   а не "добавить 5 stars".
--
-- 'SQL' имеет length 3.
-- Нужно добавить только 2 stars,
-- чтобы итоговая length стала 5.


-- ============================================================
-- Pad string can have many characters
-- ============================================================
-- pad_string может быть длиннее одного character.
--
-- Пример:
SELECT LPAD('SQL', 10, 'ab') AS left_padded,
       RPAD('SQL', 10, 'ab') AS right_padded
FROM dual;

-- Possible result:
--   left_padded  = abababaSQL
--   right_padded = SQLabababa
--
-- Oracle повторяет pad_string столько раз,
-- сколько нужно,
-- а потом обрезает лишнее,
-- чтобы final length была ровно 10.


-- ============================================================
-- When total length is shorter than text
-- ============================================================
-- Если total_length меньше исходного text,
-- Oracle может обрезать result до total_length.
--
-- Пример:
SELECT LPAD('Oracle', 3, '*') AS left_padded,
       RPAD('Oracle', 3, '*') AS right_padded
FROM dual;

-- Result:
--   Ora
--   Ora
--
-- Почему:
--   исходный text длинее, чем total_length.
--   Result должен иметь length 3.
--
-- Важно:
--   LPAD/RPAD не всегда только добавляют characters.
--   Они возвращают text с указанной final length.


-- ============================================================
-- LPAD / RPAD and LENGTH
-- ============================================================
-- LENGTH помогает проверить итоговую length.
--
-- Пример:
SELECT LPAD('Oracle', 10, '*') AS padded_text,
       LENGTH(LPAD('Oracle', 10, '*')) AS padded_length
FROM dual;

-- Result:
--   padded_text   = ****Oracle
--   padded_length = 10
--
-- Еще пример:
SELECT RPAD('Oracle', 10, '*') AS padded_text,
       LENGTH(RPAD('Oracle', 10, '*')) AS padded_length
FROM dual;

-- Result:
--   padded_text   = Oracle****
--   padded_length = 10


-- ============================================================
-- LPAD / RPAD with numbers
-- ============================================================
-- LPAD/RPAD предназначены для character values.
--
-- Но Oracle может сделать implicit conversion,
-- если передать number.
--
-- Пример:
SELECT LPAD(25, 5, '0') AS number_text
FROM dual;

-- Possible result:
--   00025
--
-- Oracle может преобразовать number 25 в text '25',
-- потом добавить zeros слева.
--
-- Важно:
--   Это implicit conversion.
--   В реальном коде лучше понимать,
--   какой text format получится из number.


-- ============================================================
-- LPAD / RPAD and NULL
-- ============================================================
-- Если char_value = NULL,
-- result обычно будет NULL.
--
-- Пример:
SELECT LPAD(NULL, 10, '*') AS lpad_null,
       RPAD(NULL, 10, '*') AS rpad_null
FROM dual;

-- Result:
--   NULL
--   NULL
--
-- Если pad_string = NULL,
-- result тоже может быть NULL.
--
-- Пример:
SELECT LPAD('Oracle', 10, NULL) AS lpad_null_pad
FROM dual;

-- Важно:
--   NULL означает absence of value.
--   Для predictable padding лучше указывать real pad_string.


-- ============================================================
-- LPAD / RPAD in SELECT list
-- ============================================================
-- LPAD/RPAD часто используют в SELECT list,
-- чтобы красиво отформатировать output.
--
-- Пример:
SELECT employee_id,
       LPAD(employee_id, 6, '0') AS employee_code,
       first_name,
       RPAD(first_name, 15, '.') AS first_name_output
FROM employees;

-- employee_code:
--   id with leading zeros.
--
-- first_name_output:
--   name padded on the right with dots.
--
-- Table data не меняется.


-- ============================================================
-- LPAD / RPAD in WHERE
-- ============================================================
-- LPAD/RPAD можно использовать в WHERE,
-- если нужно сравнить formatted text.
--
-- Пример:
SELECT employee_id,
       first_name
FROM employees
WHERE LPAD(employee_id, 6, '0') = '000101';

-- Meaning:
--   Oracle форматирует employee_id как text длиной 6;
--   потом сравнивает result с '000101'.
--
-- Это учебный пример.
-- В реальном коде часто проще сравнить original value:
--   employee_id = 101


-- ============================================================
-- Readable formatting
-- ============================================================
-- Однострочный query:
SELECT LPAD('Oracle', 10, '*') FROM dual;

-- Работает, но лучше давать alias:
SELECT LPAD('Oracle', 10, '*') AS padded_text
FROM dual;

-- Для нескольких expressions:
SELECT first_name,
       LPAD(first_name, 15, '*') AS first_name_lpad,
       RPAD(first_name, 15, '*') AS first_name_rpad
FROM employees;

-- Хорошая привычка:
--   давать padded expression понятный alias;
--   явно указывать pad_string;
--   помнить, что second argument - final length.


-- ============================================================
-- Simple examples
-- ============================================================
-- LPAD literal:
SELECT LPAD('Oracle', 10, '*') AS padded_text
FROM dual;

-- RPAD literal:
SELECT RPAD('Oracle', 10, '*') AS padded_text
FROM dual;

-- LPAD with zeros:
SELECT LPAD('25', 5, '0') AS code_value
FROM dual;

-- LPAD/RPAD with column:
SELECT first_name,
       LPAD(first_name, 15, '*') AS first_name_lpad,
       RPAD(first_name, 15, '*') AS first_name_rpad
FROM employees;

-- Pad string with more than one character:
SELECT LPAD('SQL', 10, 'ab') AS left_padded,
       RPAD('SQL', 10, 'ab') AS right_padded
FROM dual;

-- Short final length:
SELECT LPAD('Oracle', 3, '*') AS left_padded,
       RPAD('Oracle', 3, '*') AS right_padded
FROM dual;

-- Check length:
SELECT LPAD('Oracle', 10, '*') AS padded_text,
       LENGTH(LPAD('Oracle', 10, '*')) AS padded_length
FROM dual;


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что second argument означает сколько symbols добавить.
--
--    Неправильная идея:
--      LPAD('SQL', 5, '*') adds 5 stars.
--
--    Правильно:
--      Result final length = 5.
--
-- 2. Забывать, что LPAD добавляет слева,
--    а RPAD добавляет справа.
--
-- 3. Не указывать pad_string
--    и потом не видеть spaces в output.
--
-- 4. Думать, что LPAD/RPAD всегда только добавляют.
--    Если total_length меньше text length,
--    result может быть truncated.
--
-- 5. Передавать numbers без понимания implicit conversion.
--
-- 6. Думать, что LPAD/RPAD меняют table data.
--    Они только возвращают formatted output.


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Выведи LPAD('Oracle', 10, '*')
--   из dual.
--
-- Task 2:
--   Выведи RPAD('Oracle', 10, '*')
--   из dual.
--
-- Task 3:
--   Выведи LPAD('25', 5, '0')
--   из dual.
--
-- Task 4:
--   Выведи first_name,
--   LPAD(first_name, 15, '*')
--   и RPAD(first_name, 15, '*')
--   из employees.
--
-- Task 5:
--   Проверь:
--     LPAD('SQL', 10, 'ab')
--     RPAD('SQL', 10, 'ab')
--
--   Объясни result.
--
-- Task 6:
--   Проверь:
--     LPAD('Oracle', 3, '*')
--     RPAD('Oracle', 3, '*')
--
--   Объясни, почему result короткий.
--
-- Task 7:
--   Выведи LPAD('Oracle', 10, '*')
--   и рядом LENGTH этого expression.
--
-- Task 8:
--   Объясни своими словами:
--     что делает LPAD;
--     что делает RPAD;
--     что означает total_length;
--     почему pad_string лучше указывать явно.


-- ============================================================
-- Summary
-- ============================================================
-- LPAD:
--   adds padding on the left.
--
-- RPAD:
--   adds padding on the right.
--
-- Syntax:
--   LPAD(char_value, total_length, pad_string)
--   RPAD(char_value, total_length, pad_string)
--
-- Главное:
--   total_length - это итоговая length result,
--   а не количество добавляемых symbols.
