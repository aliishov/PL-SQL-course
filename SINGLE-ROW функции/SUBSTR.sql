-- Character functions
-- String manipulation functions
-- SUBSTR(s, start position, number of characters)

SELECT email,
       SUBSTR(email, 4)
FROM employees;

SELECT email,
       SUBSTR(email, 4, 2)
FROM employees;

SELECT email,
       SUBSTR(email, 15)
FROM employees;

SELECT SUBSTR('Privet, kak dela?', 7)
FROM dual;

SELECT SUBSTR('Privet, kak dela?', 7, 5)
FROM dual;

SELECT SUBSTR('Privet, kak dela?', 7, 250)
FROM dual;

SELECT SUBSTR('Privet, kak dela?', 250, 250)
FROM dual;

SELECT salary,
       SUBSTR(salary, 2, 3)
FROM employees;

SELECT hire_date,
       SUBSTR(hire_date, 2, 3)
FROM employees;

SELECT SUBSTR('Privet, kak dela?', -6)
FROM dual;

SELECT SUBSTR('Privet, kak dela?', -6, 3)
FROM dual;


-- ============================================================
-- Character functions
-- String function: SUBSTR
-- ============================================================
-- SUBSTR        - single-row character function.
--
-- Простыми словами:
--   SUBSTR берет часть text из другого text.
--
-- SUBSTR не меняет исходный text.
-- Он только возвращает новую часть text в result set.
--
-- Название можно читать так:
--   SUB STRing
--   то есть "substring" или "part of string".
--
-- Result:
--   character value
--
-- В этом уроке только SUBSTR.
-- Другие string functions будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- SUBSTR отвечает на вопрос:
--   "Возьми часть строки, начиная с такой-то position."
--
-- Пример:
SELECT SUBSTR('Privet, kak dela?', 7) AS text_part
FROM dual;

-- Result:
--   , kak dela?
--
-- Почему:
--   SUBSTR начинает с position 7
--   и берет все characters до конца text,
--   потому что number_of_characters не указан.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   SUBSTR(source_text, start_position, number_of_characters)
--
-- Где:
--   source_text             - исходный text;
--   start_position          - с какой position начать;
--   number_of_characters    - сколько characters взять.
--
-- Третий argument можно не писать:
--
--   SUBSTR(source_text, start_position)
--
-- Если number_of_characters не указан,
-- Oracle берет text от start_position до конца.


-- ============================================================
-- Positions start with 1
-- ============================================================
-- В Oracle первая position в text = 1.
--
-- Пример:
SELECT SUBSTR('Oracle', 1, 1) AS text_part
FROM dual;

-- Result:
--   O
--
-- Почему:
--   O = position 1
--
-- Пример:
SELECT SUBSTR('Oracle', 2, 1) AS text_part
FROM dual;

-- Result:
--   r
--
-- Почему:
--   r = position 2
--
-- Пример:
SELECT SUBSTR('Oracle', 3, 1) AS text_part
FROM dual;

-- Result:
--   a


-- ============================================================
-- SUBSTR without number_of_characters
-- ============================================================
-- Если указать только source_text и start_position,
-- SUBSTR вернет часть text до конца.
--
-- Пример:
SELECT SUBSTR('Oracle SQL', 8) AS text_part
FROM dual;

-- Result:
--   SQL
--
-- Почему:
--   position 8 = S;
--   number_of_characters не указан;
--   значит Oracle берет S и все после него.
--
-- Пример из начала файла:
SELECT email,
       SUBSTR(email, 4) AS email_part
FROM employees;

-- Meaning:
--   для каждого email взять text,
--   начиная с position 4 и до конца.


-- ============================================================
-- SUBSTR with number_of_characters
-- ============================================================
-- Третий argument ограничивает,
-- сколько characters нужно взять.
--
-- Пример:
SELECT SUBSTR('Oracle SQL', 8, 3) AS text_part
FROM dual;

-- Result:
--   SQL
--
-- Почему:
--   start_position = 8;
--   number_of_characters = 3;
--   Oracle берет 3 characters: S, Q, L.
--
-- Пример из начала файла:
SELECT email,
       SUBSTR(email, 4, 2) AS email_part
FROM employees;

-- Meaning:
--   взять из email только 2 characters,
--   начиная с position 4.


-- ============================================================
-- start_position tells where to begin
-- ============================================================
-- start_position не означает length.
--
-- start_position означает:
--   "с какого места начать брать text".
--
-- Пример:
SELECT SUBSTR('Database', 5, 4) AS text_part
FROM dual;

-- Result:
--   base
--
-- Positions:
--   D = 1
--   a = 2
--   t = 3
--   a = 4
--   b = 5
--   a = 6
--   s = 7
--   e = 8
--
-- С position 5 берем 4 characters:
--   b, a, s, e


-- ============================================================
-- number_of_characters tells how many to take
-- ============================================================
-- number_of_characters означает:
--   "сколько characters вернуть".
--
-- Пример:
SELECT SUBSTR('Database', 1, 4) AS text_part
FROM dual;

-- Result:
--   Data
--
-- Пример:
SELECT SUBSTR('Database', 1, 6) AS text_part
FROM dual;

-- Result:
--   Databa
--
-- Difference:
--   start_position одинаковый;
--   number_of_characters разный;
--   поэтому result имеет разную длину.


-- ============================================================
-- If length is bigger than remaining text
-- ============================================================
-- Если number_of_characters больше,
-- чем осталось characters до конца text,
-- Oracle просто вернет то, что осталось.
--
-- Пример из начала файла:
SELECT SUBSTR('Privet, kak dela?', 7, 250) AS text_part
FROM dual;

-- Result:
--   , kak dela?
--
-- Почему:
--   с position 7 до конца меньше чем 250 characters;
--   Oracle не дает error;
--   он возвращает доступную часть text.


-- ============================================================
-- If start_position is after the end
-- ============================================================
-- Если start_position находится дальше конца text,
-- SUBSTR не может ничего взять.
--
-- Пример из начала файла:
SELECT SUBSTR('Privet, kak dela?', 250, 250) AS text_part
FROM dual;

-- Result:
--   NULL
--
-- Почему:
--   position 250 не существует в этом text.
--
-- В Oracle empty string обычно считается NULL,
-- поэтому result отображается как NULL.


-- ============================================================
-- start_position = 0
-- ============================================================
-- В Oracle start_position = 0
-- обрабатывается как start_position = 1.
--
-- Пример:
SELECT SUBSTR('Oracle', 0, 3) AS text_part
FROM dual;

-- Result:
--   Ora
--
-- Это похоже на:
SELECT SUBSTR('Oracle', 1, 3) AS text_part
FROM dual;

-- Но для понятности лучше писать position 1,
-- если нужно начать с первого character.


-- ============================================================
-- Negative start_position
-- ============================================================
-- start_position может быть negative.
--
-- Negative position означает:
--   считать позицию с конца text.
--
-- Пример из начала файла:
SELECT SUBSTR('Privet, kak dela?', -6) AS text_part
FROM dual;

-- Result:
--    dela?
--
-- Почему:
--   -6 начинает отсчет с конца строки;
--   Oracle находит space перед словом dela;
--   дальше берет text до конца,
--   потому что number_of_characters не указан.
--
-- Пример:
SELECT SUBSTR('Privet, kak dela?', -6, 3) AS text_part
FROM dual;

-- Result:
--    de
--
-- Почему:
--   start_position найден с конца;
--   number_of_characters = 3;
--   Oracle возвращает 3 characters.
--
-- Если нужно начать именно с буквы d:
SELECT SUBSTR('Privet, kak dela?', -5) AS text_part
FROM dual;

-- Result:
--   dela?


-- ============================================================
-- Negative position still returns forward
-- ============================================================
-- Важно:
--   negative start_position определяет,
--   откуда начать.
--
-- Но result возвращается слева направо,
-- обычным порядком characters.
--
-- Пример:
SELECT SUBSTR('abcdef', -3, 2) AS text_part
FROM dual;

-- Result:
--   de
--
-- Почему:
--   -3 указывает на character d;
--   дальше SUBSTR берет 2 characters вперед:
--   d, e.


-- ============================================================
-- SUBSTR with spaces
-- ============================================================
-- Space тоже считается character.
--
-- Пример:
SELECT SUBSTR('Raul Aliishov', 5, 1) AS text_part
FROM dual;

-- Result:
--   space
--
-- Почему:
--   position 5 находится между Raul и Aliishov.
--
-- Пример:
SELECT SUBSTR('Raul Aliishov', 6) AS text_part
FROM dual;

-- Result:
--   Aliishov


-- ============================================================
-- SUBSTR with punctuation
-- ============================================================
-- Punctuation marks тоже являются characters.
--
-- Пример:
SELECT SUBSTR('Privet, kak dela?', 7, 5) AS text_part
FROM dual;

-- Result:
--   , kak
--
-- Почему:
--   comma и space тоже входят в result.
--
-- Пример:
SELECT SUBSTR('A.B.C', 2, 3) AS text_part
FROM dual;

-- Result:
--   .B.


-- ============================================================
-- SUBSTR in SELECT list
-- ============================================================
-- SUBSTR можно использовать в SELECT list.
--
-- Пример:
SELECT employee_id,
       email,
       SUBSTR(email, 1, 3) AS email_prefix
FROM employees;

-- Meaning:
--   показать employee_id;
--   показать original email;
--   показать первые 3 characters из email.
--
-- SELECT не меняет данные в table.
-- Он только показывает result.


-- ============================================================
-- SUBSTR with alias
-- ============================================================
-- Для expression удобно давать alias.
--
-- Пример:
SELECT SUBSTR('Oracle Database', 8, 4) AS text_part
FROM dual;

-- Alias:
--   text_part
--
-- Без alias output column может называться длинно:
--   SUBSTR('ORACLEDATABASE',8,4)
--
-- С alias result set читать легче.


-- ============================================================
-- SUBSTR with employee email
-- ============================================================
-- В HR schema можно брать part of email.
--
-- Пример:
SELECT email,
       SUBSTR(email, 1, 2) AS first_two_chars
FROM employees;

-- Meaning:
--   из каждого email взять первые 2 characters.
--
-- Пример:
SELECT email,
       SUBSTR(email, 3, 4) AS email_part
FROM employees;

-- Meaning:
--   из каждого email начать с position 3;
--   взять 4 characters.


-- ============================================================
-- SUBSTR in WHERE
-- ============================================================
-- SUBSTR можно использовать в WHERE condition.
--
-- Пример:
SELECT employee_id,
       first_name,
       email
FROM employees
WHERE SUBSTR(email, 1, 1) = 'A';

-- Meaning:
--   взять первый character из email;
--   сравнить его со string literal 'A';
--   вернуть rows, где первый character = 'A'.
--
-- Важно:
--   SUBSTR возвращает text.
--   Поэтому сравнение идет с text value.


-- ============================================================
-- Case sensitivity in comparisons
-- ============================================================
-- Если использовать SUBSTR в comparison,
-- uppercase и lowercase имеют значение.
--
-- Пример:
SELECT employee_id,
       first_name,
       email
FROM employees
WHERE SUBSTR(email, 1, 1) = 'a';

-- Это не то же самое, что:
SELECT employee_id,
       first_name,
       email
FROM employees
WHERE SUBSTR(email, 1, 1) = 'A';

-- Почему:
--   'a' and 'A' are different characters.


-- ============================================================
-- SUBSTR with numbers
-- ============================================================
-- SUBSTR является character function.
--
-- Если передать number,
-- Oracle может сделать implicit conversion в text.
--
-- Пример из начала файла:
SELECT salary,
       SUBSTR(salary, 2, 3) AS salary_part
FROM employees;

-- Meaning:
--   salary рассматривается как text;
--   Oracle берет 3 characters,
--   начиная с position 2.
--
-- Например:
--   salary = 24000
--   SUBSTR(salary, 2, 3) = 400
--
-- Для учебного примера это полезно,
-- но важно помнить:
--   SUBSTR работает с characters,
--   а не с математическим значением числа.


-- ============================================================
-- SUBSTR with dates
-- ============================================================
-- Если передать date,
-- Oracle может сделать implicit conversion в text.
--
-- Пример из начала файла:
SELECT hire_date,
       SUBSTR(hire_date, 2, 3) AS date_part
FROM employees;

-- Meaning:
--   hire_date будет converted to text;
--   потом SUBSTR возьмет часть этого text.
--
-- Важно:
--   result зависит от date format текущей session.
--
-- Если session показывает date как:
--   17-JUN-03
--
-- Тогда SUBSTR(hire_date, 2, 3) может вернуть:
--   7-J
--
-- В другой date format result может быть другим.
-- Форматы дат будут отдельной темой.


-- ============================================================
-- SUBSTR returns NULL with NULL source
-- ============================================================
-- Если source_text is NULL,
-- result тоже будет NULL.
--
-- Пример:
SELECT SUBSTR(NULL, 1, 3) AS text_part
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- number_of_characters less than 1
-- ============================================================
-- Если number_of_characters меньше 1,
-- Oracle возвращает NULL.
--
-- Пример:
SELECT SUBSTR('Oracle', 1, 0) AS text_part
FROM dual;

-- Result:
--   NULL
--
-- Пример:
SELECT SUBSTR('Oracle', 1, -2) AS text_part
FROM dual;

-- Result:
--   NULL
--
-- Почему:
--   нельзя взять 0 characters
--   или negative number of characters.


-- ============================================================
-- Different start positions
-- ============================================================
SELECT SUBSTR('Programming', 1, 4) AS result
FROM dual;

-- Result:
--   Prog

SELECT SUBSTR('Programming', 5, 4) AS result
FROM dual;

-- Result:
--   ramm

SELECT SUBSTR('Programming', 9) AS result
FROM dual;

-- Result:
--   ing

-- Эти examples показывают,
-- как start_position меняет начало result.


-- ============================================================
-- Different lengths
-- ============================================================
SELECT SUBSTR('Programming', 1, 1) AS result
FROM dual;

-- Result:
--   P

SELECT SUBSTR('Programming', 1, 3) AS result
FROM dual;

-- Result:
--   Pro

SELECT SUBSTR('Programming', 1, 7) AS result
FROM dual;

-- Result:
--   Program

-- Эти examples показывают,
-- как number_of_characters меняет result.


-- ============================================================
-- Common use case: first characters
-- ============================================================
-- Частая задача:
--   взять первые несколько characters.
--
-- Пример:
SELECT first_name,
       SUBSTR(first_name, 1, 3) AS short_name
FROM employees;

-- Meaning:
--   взять первые 3 characters из first_name.
--
-- Если first_name короче 3 characters,
-- Oracle просто вернет весь доступный text.


-- ============================================================
-- Common use case: last characters
-- ============================================================
-- Чтобы взять characters с конца,
-- можно использовать negative start_position.
--
-- Пример:
SELECT phone_number,
       SUBSTR(phone_number, -4) AS last_four_chars
FROM employees;

-- Meaning:
--   взять последние 4 characters из phone_number.
--
-- Пример:
SELECT SUBSTR('AZ-2026-0001', -4) AS code_end
FROM dual;

-- Result:
--   0001


-- ============================================================
-- Common use case: part of code
-- ============================================================
-- Если code имеет стабильную structure,
-- SUBSTR может взять нужную часть по position.
--
-- Пример:
SELECT SUBSTR('EMP-2026-458', 1, 3) AS code_type
FROM dual;

-- Result:
--   EMP
--
-- Пример:
SELECT SUBSTR('EMP-2026-458', 5, 4) AS code_year
FROM dual;

-- Result:
--   2026
--
-- Пример:
SELECT SUBSTR('EMP-2026-458', -3) AS code_number
FROM dual;

-- Result:
--   458


-- ============================================================
-- SUBSTR does not remove data from source
-- ============================================================
-- SUBSTR only returns part of text.
--
-- Пример:
SELECT 'Oracle Database' AS original_text,
       SUBSTR('Oracle Database', 8) AS text_part
FROM dual;

-- Result:
--   original_text = Oracle Database
--   text_part     = Database
--
-- Original text did not change.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что first position = 0.
--    В Oracle first position = 1.
--
-- 2. Путать start_position и number_of_characters.
--    start_position говорит, откуда начать.
--    number_of_characters говорит, сколько взять.
--
-- 3. Думать, что SUBSTR changes table data.
--    SELECT with SUBSTR only returns result set.
--
-- 4. Использовать SUBSTR с date и забывать про session format.
--    Date сначала converted to text.
--
-- 5. Использовать SUBSTR с number и думать математически.
--    SUBSTR работает с characters.
--
-- 6. Ожидать error, если length слишком большой.
--    Oracle просто вернет доступную часть text.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Возьми первые 3 characters:
SELECT SUBSTR('Oracle', 1, 3) AS result
FROM dual;

-- 2. Возьми text с position 4 до конца:
SELECT SUBSTR('Oracle Database', 4) AS result
FROM dual;

-- 3. Возьми 4 characters с position 8:
SELECT SUBSTR('Oracle Database', 8, 4) AS result
FROM dual;

-- 4. Возьми последние 3 characters:
SELECT SUBSTR('Database', -3) AS result
FROM dual;

-- 5. Проверь result, если start_position слишком большой:
SELECT SUBSTR('Database', 100, 5) AS result
FROM dual;

-- 6. Проверь result, если number_of_characters = 0:
SELECT SUBSTR('Database', 1, 0) AS result
FROM dual;

-- 7. Возьми first character from email:
SELECT email,
       SUBSTR(email, 1, 1) AS first_character
FROM employees;


-- ============================================================
-- Mini summary
-- ============================================================
-- SUBSTR returns part of text.
--
-- Syntax:
--   SUBSTR(source_text, start_position, number_of_characters)
--
-- Short syntax:
--   SUBSTR(source_text, start_position)
--
-- Important:
--   positions start with 1;
--   number_of_characters is optional;
--   without number_of_characters Oracle takes text to the end;
--   negative start_position counts from the end;
--   start_position = 0 is treated as 1;
--   if start_position is too large, result is NULL;
--   if number_of_characters is less than 1, result is NULL;
--   SUBSTR does not change table data.


