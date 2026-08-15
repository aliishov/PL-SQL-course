-- Date functions
-- SYSDATE

SELECT  *
FROM nls_session_parameters 
WHERE parameter = 'NLS_DATE_FORMAT';

SELECT SYSDATE
FROM dual;

SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY hh24:mi:ss')
FROM dual;

SELECT SYSDATE - hire_date
FROM employees;

SELECT SYSDATE - 5
FROM dual;

SELECT SYSDATE + 5
FROM dual;

SELECT SYSDATE + 5.5
FROM dual;


-- ============================================================
-- Date functions
-- SYSDATE
-- ============================================================
-- SYSDATE       - date function.
--
-- Простыми словами:
--   SYSDATE возвращает current date and time
--   на стороне database server.
--
-- Result:
--   DATE
--
-- В Oracle DATE хранит:
--   year;
--   month;
--   day;
--   hour;
--   minute;
--   second.
--
-- Но на экране может отображаться не вся information.
-- Display зависит от NLS_DATE_FORMAT.
--
-- В этом уроке только SYSDATE.
-- Другие date functions будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- SYSDATE отвечает на вопрос:
--   "Какая дата и время сейчас у database server?"
--
-- Пример:
SELECT SYSDATE AS server_date_time
FROM dual;

-- Result example:
--   15-AUG-26
--
-- Или:
--   15-AUG-26 14:30:25
--
-- Что именно ты увидишь,
-- зависит от NLS_DATE_FORMAT в session.
--
-- Важно:
--   value внутри DATE содержит time,
--   даже если client показывает только date.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   SYSDATE
--
-- У SYSDATE нет arguments.
--
-- Correct:
SELECT SYSDATE
FROM dual;

-- Not correct:
-- SELECT SYSDATE()
-- FROM dual;
--
-- В Oracle SQL обычно пишут SYSDATE без parentheses.


-- ============================================================
-- Why FROM dual is used
-- ============================================================
-- Когда нужно просто посмотреть value,
-- можно использовать dual.
--
-- Пример:
SELECT SYSDATE
FROM dual;

-- Meaning:
--   вернуть current date and time
--   без обращения к business table.
--
-- dual - special one-row table.
-- Она удобна для examples and calculations.


-- ============================================================
-- Display format
-- ============================================================
-- SYSDATE возвращает DATE value.
--
-- Но то, как DATE показывается на экране,
-- зависит от session parameter NLS_DATE_FORMAT.
--
-- Пример из начала файла:
SELECT *
FROM nls_session_parameters
WHERE parameter = 'NLS_DATE_FORMAT';

-- Meaning:
--   показать current date display format
--   для этой session.
--
-- Если format не содержит time,
-- time part может не отображаться,
-- хотя внутри DATE он есть.


-- ============================================================
-- Show time part
-- ============================================================
-- Чтобы увидеть time part,
-- в начале файла есть такой example:
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY hh24:mi:ss') AS server_date_time
FROM dual;

-- Meaning:
--   показать SYSDATE в readable format
--   with day, month, year, hour, minute, second.
--
-- Важно:
--   здесь TO_CHAR используется только для display.
--   Полная тема TO_CHAR будет отдельным уроком.
--
-- Сам SYSDATE still returns DATE.


-- ============================================================
-- SYSDATE in SELECT list
-- ============================================================
-- SYSDATE можно использовать в SELECT list.
--
-- Пример:
SELECT employee_id,
       first_name,
       SYSDATE AS today
FROM employees;

-- Meaning:
--   для каждой row показать employee_id;
--   показать first_name;
--   рядом показать current database date and time.
--
-- SYSDATE будет одинаковым по смыслу:
--   current date/time на момент выполнения query.


-- ============================================================
-- SYSDATE and column values
-- ============================================================
-- SYSDATE часто сравнивают или вычисляют вместе с date columns.
--
-- В HR schema есть column:
--   hire_date
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       SYSDATE AS today
FROM employees;

-- Meaning:
--   показать employee hire date;
--   рядом показать current date.
--
-- Это удобно,
-- когда нужно видеть дату события
-- и current date in one result set.


-- ============================================================
-- Date minus date
-- ============================================================
-- Если вычесть одну DATE из другой DATE,
-- Oracle возвращает number of days.
--
-- Пример из начала файла:
SELECT SYSDATE - hire_date AS days_after_hire
FROM employees;

-- Meaning:
--   current date/time minus hire_date.
--
-- Result:
--   number of days between two dates.
--
-- Если result содержит decimal part,
-- это часть day.
--
-- Example idea:
--   1.5 days = 1 day and 12 hours.


-- ============================================================
-- Date plus number
-- ============================================================
-- В Oracle к DATE можно добавить number.
--
-- Number означает days.
--
-- Пример:
SELECT SYSDATE + 5 AS five_days_later
FROM dual;

-- Meaning:
--   current date/time plus 5 days.
--
-- Если сегодня 15-AUG-26,
-- result будет about 20-AUG-26
-- with same time part.


-- ============================================================
-- Date minus number
-- ============================================================
-- От DATE можно вычесть number.
--
-- Number тоже означает days.
--
-- Пример:
SELECT SYSDATE - 5 AS five_days_ago
FROM dual;

-- Meaning:
--   current date/time minus 5 days.
--
-- Если сегодня 15-AUG-26,
-- result будет about 10-AUG-26
-- with same time part.


-- ============================================================
-- Fractional days
-- ============================================================
-- Decimal number с DATE означает part of day.
--
-- Пример:
SELECT SYSDATE + 0.5 AS half_day_later
FROM dual;

-- Meaning:
--   add half of a day.
--
-- 0.5 day = 12 hours.
--
-- Пример из начала файла:
SELECT SYSDATE + 5.5 AS five_and_half_days_later
FROM dual;

-- Meaning:
--   add 5 days and 12 hours.


-- ============================================================
-- Smaller fractional examples
-- ============================================================
-- 1 day = 24 hours.
--
-- Therefore:
--   1 / 24 day = 1 hour.
--
-- Пример:
SELECT SYSDATE + (1 / 24) AS one_hour_later
FROM dual;

-- Meaning:
--   current date/time plus 1 hour.
--
-- 1 minute:
--   1 / (24 * 60)
--
-- Пример:
SELECT SYSDATE + (1 / (24 * 60)) AS one_minute_later
FROM dual;

-- Meaning:
--   current date/time plus 1 minute.


-- ============================================================
-- SYSDATE in WHERE
-- ============================================================
-- SYSDATE можно использовать в WHERE condition.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE hire_date < SYSDATE;

-- Meaning:
--   вернуть employees,
--   у которых hire_date раньше current date.
--
-- Для HR sample data это обычно true,
-- потому что hire_date находится в прошлом.


-- ============================================================
-- Find recent dates
-- ============================================================
-- Можно искать rows за последние N days.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE hire_date >= SYSDATE - 30;

-- Meaning:
--   current date minus 30 days;
--   вернуть rows,
--   где hire_date внутри последних 30 days.
--
-- В sample HR schema таких rows может не быть.
-- Но сам pattern важный.


-- ============================================================
-- Find future dates
-- ============================================================
-- Если column хранит future date,
-- SYSDATE можно использовать для проверки.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE hire_date > SYSDATE;

-- Meaning:
--   вернуть rows,
--   где hire_date later than current date.
--
-- Для обычного hire_date это странно,
-- но как учебный example показывает comparison with SYSDATE.


-- ============================================================
-- SYSDATE with arithmetic expression
-- ============================================================
-- SYSDATE можно использовать внутри expressions.
--
-- Пример:
SELECT first_name,
       SYSDATE - hire_date AS days_worked
FROM employees;

-- Meaning:
--   посчитать number of days
--   from hire_date to current date.
--
-- Result is NUMBER,
-- потому что DATE - DATE returns days.


-- ============================================================
-- Date value plus days in SELECT list
-- ============================================================
-- Можно добавлять days не только к SYSDATE,
-- но и к date column.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       hire_date + 90 AS after_90_days
FROM employees;

-- Meaning:
--   показать date через 90 days после hire_date.
--
-- Это calculation in result set.
-- Table employees не изменяется.


-- ============================================================
-- Date value minus days in SELECT list
-- ============================================================
-- Можно вычитать days из date column.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       hire_date - 7 AS week_before_hire
FROM employees;

-- Meaning:
--   показать date за 7 days до hire_date.
--
-- Это только calculated output.


-- ============================================================
-- SYSDATE and time precision
-- ============================================================
-- SYSDATE stores time up to seconds.
--
-- Пример:
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY hh24:mi:ss') AS server_date_time
FROM dual;

-- This displays:
--   day-month-year hour:minute:second
--
-- Но сам lesson здесь про SYSDATE.
-- Format models будут отдельной темой.


-- ============================================================
-- SYSDATE changes over time
-- ============================================================
-- SYSDATE is dynamic.
--
-- Это значит:
--   если выполнить query сейчас,
--   result будет one current date/time.
--
-- Если выполнить query позже,
-- result будет another current date/time.
--
-- Пример:
SELECT SYSDATE AS server_date_time
FROM dual;

-- Run this query twice at different moments,
-- and time part can be different.


-- ============================================================
-- Same query, same expression
-- ============================================================
-- В одном query можно использовать SYSDATE несколько раз.
--
-- Пример:
SELECT SYSDATE AS now_1,
       SYSDATE AS now_2,
       SYSDATE + 1 AS tomorrow_same_time
FROM dual;

-- Meaning:
--   now_1 and now_2 show current date/time;
--   tomorrow_same_time shows one day later.
--
-- Usually now_1 and now_2 look same in one result row.


-- ============================================================
-- Database server time
-- ============================================================
-- SYSDATE returns date and time
-- from database server operating system.
--
-- Это важно:
--   database server time может отличаться
--   от time на user computer.
--
-- Поэтому SYSDATE - это не "время на моем laptop",
-- а "время database server".


-- ============================================================
-- SYSDATE does not need a table column
-- ============================================================
-- SYSDATE можно вызвать без column.
--
-- Пример:
SELECT SYSDATE AS server_date_time
FROM dual;

-- Но можно и вместе с table columns:
SELECT employee_id,
       first_name,
       SYSDATE AS server_date_time
FROM employees;

-- Difference:
--   first query returns one row from dual;
--   second query returns rows from employees.


-- ============================================================
-- Difference between display and value
-- ============================================================
-- Важно различать:
--   actual DATE value;
--   how DATE is displayed.
--
-- Example:
--   actual DATE may contain:
--     15-AUG-26 14:30:25
--
-- But display may show only:
--     15-AUG-26
--
-- Это не значит,
-- что time part disappeared.
--
-- It means display format hides time part.


-- ============================================================
-- Using SYSDATE for age of row
-- ============================================================
-- SYSDATE помогает понять,
-- сколько days прошло после date column.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       SYSDATE - hire_date AS days_since_hire
FROM employees;

-- Meaning:
--   number of days from hire_date until now.
--
-- Result may include decimal part
-- because SYSDATE includes time.


-- ============================================================
-- Using SYSDATE for deadline check
-- ============================================================
-- Если есть date expression,
-- можно проверить, прошло ли N days.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE hire_date + 365 < SYSDATE;

-- Meaning:
--   hire_date plus 365 days;
--   compare with current date;
--   return rows where more than 365 days passed.


-- ============================================================
-- SYSDATE with NULL
-- ============================================================
-- Сам SYSDATE не возвращает NULL.
--
-- Но если expression uses NULL,
-- result может стать NULL.
--
-- Пример:
SELECT SYSDATE + NULL AS result_date
FROM dual;

-- Result:
--   NULL
--
-- Почему:
--   date plus NULL gives NULL.
--
-- Пример:
SELECT SYSDATE - NULL AS result_date
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- SYSDATE and aliases
-- ============================================================
-- Для SYSDATE expressions полезно давать alias.
--
-- Пример:
SELECT SYSDATE AS today,
       SYSDATE + 7 AS next_week,
       SYSDATE - 7 AS previous_week
FROM dual;

-- Aliases:
--   today
--   next_week
--   previous_week
--
-- С alias result set читать легче.


-- ============================================================
-- SYSDATE in calculated columns
-- ============================================================
-- Можно создать several calculated date columns.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       SYSDATE AS today,
       SYSDATE - hire_date AS days_after_hire,
       hire_date + 30 AS first_30_days_end
FROM employees;

-- Meaning:
--   today shows current date/time;
--   days_after_hire shows days between dates;
--   first_30_days_end shows hire_date plus 30 days.


-- ============================================================
-- Common use case: today in report
-- ============================================================
-- Частая задача:
--   показать report date.
--
-- Пример:
SELECT SYSDATE AS report_date
FROM dual;

-- Meaning:
--   report was generated at current database date/time.
--
-- Если нужен special visual format,
-- используется formatting.
-- Это отдельная тема.


-- ============================================================
-- Common use case: days since event
-- ============================================================
-- Еще одна частая задача:
--   показать, сколько days прошло с события.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       SYSDATE - hire_date AS days_since_event
FROM employees;

-- Meaning:
--   event date = hire_date;
--   current date = SYSDATE;
--   difference = days since event.


-- ============================================================
-- Common use case: date window
-- ============================================================
-- SYSDATE помогает строить moving date window.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE hire_date >= SYSDATE - 7;

-- Meaning:
--   rows from last 7 days.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE hire_date <= SYSDATE - 365;

-- Meaning:
--   rows where at least 365 days passed.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что SYSDATE возвращает только date.
--    Oracle DATE also stores time.
--
-- 2. Думать, что hidden time part does not exist.
--    Time part может быть скрыт by display format.
--
-- 3. Писать SYSDATE with parentheses.
--    In Oracle SQL use SYSDATE, not SYSDATE().
--
-- 4. Думать, что SYSDATE is client computer time.
--    SYSDATE comes from database server.
--
-- 5. Забывать, что DATE + number means days.
--    SYSDATE + 5 means plus 5 days.
--
-- 6. Забывать, что DATE - DATE returns number of days.
--    SYSDATE - hire_date gives days.
--
-- 7. Путать value and display.
--    NLS_DATE_FORMAT controls display, not the stored DATE logic.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Show current database date and time:
SELECT SYSDATE AS server_date_time
FROM dual;

-- 2. Show current NLS_DATE_FORMAT:
SELECT *
FROM nls_session_parameters
WHERE parameter = 'NLS_DATE_FORMAT';

-- 3. Show SYSDATE with visible time part:
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY hh24:mi:ss') AS server_date_time
FROM dual;

-- 4. Add 10 days:
SELECT SYSDATE + 10 AS ten_days_later
FROM dual;

-- 5. Subtract 10 days:
SELECT SYSDATE - 10 AS ten_days_ago
FROM dual;

-- 6. Add half day:
SELECT SYSDATE + 0.5 AS half_day_later
FROM dual;

-- 7. Calculate days since hire:
SELECT employee_id,
       first_name,
       hire_date,
       SYSDATE - hire_date AS days_since_hire
FROM employees;

-- 8. Find employees hired before current date:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE hire_date < SYSDATE;

-- 9. Show date 30 days after hire:
SELECT employee_id,
       first_name,
       hire_date,
       hire_date + 30 AS after_30_days
FROM employees;


-- ============================================================
-- Mini summary
-- ============================================================
-- SYSDATE returns current database server date and time.
--
-- Result type:
--   DATE
--
-- Important:
--   SYSDATE has no arguments;
--   SYSDATE includes time;
--   display depends on NLS_DATE_FORMAT;
--   DATE + number means add days;
--   DATE - number means subtract days;
--   DATE - DATE returns number of days;
--   fractional number means part of day;
--   SELECT with SYSDATE does not change table data.
