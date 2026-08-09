-- ============================================================
-- LIKE operator
-- ============================================================
-- LIKE          - operator для поиска text по pattern.
--
-- Простыми словами:
--   LIKE используется, когда нужно найти строки,
--   которые похожи на заданный шаблон.
--
-- LIKE чаще всего используется в WHERE condition.
--
-- Синтаксис:
--   column_name LIKE pattern
--
-- Pattern пишется как string:
--   'S%'
--   '%r'
--   'D_n'
--
-- В этом уроке только LIKE operator:
--   %
--   _
--   ESCAPE
--   простые text patterns


-- ============================================================
-- Wildcards
-- ============================================================
-- В LIKE есть специальные symbols:
--
--   %  - любое количество символов.
--        Может быть 0 символов, 1 символ или много символов.
--
--   _  - ровно один символ.
--
-- Эти symbols называются wildcards.
--
-- Пример:
--   'S%'
--
-- Meaning:
--   text начинается на S,
--   а после S может быть что угодно.
--
-- Пример:
--   'D_n'
--
-- Meaning:
--   text из трех символов:
--     D
--     любой один символ
--     n


-- ============================================================
-- LIKE with %
-- ============================================================
-- % означает:
--   на этом месте может быть любое количество symbols.
--
-- Example: starts with S
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- Подходят values:
--   Steven
--   Shelli
--   Sundar
--   S
--
-- Почему S тоже подходит?
--   Потому что % может означать 0 symbols.
--
-- Pattern:
--   'S%'
--
-- Meaning:
--   first_name начинается с S.


-- ============================================================
-- LIKE vs =
-- ============================================================
-- = используется для точного совпадения.
-- LIKE используется для pattern matching.
--
-- Правильно:
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- Meaning:
--   найти names, которые начинаются с S.
--
-- Неправильная идея:
SELECT *
FROM employees
WHERE first_name = 'S%';

-- Здесь Oracle ищет exact value:
--   S%
--
-- То есть обычное равенство не понимает % как wildcard.
-- Wildcards работают именно с LIKE.


-- ============================================================
-- Starts with
-- ============================================================
-- Pattern для "начинается с":
--   'text%'
--
-- Example:
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- Meaning:
--   first_name starts with S.
--
-- Example:
SELECT *
FROM employees
WHERE job_id LIKE 'ST%';

-- Meaning:
--   job_id starts with ST.
--
-- Подходят:
--   ST_CLERK
--   ST_MAN


-- ============================================================
-- Ends with
-- ============================================================
-- Pattern для "заканчивается на":
--   '%text'
--
-- Example:
SELECT *
FROM employees
WHERE first_name LIKE '%r';

-- Meaning:
--   first_name ends with r.
--
-- Подходят values:
--   Alexander
--   Peter
--
-- Pattern:
--   '%r'
--
-- До r может быть любое количество symbols.


-- ============================================================
-- Contains
-- ============================================================
-- Pattern для "содержит":
--   '%text%'
--
-- Example:
SELECT *
FROM employees
WHERE first_name LIKE '%ar%';

-- Meaning:
--   first_name contains ar.
--
-- Подходят values:
--   Sarah
--   Clara
--   Mark
--
-- Pattern:
--   '%ar%'
--
-- До ar и после ar может быть любое количество symbols.


-- ============================================================
-- LIKE with only %
-- ============================================================
-- Pattern '%' означает:
--   любое text value.
--
-- Example:
SELECT *
FROM employees
WHERE first_name LIKE '%';

-- Meaning:
--   first_name имеет text value.
--
-- Такой query обычно бесполезен для фильтрации,
-- потому что pattern слишком широкий.
--
-- Его можно увидеть в учебных примерах,
-- чтобы понять, что % может заменить все symbols.


-- ============================================================
-- LIKE with _
-- ============================================================
-- _ означает:
--   ровно один symbol.
--
-- Example:
SELECT *
FROM employees
WHERE first_name LIKE 'D_n';

-- Pattern:
--   D_n
--
-- Meaning:
--   text должен иметь 3 symbols:
--     1. D
--     2. любой один symbol
--     3. n
--
-- Подходит:
--   Dan
--   Don
--
-- Не подходит:
--   Dean
--
-- Почему Dean не подходит?
--   Потому что Dean имеет 4 symbols,
--   а D_n ожидает ровно 3.


-- ============================================================
-- Multiple underscores
-- ============================================================
-- Каждый _ заменяет ровно один symbol.
--
-- Example:
SELECT *
FROM employees
WHERE first_name LIKE '__n%';

-- Pattern:
--   __n%
--
-- Meaning:
--   first symbol  - любой;
--   second symbol - любой;
--   third symbol  - n;
--   дальше может быть любое количество symbols.
--
-- Подходит:
--   Jennifer
--   Daniel
--
-- Главное:
--   два underscores = ровно два symbols.


-- ============================================================
-- Combined usage of % and _
-- ============================================================
-- % и _ можно использовать вместе.
--
-- Example:
SELECT *
FROM employees
WHERE first_name LIKE 'A%d%';

-- Pattern:
--   A%d%
--
-- Meaning:
--   first_name начинается с A;
--   потом может быть любое количество symbols;
--   потом где-то есть d;
--   после d может быть любое количество symbols.
--
-- Example:
SELECT *
FROM employees
WHERE first_name LIKE '_a%';

-- Pattern:
--   _a%
--
-- Meaning:
--   первый symbol любой;
--   второй symbol = a;
--   дальше может быть любое количество symbols.


-- ============================================================
-- Case sensitivity
-- ============================================================
-- LIKE может быть чувствителен к uppercase/lowercase.
--
-- Example:
SELECT *
FROM employees
WHERE first_name LIKE 's%';

-- Этот query может отличаться от:
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- Чтобы искать без учета регистра,
-- можно привести column и pattern к одному case.
--
-- Example:
SELECT *
FROM employees
WHERE UPPER(first_name) LIKE 'S%';

-- UPPER(first_name) делает name uppercase для comparison.
--
-- Важно:
--   Это уже expression с function.
--   В этом уроке важно понять идею:
--     LIKE сравнивает text с pattern.


-- ============================================================
-- ESCAPE
-- ============================================================
-- Иногда нужно найти сам symbol _ или %,
-- а не использовать его как wildcard.
--
-- Для этого используется ESCAPE.
--
-- Example:
SELECT *
FROM employees
WHERE job_id LIKE 'ST\_%' ESCAPE '\';

-- Pattern:
--   ST\_%
--
-- ESCAPE '\':
--   \_ означает literal underscore.
--   Последний % остается wildcard.
--
-- Meaning:
--   найти job_id, которые начинаются с:
--     ST_
--
-- Подходит:
--   ST_CLERK
--   ST_MAN
--
-- Почему нужен ESCAPE?
--   Без ESCAPE symbol _ означает "любой один symbol".
--   С ESCAPE можно сказать Oracle:
--     здесь _ является обычным text symbol.


-- ============================================================
-- ESCAPE for percent symbol
-- ============================================================
-- Если нужно найти literal %,
-- тоже можно использовать ESCAPE.
--
-- Example:
SELECT '50% discount' AS text_value
FROM dual
WHERE '50% discount' LIKE '50\%%' ESCAPE '\';

-- Pattern:
--   50\%%
--
-- Meaning:
--   text начинается с literal 50%;
--   после этого может быть любое количество symbols.
--
-- Подходит:
--   50% discount
--   50% cotton
--
-- Здесь:
--   \% - literal percent symbol.
--   последний % - wildcard.


-- ============================================================
-- Readable formatting
-- ============================================================
-- Однострочный query:
SELECT * FROM employees WHERE first_name LIKE 'S%';

-- Лучше:
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- Если SELECT list длинный:
SELECT employee_id,
       first_name,
       last_name,
       job_id
FROM employees
WHERE job_id LIKE 'ST%';

-- Хорошая привычка:
--   LIKE pattern всегда писать в single quotes.
--   WHERE держать на отдельной строке.
--   Pattern выбирать так, чтобы он отражал задачу.


-- ============================================================
-- Simple examples
-- ============================================================
-- Starts with S:
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- Ends with r:
SELECT *
FROM employees
WHERE first_name LIKE '%r';

-- Contains ar:
SELECT *
FROM employees
WHERE first_name LIKE '%ar%';

-- Three symbols, D + any one symbol + n:
SELECT *
FROM employees
WHERE first_name LIKE 'D_n';

-- First symbol any, second symbol a:
SELECT *
FROM employees
WHERE first_name LIKE '_a%';

-- Literal underscore after ST:
SELECT *
FROM employees
WHERE job_id LIKE 'ST\_%' ESCAPE '\';


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Использовать = вместо LIKE для pattern.
--
--    Неправильно для поиска names на S:
--      first_name = 'S%'
--
--    Правильно:
--      first_name LIKE 'S%'
--
-- 2. Забывать quotes вокруг pattern.
--
--    Неправильно:
--      first_name LIKE S%
--
--    Правильно:
--      first_name LIKE 'S%'
--
-- 3. Путать % и _.
--
--    % означает любое количество symbols.
--    _ означает ровно один symbol.
--
-- 4. Искать literal _ без ESCAPE.
--
--    Если нужен настоящий underscore,
--    используй ESCAPE.
--
-- 5. Делать слишком широкий pattern.
--
--    LIKE '%' почти ничего не фильтрует.
--
-- 6. Забывать про uppercase/lowercase.
--
--    'S%' и 's%' могут дать разные results.


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Выведи employees,
--   у которых first_name начинается с S.
--
-- Task 2:
--   Выведи employees,
--   у которых first_name заканчивается на r.
--
-- Task 3:
--   Выведи employees,
--   у которых first_name содержит ar.
--
-- Task 4:
--   Выведи employees,
--   у которых first_name подходит под pattern:
--     D_n
--
-- Task 5:
--   Выведи employees,
--   у которых second symbol в first_name равен a.
--
-- Task 6:
--   Выведи employees,
--   у которых job_id начинается с literal ST_.
--   Используй ESCAPE.
--
-- Task 7:
--   Объясни своими словами:
--     чем % отличается от _;
--     почему first_name = 'S%' не работает как pattern search;
--     зачем нужен ESCAPE.


-- ============================================================
-- Summary
-- ============================================================
-- LIKE:
--   ищет text по pattern;
--   используется в WHERE condition;
--   работает с wildcards.
--
-- Wildcards:
--   %  - любое количество symbols.
--   _  - ровно один symbol.
--
-- ESCAPE:
--   помогает искать literal % или _.
--
-- Главное:
--   LIKE нужен, когда exact comparison через =
--   слишком строгий и нужен поиск по text pattern.
