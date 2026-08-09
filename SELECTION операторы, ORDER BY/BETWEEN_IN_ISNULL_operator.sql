-- ============================================================
-- BETWEEN, IN, IS NULL operators
-- ============================================================
-- В этом уроке 3 оператора для WHERE condition:
--
--   BETWEEN     - value находится в диапазоне.
--   IN          - value находится в списке значений.
--   IS NULL     - value отсутствует.
--
-- Эти operators помогают писать WHERE короче и понятнее.
--
-- В этом файле не разбираем другие операторы.
-- Только BETWEEN, IN, IS NULL / IS NOT NULL.


-- ============================================================
-- BETWEEN
-- ============================================================
-- BETWEEN       - используется, чтобы выбрать значения
--                 от lower boundary до upper boundary.
--
-- Простыми словами:
--   BETWEEN означает "между".
--
-- Синтаксис:
--   column_name BETWEEN low_value AND high_value
--
-- Важно:
--   BETWEEN включает обе границы.
--
-- То есть:
--   BETWEEN 4000 AND 10000
--
-- включает:
--   4000
--   10000
--   все значения между ними.
--
-- Слово AND здесь является частью syntax BETWEEN.


-- ============================================================
-- BETWEEN with numbers
-- ============================================================
-- Пример:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary BETWEEN 4000 AND 10000;

-- Meaning:
--   показать employees,
--   у которых salary находится в диапазоне
--   от 4000 до 10000 включительно.
--
-- Значения, которые подходят:
--   4000
--   5000
--   7500
--   10000
--
-- Значения, которые не подходят:
--   3999
--   10001
--
-- Хорошая привычка:
--   сначала lower boundary;
--   потом upper boundary.
--
-- Правильно:
--   salary BETWEEN 4000 AND 10000
--
-- Плохо читается и обычно неверно по смыслу:
--   salary BETWEEN 10000 AND 4000


-- ============================================================
-- BETWEEN with dates
-- ============================================================
-- BETWEEN можно использовать с DATE values.
--
-- Пример:
SELECT *
FROM job_history
WHERE start_date BETWEEN TO_DATE('2004-01-01', 'YYYY-MM-DD')
                     AND TO_DATE('2006-12-31', 'YYYY-MM-DD');

-- Meaning:
--   показать rows из job_history,
--   где start_date находится между
--   01 January 2004 и 31 December 2006 включительно.
--
-- Почему используем TO_DATE:
--   формат даты указан явно;
--   query меньше зависит от настроек session;
--   код легче читать.
--
-- Менее надежно:
--   start_date BETWEEN '01-Jan-04' AND '31-Dec-06'
--
-- Лучше:
--   start_date BETWEEN TO_DATE('2004-01-01', 'YYYY-MM-DD')
--                  AND TO_DATE('2006-12-31', 'YYYY-MM-DD')


-- ============================================================
-- BETWEEN with text
-- ============================================================
-- BETWEEN можно использовать и с text values.
--
-- Пример:
SELECT *
FROM employees
WHERE first_name BETWEEN 'A' AND 'C';

-- Meaning:
--   показать employees,
--   у которых first_name попадает в текстовый диапазон
--   от 'A' до 'C'.
--
-- Важно:
--   Для text сравнение зависит от правил сравнения строк
--   в database/session.
--
-- В учебных примерах это помогает понять идею,
-- но в реальных задачах с текстовыми диапазонами
-- нужно быть внимательным к регистру и сортировке.


-- ============================================================
-- IN
-- ============================================================
-- IN            - проверяет, находится ли value
--                 в указанном списке values.
--
-- Простыми словами:
--   IN означает "в списке".
--
-- Синтаксис:
--   column_name IN (value1, value2, value3)
--
-- IN удобно использовать,
-- когда нужно сравнить column с несколькими возможными values.
--
-- В списке values:
--   numbers пишутся без quotes;
--   text пишется в single quotes;
--   dates лучше писать через TO_DATE.


-- ============================================================
-- IN with numbers
-- ============================================================
-- Пример:
SELECT *
FROM departments
WHERE location_id IN (1700, 2400, 1500);

-- Meaning:
--   показать departments,
--   где location_id равен одному из значений:
--     1700
--     2400
--     1500
--
-- IN делает query короче,
-- когда допустимых значений несколько.
--
-- Порядок values внутри IN list
-- не означает порядок вывода rows.
-- Это просто список допустимых values.


-- ============================================================
-- IN with text
-- ============================================================
-- Пример:
SELECT *
FROM job_history
WHERE job_id IN ('IT_PROG', 'ST_CLERK');

-- Meaning:
--   показать rows,
--   где job_id равен одному из values:
--     'IT_PROG'
--     'ST_CLERK'
--
-- Text values обязательно пишутся в single quotes.
--
-- Неправильно:
--   job_id IN (IT_PROG, ST_CLERK)
--
-- Правильно:
--   job_id IN ('IT_PROG', 'ST_CLERK')


-- ============================================================
-- IN with dates
-- ============================================================
-- Пример:
SELECT *
FROM job_history
WHERE end_date IN (
  TO_DATE('2007-12-31', 'YYYY-MM-DD'),
  TO_DATE('2005-05-05', 'YYYY-MM-DD')
);

-- Meaning:
--   показать rows,
--   где end_date равен одной из двух dates:
--     31 December 2007
--     05 May 2005
--
-- Для dates лучше использовать TO_DATE,
-- чтобы явно указать формат.


-- ============================================================
-- IN list formatting
-- ============================================================
-- Короткий список можно писать в одну строку:
SELECT *
FROM departments
WHERE location_id IN (1700, 2400, 1500);

-- Длинный список удобнее писать по строкам:
SELECT *
FROM job_history
WHERE job_id IN (
  'IT_PROG',
  'ST_CLERK'
);

-- Главное:
--   values внутри parentheses разделяются commas.
--
-- После последнего value comma не ставится.


-- ============================================================
-- IS NULL
-- ============================================================
-- IS NULL       - проверяет, что value отсутствует.
--
-- NULL          - отсутствие значения.
--
-- В Oracle нельзя надежно проверять NULL через обычное равенство.
--
-- Правильно:
--   column_name IS NULL
--
-- Неправильно:
--   column_name = NULL
--
-- Почему:
--   NULL означает unknown / absence of value.
--   Поэтому для NULL есть отдельный operator IS NULL.


-- ============================================================
-- IS NULL examples
-- ============================================================
-- Пример:
SELECT *
FROM employees
WHERE commission_pct IS NULL;

-- Meaning:
--   показать employees,
--   у которых commission_pct отсутствует.
--
-- Еще пример:
SELECT *
FROM employees
WHERE first_name IS NULL;

-- Meaning:
--   показать employees,
--   у которых first_name отсутствует.
--
-- Еще пример:
SELECT *
FROM employees
WHERE hire_date IS NULL;

-- Meaning:
--   показать employees,
--   у которых hire_date отсутствует.


-- ============================================================
-- IS NOT NULL
-- ============================================================
-- IS NOT NULL   - проверяет, что value существует.
--
-- Пример:
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;

-- Meaning:
--   показать employees,
--   у которых commission_pct заполнен.
--
-- IS NULL:
--   value отсутствует.
--
-- IS NOT NULL:
--   value существует.


-- ============================================================
-- NULL is not zero and not empty text
-- ============================================================
-- NULL не равен 0.
-- NULL не равен обычному text value.
-- NULL означает отсутствие значения.
--
-- Пример:
SELECT *
FROM employees
WHERE commission_pct IS NULL;

-- Этот query ищет missing commission_pct.
--
-- Если commission_pct = 0,
-- это уже не NULL.
-- Это конкретное number value 0.
--
-- Поэтому:
--   IS NULL      - value отсутствует.
--   = 0          - value равен number 0.


-- ============================================================
-- Simple examples
-- ============================================================
-- BETWEEN number:
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary BETWEEN 4000 AND 10000;

-- BETWEEN date:
SELECT *
FROM job_history
WHERE start_date BETWEEN TO_DATE('2004-01-01', 'YYYY-MM-DD')
                     AND TO_DATE('2006-12-31', 'YYYY-MM-DD');

-- BETWEEN text:
SELECT *
FROM employees
WHERE first_name BETWEEN 'A' AND 'C';

-- IN number:
SELECT *
FROM departments
WHERE location_id IN (1700, 2400, 1500);

-- IN text:
SELECT *
FROM job_history
WHERE job_id IN ('IT_PROG', 'ST_CLERK');

-- IN date:
SELECT *
FROM job_history
WHERE end_date IN (
  TO_DATE('2007-12-31', 'YYYY-MM-DD'),
  TO_DATE('2005-05-05', 'YYYY-MM-DD')
);

-- IS NULL:
SELECT *
FROM employees
WHERE commission_pct IS NULL;

-- IS NOT NULL:
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Забыть, что BETWEEN включает boundaries.
--
--    salary BETWEEN 4000 AND 10000
--
--    включает 4000 и 10000.
--
-- 2. Поставить high value перед low value.
--
--    Лучше:
--      salary BETWEEN 4000 AND 10000
--
-- 3. Писать text values в IN без single quotes.
--
--    Неправильно:
--      job_id IN (IT_PROG, ST_CLERK)
--
--    Правильно:
--      job_id IN ('IT_PROG', 'ST_CLERK')
--
-- 4. Ставить comma после последнего value в IN list.
--
--    Неправильно:
--      location_id IN (1700, 2400, 1500,)
--
--    Правильно:
--      location_id IN (1700, 2400, 1500)
--
-- 5. Проверять NULL через = NULL.
--
--    Неправильно:
--      commission_pct = NULL
--
--    Правильно:
--      commission_pct IS NULL
--
-- 6. Думать, что ISNULL - это Oracle syntax.
--
--    В Oracle operator пишется раздельно:
--      IS NULL


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Выведи first_name, last_name, salary
--   из employees,
--   где salary находится между 4000 и 10000.
--
-- Task 2:
--   Выведи rows из job_history,
--   где start_date находится между
--   01 January 2004 и 31 December 2006.
--   Используй TO_DATE.
--
-- Task 3:
--   Выведи employees,
--   где first_name находится между 'A' и 'C'.
--
-- Task 4:
--   Выведи departments,
--   где location_id находится в списке:
--     1700
--     2400
--     1500
--
-- Task 5:
--   Выведи rows из job_history,
--   где job_id находится в списке:
--     'IT_PROG'
--     'ST_CLERK'
--
-- Task 6:
--   Выведи rows из job_history,
--   где end_date равен одной из dates:
--     2007-12-31
--     2005-05-05
--
-- Task 7:
--   Выведи employees,
--   у которых commission_pct отсутствует.
--
-- Task 8:
--   Выведи employees,
--   у которых commission_pct заполнен.
--
-- Task 9:
--   Объясни своими словами:
--     чем BETWEEN отличается от IN;
--     почему NULL проверяется через IS NULL;
--     почему ISNULL не является правильной Oracle-записью.


-- ============================================================
-- Summary
-- ============================================================
-- BETWEEN:
--   проверяет диапазон;
--   включает lower boundary и upper boundary.
--
-- IN:
--   проверяет список возможных values;
--   values пишутся внутри parentheses через comma.
--
-- IS NULL:
--   проверяет отсутствие value.
--
-- IS NOT NULL:
--   проверяет наличие value.
--
-- Главное:
--   BETWEEN = value in range.
--   IN = value in list.
--   IS NULL = value is missing.
