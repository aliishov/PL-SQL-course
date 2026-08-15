-- Character functions
-- String manipulation functions
-- TRIM({trailing|leading|both}trimstring from s)

SELECT TRIM(TRAILING 'q' FROM 'Raulqqqqq')
FROM dual;

SELECT TRIM(LEADING '*' FROM '*****Raul')
FROM dual;

SELECT TRIM(BOTH 'q' FROM 'qqqRaulqqqqq')
FROM dual;

SELECT TRIM(' ' FROM '     Raul    ')
FROM dual;

SELECT TRIM(' ' FROM '     Raul Alishov    ')
FROM dual;

SELECT TRIM('     Raul Alishov    ')
FROM dual;

SELECT TRIM(BOTH 7 FROM 776547)
FROM dual;


-- ============================================================
-- Character functions
-- String function: TRIM
-- ============================================================
-- TRIM          - single-row character function.
--
-- Простыми словами:
--   TRIM убирает лишний character с начала text,
--   с конца text или с обеих сторон.
--
-- Чаще всего TRIM используют для удаления пробелов:
--   '   Raul   '  ->  'Raul'
--
-- Но TRIM может удалять не только space,
-- а любой один указанный character:
--   '*'
--   'q'
--   '0'
--   '#'
--
-- В этом уроке только TRIM.
-- Другие string functions будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- TRIM работает только по краям строки.
--
-- Он проверяет:
--   начало text;
--   конец text;
--   или обе стороны.
--
-- Если указанный character находится внутри text,
-- TRIM его не удаляет.
--
-- Пример:
SELECT TRIM(' ' FROM '   Raul Aliishov   ') AS clean_text
FROM dual;

-- Result:
--   Raul Aliishov
--
-- Пробелы слева и справа удалились.
-- Пробел между Raul и Aliishov остался,
-- потому что это середина text.


-- ============================================================
-- Syntax
-- ============================================================
-- Полный синтаксис:
--
--   TRIM([LEADING | TRAILING | BOTH] [trim_character] FROM source_text)
--
-- Упрощенный синтаксис:
--
--   TRIM(source_text)
--
-- Где:
--   LEADING          - удалить character только слева;
--   TRAILING         - удалить character только справа;
--   BOTH             - удалить character слева и справа;
--   trim_character   - какой character удалить;
--   source_text      - исходный text.
--
-- Если LEADING, TRAILING или BOTH не указаны,
-- Oracle по умолчанию использует BOTH.
--
-- Если trim_character не указан,
-- Oracle по умолчанию удаляет space.


-- ============================================================
-- TRIM without extra options
-- ============================================================
-- Самый частый вариант:
SELECT TRIM('     Raul     ') AS clean_name
FROM dual;

-- Meaning:
--   удалить пробелы с обеих сторон.
--
-- Result:
--   Raul
--
-- Это то же самое по смыслу, что:
SELECT TRIM(BOTH ' ' FROM '     Raul     ') AS clean_name
FROM dual;

-- Почему:
--   BOTH используется по умолчанию;
--   space используется по умолчанию.


-- ============================================================
-- TRIM with spaces
-- ============================================================
-- TRIM хорошо подходит, когда данные были введены
-- с лишними пробелами.
--
-- Пример:
SELECT TRIM('   Steven   ') AS employee_name
FROM dual;

-- Result:
--   Steven
--
-- Левые и правые spaces удалены.


-- ============================================================
-- TRIM does not remove inner spaces
-- ============================================================
-- Важно:
--   TRIM не чистит середину строки.
--
-- Пример:
SELECT TRIM('   Raul     Aliishov   ') AS clean_text
FROM dual;

-- Result:
--   Raul     Aliishov
--
-- Почему:
--   spaces перед Raul удалены;
--   spaces после Aliishov удалены;
--   spaces между словами остались.
--
-- TRIM работает только с краями text.


-- ============================================================
-- LEADING
-- ============================================================
-- LEADING означает:
--   удалить character только с начала text.
--
-- Пример:
SELECT TRIM(LEADING '*' FROM '*****Raul') AS clean_text
FROM dual;

-- Result:
--   Raul
--
-- Пример с правой частью:
SELECT TRIM(LEADING '*' FROM '*****Raul*****') AS clean_text
FROM dual;

-- Result:
--   Raul*****
--
-- Почему:
--   LEADING удаляет '*' только слева.
--   Справа characters остаются.


-- ============================================================
-- TRAILING
-- ============================================================
-- TRAILING означает:
--   удалить character только с конца text.
--
-- Пример:
SELECT TRIM(TRAILING 'q' FROM 'Raulqqqqq') AS clean_text
FROM dual;

-- Result:
--   Raul
--
-- Пример с левой частью:
SELECT TRIM(TRAILING 'q' FROM 'qqqRaulqqqqq') AS clean_text
FROM dual;

-- Result:
--   qqqRaul
--
-- Почему:
--   TRAILING удаляет 'q' только справа.
--   Слева characters остаются.


-- ============================================================
-- BOTH
-- ============================================================
-- BOTH означает:
--   удалить character и слева, и справа.
--
-- Пример:
SELECT TRIM(BOTH 'q' FROM 'qqqRaulqqqqq') AS clean_text
FROM dual;

-- Result:
--   Raul
--
-- Почему:
--   все 'q' слева удалены;
--   все 'q' справа удалены.
--
-- Character внутри слова TRIM не трогает.


-- ============================================================
-- BOTH is default
-- ============================================================
-- Если не писать LEADING, TRAILING или BOTH,
-- Oracle работает как BOTH.
--
-- Пример:
SELECT TRIM('q' FROM 'qqqRaulqqq') AS clean_text
FROM dual;

-- Result:
--   Raul
--
-- Это короткая форма для:
SELECT TRIM(BOTH 'q' FROM 'qqqRaulqqq') AS clean_text
FROM dual;


-- ============================================================
-- Space is default trim character
-- ============================================================
-- Если trim_character не указан,
-- Oracle удаляет обычный space.
--
-- Пример:
SELECT TRIM('     Raul Aliishov    ') AS clean_text
FROM dual;

-- Result:
--   Raul Aliishov
--
-- Это короткая форма для:
SELECT TRIM(BOTH ' ' FROM '     Raul Aliishov    ') AS clean_text
FROM dual;


-- ============================================================
-- TRIM with one custom character
-- ============================================================
-- TRIM удаляет один указанный character.
--
-- Пример:
SELECT TRIM(BOTH '#' FROM '###Oracle###') AS clean_text
FROM dual;

-- Result:
--   Oracle
--
-- Пример:
SELECT TRIM(BOTH '0' FROM '0001500') AS clean_text
FROM dual;

-- Result:
--   15
--
-- Почему:
--   слева удалились все '0';
--   справа удалились все '0';
--   character '5' остановил удаление справа;
--   character '1' остановил удаление слева.


-- ============================================================
-- TRIM removes repeated edge characters
-- ============================================================
-- TRIM удаляет character столько раз,
-- сколько он повторяется на краю text.
--
-- Пример:
SELECT TRIM(LEADING '*' FROM '********Report') AS clean_title
FROM dual;

-- Result:
--   Report
--
-- Пример:
SELECT TRIM(TRAILING '.' FROM 'Done.....') AS clean_status
FROM dual;

-- Result:
--   Done


-- ============================================================
-- TRIM stops when another character appears
-- ============================================================
-- TRIM идет от края text внутрь.
--
-- Как только он встречает другой character,
-- удаление с этой стороны останавливается.
--
-- Пример:
SELECT TRIM(BOTH '0' FROM '0005007000') AS clean_code
FROM dual;

-- Result:
--   5007
--
-- Почему:
--   leading zeros удалились до character '5';
--   trailing zeros удалились до character '7';
--   zero внутри text остался.


-- ============================================================
-- TRIM in SELECT list
-- ============================================================
-- TRIM можно использовать в SELECT list.
--
-- Пример:
SELECT first_name,
       TRIM(first_name) AS clean_first_name
FROM employees;

-- Meaning:
--   показать original first_name;
--   рядом показать first_name без лишних spaces по краям.
--
-- Если в column нет лишних spaces,
-- result будет выглядеть так же.


-- ============================================================
-- TRIM with alias
-- ============================================================
-- Для expression удобно давать alias.
--
-- Пример:
SELECT TRIM('   Oracle SQL   ') AS clean_value
FROM dual;

-- Alias:
--   clean_value
--
-- Без alias column name в result set может быть длинным:
--   TRIM('ORACLESQL')
--
-- С alias output читать легче.


-- ============================================================
-- TRIM with column values
-- ============================================================
-- TRIM часто применяют к column values,
-- если данные могут содержать лишние spaces.
--
-- Пример:
SELECT first_name,
       TRIM(first_name) AS cleaned_name
FROM employees;

-- Важно:
--   этот SELECT не меняет данные в table employees.
--   Он только показывает очищенное значение в result set.
--
-- Чтобы реально изменить данные в table,
-- нужна отдельная DML command.
-- Это другая тема.


-- ============================================================
-- TRIM in WHERE
-- ============================================================
-- TRIM можно использовать и в WHERE condition.
--
-- Пример:
SELECT employee_id,
       first_name
FROM employees
WHERE TRIM(first_name) = 'Steven';

-- Meaning:
--   сначала убрать лишние spaces у first_name;
--   потом сравнить result со string literal 'Steven'.
--
-- Такой вариант может помочь,
-- если в data есть значения вида:
--   'Steven'
--   ' Steven'
--   'Steven '
--   ' Steven '
--
-- Но важно:
--   функция в WHERE применяется к каждой row.
--   В больших таблицах это может влиять на performance.
--   Детали performance будут отдельной темой.


-- ============================================================
-- TRIM with numbers
-- ============================================================
-- TRIM является character function.
--
-- Если передать number,
-- Oracle может сделать implicit conversion в text.
--
-- Пример:
SELECT TRIM(BOTH 7 FROM 776547) AS clean_number_text
FROM dual;

-- Possible result:
--   654
--
-- Почему:
--   776547 сначала рассматривается как text;
--   слева удаляются '7';
--   справа удаляется '7'.
--
-- Но для ясности лучше писать так:
SELECT TRIM(BOTH '7' FROM '776547') AS clean_number_text
FROM dual;

-- Так сразу видно,
-- что TRIM работает с characters.


-- ============================================================
-- TRIM with NULL
-- ============================================================
-- Если source_text is NULL,
-- result тоже будет NULL.
--
-- Пример:
SELECT TRIM(NULL) AS clean_value
FROM dual;

-- Result:
--   NULL
--
-- Если trim_character is NULL,
-- Oracle тоже возвращает NULL.
--
-- Пример:
SELECT TRIM(BOTH NULL FROM 'Raul') AS clean_value
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- Empty result
-- ============================================================
-- Если весь text состоит только из trim_character,
-- после TRIM ничего не остается.
--
-- Пример:
SELECT TRIM(BOTH '*' FROM '*****') AS clean_text
FROM dual;

-- В Oracle empty string обычно считается NULL.
-- Поэтому result может отображаться как NULL.


-- ============================================================
-- trim_character must be one character
-- ============================================================
-- В Oracle trim_character должен быть одним character.
--
-- Correct:
SELECT TRIM(BOTH '*' FROM '***Oracle***') AS clean_text
FROM dual;

-- Not correct:
-- SELECT TRIM(BOTH 'ABC' FROM 'ABCOracleABC') AS clean_text
-- FROM dual;
--
-- Почему:
--   TRIM не удаляет слово или часть строки.
--   Он удаляет один character с краев.
--
-- Для удаления более сложных частей text
-- используются другие функции и темы.


-- ============================================================
-- Difference between TRIM and cleaning inside text
-- ============================================================
-- TRIM не предназначен для удаления characters внутри text.
--
-- Пример:
SELECT TRIM(BOTH 'a' FROM 'aaaRaulaaa') AS clean_text
FROM dual;

-- Result:
--   Raul
--
-- Пример:
SELECT TRIM(BOTH 'a' FROM 'Raaul') AS clean_text
FROM dual;

-- Result:
--   Raaul
--
-- Почему:
--   'a' внутри text не на краю;
--   значит TRIM его не удаляет.


-- ============================================================
-- Common use case: clean user input
-- ============================================================
-- Частая задача:
--   пользователь ввел text с лишними spaces.
--
-- Пример:
SELECT TRIM('   IT_PROG   ') AS job_id
FROM dual;

-- Result:
--   IT_PROG
--
-- Это полезно перед сравнением,
-- показом данных или подготовкой result set.


-- ============================================================
-- Common use case: clean codes
-- ============================================================
-- Иногда codes хранятся с лишними characters по краям.
--
-- Пример:
SELECT TRIM(BOTH '0' FROM '000EMP0100') AS employee_code
FROM dual;

-- Result:
--   EMP01
--
-- Внутренний zero остался,
-- потому что он не на краю text.


-- ============================================================
-- Common use case: prepare output
-- ============================================================
-- TRIM можно использовать,
-- чтобы сделать output аккуратнее.
--
-- Пример:
SELECT employee_id,
       TRIM(first_name) AS first_name,
       TRIM(last_name) AS last_name
FROM employees;

-- Meaning:
--   employee_id выводится как есть;
--   first_name и last_name выводятся без лишних spaces по краям.
--
-- Данные в table не изменяются.


-- ============================================================
-- TRIM with text literal examples
-- ============================================================
SELECT TRIM(BOTH '-' FROM '---SQL---') AS result
FROM dual;

SELECT TRIM(LEADING '-' FROM '---SQL---') AS result
FROM dual;

SELECT TRIM(TRAILING '-' FROM '---SQL---') AS result
FROM dual;

-- Results:
--   BOTH      -> SQL
--   LEADING   -> SQL---
--   TRAILING  -> ---SQL


-- ============================================================
-- TRIM with employee columns
-- ============================================================
SELECT employee_id,
       first_name,
       TRIM(first_name) AS clean_first_name
FROM employees;

SELECT employee_id,
       last_name,
       TRIM(last_name) AS clean_last_name
FROM employees;

-- Эти examples показывают,
-- что TRIM можно применять к любой character column.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что TRIM удаляет characters внутри text.
--    Нет, TRIM работает только по краям.
--
-- 2. Думать, что TRIM всегда удаляет только spaces.
--    Нет, можно указать свой trim_character.
--
-- 3. Писать несколько characters как trim_character.
--    В Oracle trim_character должен быть одним character.
--
-- 4. Забывать FROM в полной форме syntax.
--    Correct:
--      TRIM(BOTH '*' FROM '***Raul***')
--
-- 5. Использовать TRIM для number values без понимания conversion.
--    Лучше явно писать string literals:
--      TRIM(BOTH '7' FROM '776547')


-- ============================================================
-- Practice
-- ============================================================
-- 1. Удали spaces с обеих сторон:
SELECT TRIM('     Oracle     ') AS result
FROM dual;

-- 2. Удали '*' только слева:
SELECT TRIM(LEADING '*' FROM '***Oracle***') AS result
FROM dual;

-- 3. Удали '#' только справа:
SELECT TRIM(TRAILING '#' FROM 'Oracle###') AS result
FROM dual;

-- 4. Удали '0' с обеих сторон:
SELECT TRIM(BOTH '0' FROM '0004500') AS result
FROM dual;

-- 5. Проверь, что space внутри text не удаляется:
SELECT TRIM('   Oracle   SQL   ') AS result
FROM dual;


-- ============================================================
-- Mini summary
-- ============================================================
-- TRIM removes characters from the edges of text.
--
-- Default behavior:
--   TRIM(text)
--   удаляет spaces слева и справа.
--
-- Direction options:
--   LEADING   - from the beginning;
--   TRAILING  - from the end;
--   BOTH      - from both sides.
--
-- Important:
--   TRIM works only with edge characters;
--   TRIM does not remove characters inside text;
--   trim_character should be one character;
--   source data in table is not changed by SELECT.


