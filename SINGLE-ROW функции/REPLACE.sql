-- Character functions
-- String manipulation functions
-- REPLACE(s, search item, replacement item)

SELECT REPLACE('Private, kak dela, chto xorosheqo', 'o', '*')
FROM dual;

SELECT REPLACE('Private, kak dela, chto xorosheqo', 'et', 'bb')
FROM dual;

SELECT REPLACE('Private, kak dela, chto xorosheqo', 'w', 'bbbb')
FROM dual;

SELECT REPLACE('Private, kak dela, chto xorosheqo', 'o')
FROM dual;

SELECT salary,
       REPLACE(salary, 1, 9)
FROM employees;

SELECT hire_date,
       REPLACE(hire_date, '-', '.')
FROM employees;


-- ============================================================
-- Character functions
-- String function: REPLACE
-- ============================================================
-- REPLACE       - single-row character function.
--
-- Простыми словами:
--   REPLACE ищет одну часть text
--   и заменяет ее на другую часть text.
--
-- REPLACE не меняет source data в table.
-- Он только возвращает измененный text в result set.
--
-- Result:
--   character value
--
-- В этом уроке только REPLACE.
-- Другие string functions будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- REPLACE отвечает на вопрос:
--   "Замени вот это значение внутри text на другое значение."
--
-- Пример:
SELECT REPLACE('Oracle SQL', 'SQL', 'Database') AS new_text
FROM dual;

-- Result:
--   Oracle Database
--
-- Почему:
--   source_text      = 'Oracle SQL'
--   search_string    = 'SQL'
--   replacement_text = 'Database'
--
-- Oracle нашел 'SQL'
-- и заменил его на 'Database'.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   REPLACE(source_text, search_string, replacement_text)
--
-- Где:
--   source_text        - исходный text;
--   search_string      - что нужно найти;
--   replacement_text   - на что нужно заменить.
--
-- Третий argument можно не писать:
--
--   REPLACE(source_text, search_string)
--
-- Если replacement_text не указан,
-- Oracle удаляет search_string из source_text.


-- ============================================================
-- Replace one character
-- ============================================================
-- Можно заменить один character.
--
-- Пример из начала файла:
SELECT REPLACE('Private, kak dela, chto xorosheqo', 'o', '*') AS new_text
FROM dual;

-- Result:
--   Private, kak dela, cht* x*r*sheq*
--
-- Почему:
--   все lowercase 'o' заменились на '*'.
--
-- Важно:
--   REPLACE заменяет all occurrences,
--   а не только первое найденное значение.


-- ============================================================
-- Replace several characters
-- ============================================================
-- search_string может состоять из нескольких characters.
--
-- Пример из начала файла:
SELECT REPLACE('Private, kak dela, chto xorosheqo', 'et', 'bb') AS new_text
FROM dual;

-- Result:
--   Private, kak dela, chto xorosheqo
--
-- Почему:
--   sequence 'et' внутри source_text не найдена.
--   Поэтому source_text возвращается без изменений.
--
-- REPLACE ищет exact sequence characters.
--
-- Пример, где sequence найдена:
SELECT REPLACE('Private, kak dela, chto xorosheqo', 'te', 'bb') AS new_text
FROM dual;

-- Result:
--   Privabb, kak dela, chto xorosheqo


-- ============================================================
-- Replacement can be longer
-- ============================================================
-- replacement_text может быть длиннее,
-- чем search_string.
--
-- Пример:
SELECT REPLACE('SQL', 'S', 'Oracle S') AS new_text
FROM dual;

-- Result:
--   Oracle SQL
--
-- search_string = 'S'
-- replacement_text = 'Oracle S'
--
-- Result стал длиннее source_text.


-- ============================================================
-- Replacement can be shorter
-- ============================================================
-- replacement_text может быть короче,
-- чем search_string.
--
-- Пример:
SELECT REPLACE('Oracle Database', 'Database', 'DB') AS new_text
FROM dual;

-- Result:
--   Oracle DB
--
-- Result стал короче source_text.


-- ============================================================
-- If search string is not found
-- ============================================================
-- Если search_string не найден,
-- Oracle возвращает original text без изменений.
--
-- Пример из начала файла:
SELECT REPLACE('Private, kak dela, chto xorosheqo', 'w', 'bbbb') AS new_text
FROM dual;

-- Result:
--   Private, kak dela, chto xorosheqo
--
-- Почему:
--   character 'w' в source_text нет;
--   значит менять нечего.


-- ============================================================
-- Remove text with REPLACE
-- ============================================================
-- Если третий argument не указан,
-- REPLACE удаляет search_string.
--
-- Пример из начала файла:
SELECT REPLACE('Private, kak dela, chto xorosheqo', 'o') AS new_text
FROM dual;

-- Result:
--   Private, kak dela, cht xrsheq
--
-- Почему:
--   all lowercase 'o' removed.
--
-- Это то же самое по смыслу,
-- что replacement_text is NULL.
--
-- Пример:
SELECT REPLACE('Oracle SQL', ' SQL') AS new_text
FROM dual;

-- Result:
--   Oracle


-- ============================================================
-- Replace all occurrences
-- ============================================================
-- REPLACE заменяет все найденные occurrences.
--
-- Пример:
SELECT REPLACE('banana', 'a', '*') AS new_text
FROM dual;

-- Result:
--   b*n*n*
--
-- Почему:
--   в text есть три lowercase 'a';
--   все три заменились на '*'.
--
-- Пример:
SELECT REPLACE('aaaaa', 'a', 'x') AS new_text
FROM dual;

-- Result:
--   xxxxx


-- ============================================================
-- Replace exact sequence
-- ============================================================
-- REPLACE ищет exact sequence.
--
-- Пример:
SELECT REPLACE('ababab', 'ab', 'X') AS new_text
FROM dual;

-- Result:
--   XXX
--
-- Почему:
--   'ab' найдено три раза;
--   каждое occurrence заменено на 'X'.
--
-- Пример:
SELECT REPLACE('ababab', 'ba', 'X') AS new_text
FROM dual;

-- Result:
--   aXXb
--
-- Почему:
--   sequence 'ba' встречается внутри text;
--   REPLACE заменяет найденные exact sequences.


-- ============================================================
-- Case sensitivity
-- ============================================================
-- REPLACE is case-sensitive.
--
-- Это значит:
--   'a' and 'A' are different characters.
--
-- Пример:
SELECT REPLACE('Raul Aliishov', 'a', '*') AS new_text
FROM dual;

-- Result:
--   R*ul Aliishov
--
-- Только lowercase 'a' заменился.
--
-- Пример:
SELECT REPLACE('Raul Aliishov', 'A', '*') AS new_text
FROM dual;

-- Result:
--   Raul *liishov
--
-- Только uppercase 'A' заменился.


-- ============================================================
-- Replace spaces
-- ============================================================
-- Space тоже является character.
--
-- Пример:
SELECT REPLACE('Raul Aliishov', ' ', '_') AS new_text
FROM dual;

-- Result:
--   Raul_Aliishov
--
-- Почему:
--   space между словами заменился на underscore.
--
-- Пример:
SELECT REPLACE('Oracle SQL Course', ' ', '-') AS new_text
FROM dual;

-- Result:
--   Oracle-SQL-Course


-- ============================================================
-- Remove spaces
-- ============================================================
-- Если нужно удалить spaces,
-- можно использовать REPLACE без third argument.
--
-- Пример:
SELECT REPLACE('Oracle SQL Course', ' ') AS new_text
FROM dual;

-- Result:
--   OracleSQLCourse
--
-- Почему:
--   all spaces were removed.


-- ============================================================
-- Replace punctuation
-- ============================================================
-- REPLACE можно использовать для punctuation marks.
--
-- Пример:
SELECT REPLACE('01.02.2026', '.', '-') AS new_text
FROM dual;

-- Result:
--   01-02-2026
--
-- Пример:
SELECT REPLACE('A,B,C', ',', ';') AS new_text
FROM dual;

-- Result:
--   A;B;C


-- ============================================================
-- REPLACE in SELECT list
-- ============================================================
-- REPLACE можно использовать в SELECT list.
--
-- Пример:
SELECT employee_id,
       phone_number,
       REPLACE(phone_number, '.', '-') AS formatted_phone
FROM employees;

-- Meaning:
--   показать employee_id;
--   показать original phone_number;
--   показать phone_number, где dots replaced by hyphens.
--
-- SELECT не меняет данные в table employees.
-- Он только показывает result.


-- ============================================================
-- REPLACE with alias
-- ============================================================
-- Для expression удобно давать alias.
--
-- Пример:
SELECT REPLACE('Oracle SQL', 'SQL', 'Database') AS new_text
FROM dual;

-- Alias:
--   new_text
--
-- Без alias output column может называться длинно:
--   REPLACE('ORACLESQL','SQL','DATABASE')
--
-- С alias result set читать легче.


-- ============================================================
-- REPLACE with columns
-- ============================================================
-- REPLACE часто применяют к column values.
--
-- Пример:
SELECT first_name,
       REPLACE(first_name, 'a', '*') AS changed_name
FROM employees;

-- Meaning:
--   original first_name остается как есть;
--   changed_name показывает first_name,
--   где lowercase 'a' заменен на '*'.
--
-- Данные в table не изменяются.


-- ============================================================
-- REPLACE in WHERE
-- ============================================================
-- REPLACE можно использовать в WHERE condition.
--
-- Пример:
SELECT employee_id,
       phone_number
FROM employees
WHERE REPLACE(phone_number, '.', '-') = '515-123-4567';

-- Meaning:
--   сначала заменить dots на hyphens;
--   потом сравнить result со string literal.
--
-- Такой пример полезен,
-- когда одинаковые данные могут быть записаны
-- в разных visual formats.
--
-- Важно:
--   function в WHERE применяется к rows.
--   В больших tables это может влиять на performance.
--   Детали performance будут отдельной темой.


-- ============================================================
-- REPLACE with numbers
-- ============================================================
-- REPLACE является character function.
--
-- Если передать number,
-- Oracle может сделать implicit conversion в text.
--
-- Пример из начала файла:
SELECT salary,
       REPLACE(salary, 1, 9) AS changed_salary_text
FROM employees;

-- Meaning:
--   salary рассматривается как text;
--   character '1' заменяется на character '9'.
--
-- Например:
--   salary = 12000
--   REPLACE(salary, 1, 9) = 92000
--
-- Важно:
--   это text replacement,
--   а не mathematical operation.
--
-- Для ясности лучше писать string literals:
SELECT REPLACE('12000', '1', '9') AS changed_text
FROM dual;


-- ============================================================
-- REPLACE with dates
-- ============================================================
-- Если передать date,
-- Oracle может сделать implicit conversion в text.
--
-- Пример из начала файла:
SELECT hire_date,
       REPLACE(hire_date, '-', '.') AS changed_date_text
FROM employees;

-- Meaning:
--   hire_date будет converted to text;
--   потом '-' заменится на '.'.
--
-- Важно:
--   result зависит от date format текущей session.
--
-- Если session показывает date как:
--   17-JUN-03
--
-- Тогда result может быть:
--   17.JUN.03
--
-- Если в session другой date format,
-- result тоже может быть другим.
-- Форматы дат будут отдельной темой.


-- ============================================================
-- REPLACE and NULL
-- ============================================================
-- Если source_text is NULL,
-- result будет NULL.
--
-- Пример:
SELECT REPLACE(NULL, 'a', '*') AS new_text
FROM dual;

-- Result:
--   NULL
--
-- Если search_string is NULL,
-- Oracle возвращает source_text без изменений.
--
-- Пример:
SELECT REPLACE('Oracle', NULL, '*') AS new_text
FROM dual;

-- Result:
--   Oracle
--
-- Если replacement_text is NULL,
-- search_string удаляется.
--
-- Пример:
SELECT REPLACE('Oracle', 'a', NULL) AS new_text
FROM dual;

-- Result:
--   Orcle
--
-- В Oracle empty string обычно считается NULL.


-- ============================================================
-- Empty replacement by omitting third argument
-- ============================================================
-- Третий argument можно просто не писать.
--
-- Пример:
SELECT REPLACE('A-B-C-D', '-') AS new_text
FROM dual;

-- Result:
--   ABCD
--
-- Почему:
--   '-' найден;
--   replacement_text не указан;
--   значит '-' удаляется.


-- ============================================================
-- Replacement is not searched again
-- ============================================================
-- REPLACE выполняет замену по source_text.
--
-- Новый replacement_text не начинает бесконечную замену.
--
-- Пример:
SELECT REPLACE('aaa', 'a', 'aa') AS new_text
FROM dual;

-- Result:
--   aaaaaa
--
-- Почему:
--   в original text было 3 characters 'a';
--   каждый original 'a' заменился на 'aa';
--   result стал из 6 characters.
--
-- Oracle не продолжает снова заменять новые 'a'.


-- ============================================================
-- Overlapping matches
-- ============================================================
-- REPLACE ищет normal non-overlapping matches.
--
-- Пример:
SELECT REPLACE('aaaa', 'aa', 'X') AS new_text
FROM dual;

-- Result:
--   XX
--
-- Почему:
--   source_text можно разделить как:
--   aa + aa
--
-- Каждая найденная part заменяется на X.


-- ============================================================
-- Common use case: clean phone format
-- ============================================================
-- Частая задача:
--   заменить один separator на другой.
--
-- Пример:
SELECT phone_number,
       REPLACE(phone_number, '.', '-') AS phone_with_hyphens
FROM employees;

-- Meaning:
--   dots in phone_number become hyphens.


-- ============================================================
-- Common use case: remove separator
-- ============================================================
-- Иногда separator нужно удалить.
--
-- Пример:
SELECT REPLACE('AZ-2026-0001', '-') AS clean_code
FROM dual;

-- Result:
--   AZ20260001


-- ============================================================
-- Common use case: hide part of text
-- ============================================================
-- REPLACE можно использовать,
-- чтобы заменить sensitive-looking part in output.
--
-- Пример:
SELECT REPLACE('CARD-0000-0000-1234', '0000', '****') AS masked_text
FROM dual;

-- Result:
--   CARD-****-****-1234
--
-- Важно:
--   это только formatting in result set.
--   Это не security feature.


-- ============================================================
-- REPLACE does not change table data
-- ============================================================
-- SELECT with REPLACE показывает changed result,
-- но не updates table.
--
-- Пример:
SELECT first_name AS original_name,
       REPLACE(first_name, 'a', '*') AS changed_name
FROM employees;

-- original_name показывает value из table.
-- changed_name показывает calculated value.
--
-- Чтобы реально изменить table data,
-- нужна отдельная DML command.
-- Это другая тема.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что REPLACE меняет данные в table.
--    SELECT with REPLACE только показывает result set.
--
-- 2. Забывать, что REPLACE replaces all occurrences.
--    Он не останавливается после первого найденного match.
--
-- 3. Думать, что search_string не чувствителен к регистру.
--    'a' и 'A' считаются разными characters.
--
-- 4. Использовать numbers и dates без понимания conversion.
--    REPLACE работает с text.
--
-- 5. Забывать, что третий argument optional.
--    Если replacement_text не указан,
--    search_string удаляется.
--
-- 6. Ожидать error, если search_string не найден.
--    Error не будет; source_text вернется без изменений.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Замени 'SQL' на 'PL/SQL':
SELECT REPLACE('Oracle SQL', 'SQL', 'PL/SQL') AS result
FROM dual;

-- 2. Замени spaces на underscores:
SELECT REPLACE('Oracle SQL Course', ' ', '_') AS result
FROM dual;

-- 3. Удали hyphens:
SELECT REPLACE('A-B-C-D', '-') AS result
FROM dual;

-- 4. Замени dots на slashes:
SELECT REPLACE('15.08.2026', '.', '/') AS result
FROM dual;

-- 5. Проверь result, если search_string не найден:
SELECT REPLACE('Oracle', 'x', '*') AS result
FROM dual;

-- 6. Проверь case sensitivity:
SELECT REPLACE('Raul Aliishov', 'a', '*') AS result
FROM dual;

-- 7. Примени REPLACE к column:
SELECT phone_number,
       REPLACE(phone_number, '.', '-') AS formatted_phone
FROM employees;


-- ============================================================
-- Mini summary
-- ============================================================
-- REPLACE replaces text inside text.
--
-- Syntax:
--   REPLACE(source_text, search_string, replacement_text)
--
-- Short syntax:
--   REPLACE(source_text, search_string)
--
-- Important:
--   REPLACE returns character value;
--   REPLACE replaces all occurrences;
--   if search_string is not found, source_text is returned;
--   if replacement_text is omitted or NULL, search_string is removed;
--   REPLACE is case-sensitive;
--   numbers and dates may be converted to text;
--   SELECT with REPLACE does not change table data.
