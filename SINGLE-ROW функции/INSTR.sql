-- Character functions
-- String search functions
-- INSTR(s, search string, start position, N-th occurrence)

SELECT *
FROM employees
WHERE INSTR(job_id, 'PROG') = 4;

SELECT INSTR('Raul Alishov', 'u') 
FROM dual;

SELECT INSTR('Raul Alishov', 'w') 
FROM dual;

SELECT *
FROM employees
WHERE INSTR(hire_date, 'SEP') = 4;

SELECT *
FROM employees
WHERE INSTR(salary, '2') = 2;

SELECT *
FROM employees
WHERE INSTR(job_id, 'PROG') = 4;

SELECT INSTR('Raul Alishov', 'u', 2) 
FROM dual;

SELECT INSTR('Raul alishov', 'a', 2, 2) 
FROM dual;


-- ============================================================
-- Character functions
-- String function: INSTR
-- ============================================================
-- INSTR         - single-row character function.
--
-- Простыми словами:
--   INSTR ищет один text внутри другого text
--   и возвращает position, где найден search string.
--
-- Название можно читать так:
--   IN STRing
--   то есть "inside string".
--
-- INSTR не меняет text.
-- INSTR только показывает number:
--   где начинается найденная часть text.
--
-- Result type:
--   NUMBER
--
-- В этом уроке только INSTR.
-- Другие string functions будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- INSTR отвечает на вопрос:
--   "На какой позиции находится нужный text?"
--
-- Пример:
SELECT INSTR('Raul Alishov', 'u') AS position_number
FROM dual;

-- Result:
--   3
--
-- Почему:
--   R = 1
--   a = 2
--   u = 3
--   l = 4
--
-- Oracle считает positions с 1.
-- Не с 0.


-- ============================================================
-- Syntax
-- ============================================================
-- Полный синтаксис:
--
--   INSTR(source_text, search_string, start_position, occurrence)
--
-- Где:
--   source_text      - text, внутри которого ищем;
--   search_string    - text, который ищем;
--   start_position   - с какой position начать поиск;
--   occurrence       - какое по счету совпадение найти.
--
-- start_position и occurrence можно не писать.
--
-- Короткий синтаксис:
--   INSTR(source_text, search_string)
--
-- В этом случае Oracle использует defaults:
--   start_position = 1
--   occurrence     = 1


-- ============================================================
-- Positions start with 1
-- ============================================================
-- В Oracle первая буква text имеет position 1.
--
-- Пример:
SELECT INSTR('Oracle', 'O') AS position_number
FROM dual;

-- Result:
--   1
--
-- Пример:
SELECT INSTR('Oracle', 'r') AS position_number
FROM dual;

-- Result:
--   2
--
-- Пример:
SELECT INSTR('Oracle', 'a') AS position_number
FROM dual;

-- Result:
--   3


-- ============================================================
-- If search string is not found
-- ============================================================
-- Если search_string не найден,
-- INSTR возвращает 0.
--
-- Пример:
SELECT INSTR('Raul Alishov', 'w') AS position_number
FROM dual;

-- Result:
--   0
--
-- Важно:
--   0 не означает first position.
--   0 означает "not found".


-- ============================================================
-- Search string can be more than one character
-- ============================================================
-- search_string может быть одним character:
SELECT INSTR('Oracle SQL', 'S') AS position_number
FROM dual;

-- Result:
--   8
--
-- search_string может быть несколькими characters:
SELECT INSTR('Oracle SQL', 'SQL') AS position_number
FROM dual;

-- Result:
--   8
--
-- INSTR возвращает position первого character
-- найденного search_string.
--
-- В примере 'SQL' начинается с position 8.


-- ============================================================
-- INSTR with columns
-- ============================================================
-- INSTR можно использовать с columns.
--
-- Пример:
SELECT employee_id,
       job_id,
       INSTR(job_id, 'PROG') AS prog_position
FROM employees;

-- Meaning:
--   показать employee_id;
--   показать job_id;
--   показать position, где внутри job_id начинается 'PROG'.
--
-- Если 'PROG' не найден,
-- result будет 0.


-- ============================================================
-- INSTR in WHERE
-- ============================================================
-- INSTR часто используют в WHERE,
-- когда нужно найти rows, где text содержит нужную часть.
--
-- Пример из начала файла:
SELECT *
FROM employees
WHERE INSTR(job_id, 'PROG') = 4;

-- Meaning:
--   найти employees,
--   у которых внутри job_id text 'PROG'
--   начинается именно на position 4.
--
-- Например:
--   IT_PROG
--
-- Positions:
--   I = 1
--   T = 2
--   _ = 3
--   P = 4
--
-- Поэтому INSTR(job_id, 'PROG') возвращает 4.


-- ============================================================
-- INSTR greater than 0
-- ============================================================
-- Если нужно просто проверить,
-- что search_string где-то есть,
-- часто используют condition:
--   INSTR(column_name, 'text') > 0
--
-- Пример:
SELECT employee_id,
       first_name,
       job_id
FROM employees
WHERE INSTR(job_id, 'PROG') > 0;

-- Meaning:
--   вернуть rows,
--   где 'PROG' найден в job_id.
--
-- Почему > 0:
--   если найдено, INSTR возвращает position 1, 2, 3...
--   если не найдено, INSTR возвращает 0.


-- ============================================================
-- start_position
-- ============================================================
-- Третий argument показывает,
-- с какой position начать поиск.
--
-- Syntax:
--   INSTR(source_text, search_string, start_position)
--
-- Пример:
SELECT INSTR('Raul Alishov', 'u', 2) AS position_number
FROM dual;

-- Result:
--   3
--
-- Почему:
--   поиск начинается с position 2;
--   character 'u' находится на position 3.
--
-- Пример:
SELECT INSTR('Raul Alishov', 'R', 2) AS position_number
FROM dual;

-- Result:
--   0
--
-- Почему:
--   R находится на position 1;
--   но поиск начинается с position 2;
--   значит R уже пропущен.


-- ============================================================
-- occurrence
-- ============================================================
-- Четвертый argument показывает,
-- какое по счету совпадение нужно найти.
--
-- Syntax:
--   INSTR(source_text, search_string, start_position, occurrence)
--
-- Пример:
SELECT INSTR('Raul alishov', 'a', 2, 2) AS position_number
FROM dual;

-- Result:
--   6
--
-- Почему:
--   source_text = 'Raul alishov'
--   search_string = 'a'
--   start_position = 2
--   occurrence = 2
--
-- Positions:
--   a на position 2  = first occurrence;
--   a на position 6  = second occurrence.
--
-- Поэтому result = 6.


-- ============================================================
-- First occurrence by default
-- ============================================================
-- Если occurrence не указан,
-- Oracle ищет first occurrence.
--
-- Пример:
SELECT INSTR('banana', 'a') AS position_number
FROM dual;

-- Result:
--   2
--
-- Потому что первая буква 'a'
-- находится на position 2.
--
-- Пример с occurrence:
SELECT INSTR('banana', 'a', 1, 2) AS position_number
FROM dual;

-- Result:
--   4
--
-- Здесь Oracle ищет second occurrence.


-- ============================================================
-- occurrence must be positive
-- ============================================================
-- occurrence показывает номер совпадения.
-- Он должен быть positive number.
--
-- Correct:
SELECT INSTR('banana', 'a', 1, 3) AS position_number
FROM dual;

-- Result:
--   6
--
-- Не нужно писать occurrence = 0.
-- Нулевого совпадения не существует.


-- ============================================================
-- Negative start_position
-- ============================================================
-- start_position может быть negative.
--
-- Если start_position negative,
-- Oracle начинает поиск с конца text
-- и ищет назад.
--
-- Пример:
SELECT INSTR('banana', 'a', -1) AS position_number
FROM dual;

-- Result:
--   6
--
-- Почему:
--   поиск начинается справа;
--   ближайшая 'a' справа находится на position 6.
--
-- Пример:
SELECT INSTR('banana', 'a', -1, 2) AS position_number
FROM dual;

-- Result:
--   4
--
-- Почему:
--   ищем second occurrence справа налево;
--   первая справа 'a' = position 6;
--   вторая справа 'a' = position 4.


-- ============================================================
-- Case sensitivity
-- ============================================================
-- INSTR is case-sensitive.
--
-- Это значит:
--   'a' и 'A' считаются разными characters.
--
-- Пример:
SELECT INSTR('Raul Alishov', 'a') AS position_number
FROM dual;

-- Result:
--   2
--
-- Пример:
SELECT INSTR('Raul Alishov', 'A') AS position_number
FROM dual;

-- Result:
--   6
--
-- Почему:
--   lowercase 'a' находится в Raul;
--   uppercase 'A' находится в Alishov.


-- ============================================================
-- INSTR with spaces
-- ============================================================
-- Space тоже является character.
--
-- Пример:
SELECT INSTR('Raul Alishov', ' ') AS position_number
FROM dual;

-- Result:
--   5
--
-- Почему:
--   space между Raul и Alishov находится на position 5.


-- ============================================================
-- INSTR with special characters
-- ============================================================
-- INSTR можно использовать для поиска special characters.
--
-- Пример:
SELECT INSTR('IT_PROG', '_') AS position_number
FROM dual;

-- Result:
--   3
--
-- Пример:
SELECT INSTR('01.02.2026', '.') AS position_number
FROM dual;

-- Result:
--   3
--
-- Почему:
--   первая точка находится на position 3.


-- ============================================================
-- INSTR with dates and numbers
-- ============================================================
-- INSTR является character function.
--
-- Если передать date или number,
-- Oracle может сделать implicit conversion в text.
--
-- Пример из начала файла:
SELECT *
FROM employees
WHERE INSTR(hire_date, 'SEP') = 4;

-- Meaning:
--   hire_date будет рассматриваться как text
--   в формате текущей session.
--
-- Важно:
--   результат зависит от date format session.
--   В другой session month может отображаться иначе.
--
-- Поэтому для учебного понимания пример полезен,
-- но в реальном коде лучше контролировать format явно.
-- Форматы дат будут отдельной темой.
--
-- Пример с number:
SELECT *
FROM employees
WHERE INSTR(salary, '2') = 2;

-- Meaning:
--   salary рассматривается как text;
--   Oracle ищет character '2'.
--
-- Для ясности лучше помнить:
--   INSTR ищет text inside text.


-- ============================================================
-- INSTR returns position, not true or false
-- ============================================================
-- INSTR не возвращает TRUE или FALSE.
--
-- Он возвращает NUMBER:
--   0       - not found;
--   1,2,3   - position where found.
--
-- Пример:
SELECT INSTR('Oracle', 'x') AS position_number
FROM dual;

-- Result:
--   0
--
-- Пример:
SELECT INSTR('Oracle', 'c') AS position_number
FROM dual;

-- Result:
--   4


-- ============================================================
-- INSTR with alias
-- ============================================================
-- Для INSTR expression лучше давать alias.
--
-- Пример:
SELECT first_name,
       INSTR(first_name, 'a') AS a_position
FROM employees;

-- Alias:
--   a_position
--
-- Без alias output column может называться длинно:
--   INSTR(FIRST_NAME,'A')
--
-- С alias result set читать легче.


-- ============================================================
-- Multiple examples in SELECT list
-- ============================================================
-- Можно показать несколько INSTR expressions рядом.
--
-- Пример:
SELECT first_name,
       INSTR(first_name, 'a') AS lowercase_a,
       INSTR(first_name, 'A') AS uppercase_a
FROM employees;

-- Meaning:
--   lowercase_a показывает position буквы 'a';
--   uppercase_a показывает position буквы 'A'.
--
-- Это также показывает case sensitivity.


-- ============================================================
-- Search exact sequence
-- ============================================================
-- Если search_string состоит из нескольких characters,
-- Oracle ищет exact sequence.
--
-- Пример:
SELECT INSTR('Oracle Database', 'Data') AS position_number
FROM dual;

-- Result:
--   8
--
-- Пример:
SELECT INSTR('Oracle Database', 'Base') AS position_number
FROM dual;

-- Result:
--   0
--
-- Почему:
--   В text есть 'base' как часть слова Database,
--   но нет exact sequence 'Base' с uppercase B.


-- ============================================================
-- Search starts from start_position
-- ============================================================
-- start_position не меняет numbering.
--
-- Он только говорит,
-- откуда начать search.
--
-- Пример:
SELECT INSTR('abcabcabc', 'a', 4) AS position_number
FROM dual;

-- Result:
--   4
--
-- Пример:
SELECT INSTR('abcabcabc', 'a', 5) AS position_number
FROM dual;

-- Result:
--   7
--
-- Почему:
--   если start_position = 5,
--   'a' на position 4 уже пропущена.


-- ============================================================
-- occurrence counts matches after start_position
-- ============================================================
-- occurrence считается от точки старта поиска.
--
-- Пример:
SELECT INSTR('abcabcabc', 'abc', 1, 2) AS position_number
FROM dual;

-- Result:
--   4
--
-- Пример:
SELECT INSTR('abcabcabc', 'abc', 4, 2) AS position_number
FROM dual;

-- Result:
--   7
--
-- Почему:
--   при start_position = 4 первое найденное 'abc' начинается на 4;
--   второе найденное 'abc' начинается на 7.


-- ============================================================
-- When occurrence does not exist
-- ============================================================
-- Если нужного occurrence нет,
-- INSTR возвращает 0.
--
-- Пример:
SELECT INSTR('banana', 'a', 1, 4) AS position_number
FROM dual;

-- Result:
--   0
--
-- Почему:
--   в слове banana только три lowercase 'a'.
--   Fourth occurrence не существует.


-- ============================================================
-- INSTR and NULL
-- ============================================================
-- Если source_text is NULL,
-- result будет NULL.
--
-- Пример:
SELECT INSTR(NULL, 'a') AS position_number
FROM dual;

-- Result:
--   NULL
--
-- Если search_string is NULL,
-- result тоже будет NULL.
--
-- Пример:
SELECT INSTR('Oracle', NULL) AS position_number
FROM dual;

-- Result:
--   NULL
--
-- В Oracle empty string обычно считается NULL.


-- ============================================================
-- Common use case: find part of job_id
-- ============================================================
-- В HR schema job_id часто содержит category.
--
-- Пример:
SELECT employee_id,
       first_name,
       job_id
FROM employees
WHERE INSTR(job_id, 'MAN') > 0;

-- Meaning:
--   показать employees,
--   у которых в job_id есть 'MAN'.
--
-- Примеры job_id:
--   ST_MAN
--   SA_MAN


-- ============================================================
-- Common use case: check text pattern
-- ============================================================
-- INSTR можно использовать,
-- чтобы проверить наличие character в text.
--
-- Пример:
SELECT employee_id,
       phone_number,
       INSTR(phone_number, '.') AS dot_position
FROM employees;

-- Meaning:
--   найти position первой точки в phone_number.
--
-- Если dot_position = 0,
-- значит точки в phone_number нет.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что positions начинаются с 0.
--    В Oracle positions начинаются с 1.
--
-- 2. Думать, что result 0 означает first position.
--    Нет, result 0 означает not found.
--
-- 3. Забывать про case sensitivity.
--    'a' и 'A' могут дать разные positions.
--
-- 4. Путать start_position и occurrence.
--    start_position = откуда начать поиск.
--    occurrence = какое совпадение найти.
--
-- 5. Использовать INSTR с dates без понимания session format.
--    INSTR работает с text, поэтому date будет converted to text.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Найди position буквы 'S':
SELECT INSTR('SQL Developer', 'S') AS result
FROM dual;

-- 2. Найди position text 'Dev':
SELECT INSTR('SQL Developer', 'Dev') AS result
FROM dual;

-- 3. Проверь, что result будет 0:
SELECT INSTR('SQL Developer', 'Java') AS result
FROM dual;

-- 4. Найди second occurrence буквы 'a':
SELECT INSTR('database', 'a', 1, 2) AS result
FROM dual;

-- 5. Начни поиск с position 5:
SELECT INSTR('database', 'a', 5) AS result
FROM dual;

-- 6. Найди character справа налево:
SELECT INSTR('database', 'a', -1) AS result
FROM dual;


-- ============================================================
-- Mini summary
-- ============================================================
-- INSTR searches text inside text.
--
-- It returns:
--   position number if found;
--   0 if not found;
--   NULL if one of important inputs is NULL.
--
-- Default behavior:
--   INSTR(source_text, search_string)
--   starts from position 1
--   and searches first occurrence.
--
-- Important:
--   positions start with 1;
--   INSTR is case-sensitive;
--   search_string can contain one or many characters;
--   start_position controls where search begins;
--   occurrence controls which match to return.



