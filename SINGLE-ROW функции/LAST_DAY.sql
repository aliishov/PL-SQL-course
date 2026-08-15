-- Date functions
-- LAST_DAY(date)

SELECT LAST_DAY(SYSDATE)
FROM dual;

SELECT LAST_DAY('1-FEB-2028')
FROM dual;

SELECT hire_date,
       LAST_DAY(hire_date) - hire_date worked
FROM employees;


-- ============================================================
-- Date functions
-- LAST_DAY
-- ============================================================
-- LAST_DAY      - single-row date function.
--
-- Простыми словами:
--   LAST_DAY возвращает last day of the month
--   для указанной date.
--
-- Result:
--   DATE
--
-- Важно:
--   LAST_DAY возвращает не number,
--   а DATE value.
--
-- В этом уроке только LAST_DAY.
-- Другие date functions будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- LAST_DAY отвечает на вопрос:
--   "Какой последний день месяца у этой date?"
--
-- Пример:
SELECT LAST_DAY(DATE '2026-08-15') AS month_end
FROM dual;

-- Result:
--   31-AUG-26
--
-- Почему:
--   source date is inside August 2026;
--   last day of August is August 31.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   LAST_DAY(date_value)
--
-- Где:
--   date_value - DATE или value,
--                который Oracle can convert to DATE.
--
-- LAST_DAY has one argument.
--
-- Correct:
SELECT LAST_DAY(DATE '2026-08-15') AS month_end
FROM dual;

-- Not correct:
-- SELECT LAST_DAY()
-- FROM dual;
--
-- Not correct:
-- SELECT LAST_DAY(DATE '2026-08-15', 1)
-- FROM dual;


-- ============================================================
-- LAST_DAY with SYSDATE
-- ============================================================
-- SYSDATE возвращает current database date and time.
--
-- Пример из начала файла:
SELECT LAST_DAY(SYSDATE) AS current_month_end
FROM dual;

-- Meaning:
--   найти last day of current month.
--
-- Result depends on current database date.
--
-- If current date is in August,
-- LAST_DAY(SYSDATE) returns last day of August.


-- ============================================================
-- Fixed date examples
-- ============================================================
-- Для fixed examples удобно использовать DATE literal.
--
-- Syntax:
--   DATE 'YYYY-MM-DD'
--
-- Пример:
SELECT LAST_DAY(DATE '2026-01-10') AS month_end
FROM dual;

-- Result:
--   31-JAN-26
--
-- Пример:
SELECT LAST_DAY(DATE '2026-04-10') AS month_end
FROM dual;

-- Result:
--   30-APR-26
--
-- Пример:
SELECT LAST_DAY(DATE '2026-12-10') AS month_end
FROM dual;

-- Result:
--   31-DEC-26


-- ============================================================
-- The day inside month does not matter
-- ============================================================
-- Любая date внутри одного month
-- даст same last day of that month.
--
-- Пример:
SELECT LAST_DAY(DATE '2026-08-01') AS month_end
FROM dual;

-- Result:
--   31-AUG-26
--
-- Пример:
SELECT LAST_DAY(DATE '2026-08-15') AS month_end
FROM dual;

-- Result:
--   31-AUG-26
--
-- Пример:
SELECT LAST_DAY(DATE '2026-08-31') AS month_end
FROM dual;

-- Result:
--   31-AUG-26
--
-- Почему:
--   all these dates are inside August 2026.


-- ============================================================
-- If source date is already last day
-- ============================================================
-- Если source date already is last day of month,
-- LAST_DAY returns same date.
--
-- Пример:
SELECT LAST_DAY(DATE '2026-08-31') AS month_end
FROM dual;

-- Result:
--   31-AUG-26
--
-- Ничего дальше не сдвигается.
-- Function просто возвращает last day of that month.


-- ============================================================
-- Months with 30 days
-- ============================================================
-- Некоторые months have 30 days.
--
-- Пример:
SELECT LAST_DAY(DATE '2026-04-01') AS month_end
FROM dual;

-- Result:
--   30-APR-26
--
-- Пример:
SELECT LAST_DAY(DATE '2026-06-20') AS month_end
FROM dual;

-- Result:
--   30-JUN-26
--
-- Пример:
SELECT LAST_DAY(DATE '2026-09-10') AS month_end
FROM dual;

-- Result:
--   30-SEP-26
--
-- Пример:
SELECT LAST_DAY(DATE '2026-11-25') AS month_end
FROM dual;

-- Result:
--   30-NOV-26


-- ============================================================
-- Months with 31 days
-- ============================================================
-- Некоторые months have 31 days.
--
-- Пример:
SELECT LAST_DAY(DATE '2026-01-10') AS month_end
FROM dual;

-- Result:
--   31-JAN-26
--
-- Пример:
SELECT LAST_DAY(DATE '2026-03-10') AS month_end
FROM dual;

-- Result:
--   31-MAR-26
--
-- Пример:
SELECT LAST_DAY(DATE '2026-07-10') AS month_end
FROM dual;

-- Result:
--   31-JUL-26
--
-- Пример:
SELECT LAST_DAY(DATE '2026-10-10') AS month_end
FROM dual;

-- Result:
--   31-OCT-26


-- ============================================================
-- February in common year
-- ============================================================
-- February может иметь 28 days.
--
-- Пример:
SELECT LAST_DAY(DATE '2026-02-01') AS month_end
FROM dual;

-- Result:
--   28-FEB-26
--
-- Почему:
--   2026 is not leap year;
--   February has 28 days.


-- ============================================================
-- February in leap year
-- ============================================================
-- February может иметь 29 days in leap year.
--
-- Пример из начала файла:
SELECT LAST_DAY('1-FEB-2028') AS month_end
FROM dual;

-- Possible result:
--   29-FEB-28
--
-- Почему:
--   2028 is leap year;
--   February 2028 has 29 days.
--
-- Более ясный учебный вариант:
SELECT LAST_DAY(DATE '2028-02-01') AS month_end
FROM dual;

-- Result:
--   29-FEB-28


-- ============================================================
-- String date values
-- ============================================================
-- В начале файла есть string date example:
--
--   '1-FEB-2028'
--
-- Oracle может convert this string to DATE,
-- если format подходит current session.
--
-- Пример:
SELECT LAST_DAY('1-FEB-2028') AS month_end
FROM dual;

-- Важно:
--   if session date format is different,
--   string conversion can fail or work differently.
--
-- Для reliable examples лучше использовать DATE literal:
SELECT LAST_DAY(DATE '2028-02-01') AS month_end
FROM dual;


-- ============================================================
-- LAST_DAY with columns
-- ============================================================
-- LAST_DAY можно использовать with date columns.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       LAST_DAY(hire_date) AS hire_month_end
FROM employees;

-- Meaning:
--   для каждой row взять hire_date;
--   найти last day of that hire month.
--
-- Table employees не изменяется.
-- Result is calculated output.


-- ============================================================
-- LAST_DAY in SELECT list
-- ============================================================
-- LAST_DAY часто используют in SELECT list.
--
-- Пример:
SELECT employee_id,
       hire_date,
       LAST_DAY(hire_date) AS month_end
FROM employees;

-- Meaning:
--   show original hire_date;
--   show last day of hire_date month.


-- ============================================================
-- LAST_DAY with alias
-- ============================================================
-- Для expression лучше давать alias.
--
-- Пример:
SELECT LAST_DAY(DATE '2026-08-15') AS month_end
FROM dual;

-- Alias:
--   month_end
--
-- Без alias output column может называться длинно:
--   LAST_DAY(DATE'2026-08-15')
--
-- С alias result set читать легче.


-- ============================================================
-- Days left in month
-- ============================================================
-- LAST_DAY можно использовать,
-- чтобы посчитать days until end of month.
--
-- Date minus date returns number of days.
--
-- Пример:
SELECT LAST_DAY(DATE '2026-08-15') - DATE '2026-08-15' AS days_left
FROM dual;

-- Result:
--   16
--
-- Почему:
--   last day of August 2026 is 31-AUG-26;
--   31 - 15 = 16 days.


-- ============================================================
-- Days from hire date to end of month
-- ============================================================
-- Пример из начала файла:
SELECT hire_date,
       LAST_DAY(hire_date) - hire_date AS days_until_month_end
FROM employees;

-- Meaning:
--   last day of hire_date month;
--   minus hire_date;
--   result is number of days left in that month.
--
-- If hire_date = 15-AUG-26:
--   LAST_DAY(hire_date) = 31-AUG-26
--   difference = 16


-- ============================================================
-- LAST_DAY with SYSDATE difference
-- ============================================================
-- Можно посчитать,
-- сколько days left in current month.
--
-- Пример:
SELECT SYSDATE AS today,
       LAST_DAY(SYSDATE) AS current_month_end,
       LAST_DAY(SYSDATE) - SYSDATE AS days_left
FROM dual;

-- Meaning:
--   current_month_end = last day of current month;
--   days_left = difference between current date and month end.
--
-- Result may include decimal part
-- because Oracle DATE can contain time.


-- ============================================================
-- Time part
-- ============================================================
-- Oracle DATE contains time:
--   hour;
--   minute;
--   second.
--
-- LAST_DAY returns DATE.
--
-- In practice, LAST_DAY keeps the time part
-- from the input DATE and changes day to month end.
--
-- Example idea:
--   source date:
--     15-AUG-26 14:30:25
--
--   LAST_DAY(source date):
--     31-AUG-26 14:30:25
--
-- Display may hide time part,
-- depending on NLS_DATE_FORMAT.


-- ============================================================
-- NLS_CALENDAR
-- ============================================================
-- Oracle defines last day of month
-- according to session parameter NLS_CALENDAR.
--
-- Usually beginner examples use default Gregorian calendar.
--
-- Чтобы посмотреть NLS settings:
SELECT parameter,
       value
FROM sys.nls_session_parameters
WHERE parameter IN ('NLS_CALENDAR', 'NLS_DATE_FORMAT', 'NLS_DATE_LANGUAGE');

-- Meaning:
--   NLS_CALENDAR controls calendar rules;
--   NLS_DATE_FORMAT controls how DATE is displayed;
--   NLS_DATE_LANGUAGE affects month names in string dates.


-- ============================================================
-- LAST_DAY in WHERE
-- ============================================================
-- LAST_DAY можно использовать in WHERE condition.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE LAST_DAY(hire_date) = DATE '2006-02-28';

-- Meaning:
--   find employees whose hire_date month
--   ends on 28-FEB-2006.
--
-- In other words:
--   hire_date is inside February 2006.
--
-- Важно:
--   function in WHERE applies to rows.
--   В больших tables это может влиять на performance.
--   Детали performance будут отдельной темой.


-- ============================================================
-- Compare with current month end
-- ============================================================
-- Можно сравнить date column
-- with last day of current month.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE LAST_DAY(hire_date) = LAST_DAY(SYSDATE);

-- Meaning:
--   return rows where hire_date is in same month
--   as current database date.
--
-- For old HR sample data,
-- this may return no rows.
-- Pattern itself is useful.


-- ============================================================
-- Find rows in a fixed month
-- ============================================================
-- LAST_DAY can identify month by its ending date.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE LAST_DAY(hire_date) = DATE '2007-06-30';

-- Meaning:
--   hire_date is inside June 2007.
--
-- Because every date in June 2007
-- has same LAST_DAY:
--   30-JUN-2007


-- ============================================================
-- Month end for report date
-- ============================================================
-- Common use:
--   show current report month end.
--
-- Пример:
SELECT SYSDATE AS report_date,
       LAST_DAY(SYSDATE) AS report_month_end
FROM dual;

-- Meaning:
--   report_date = current database date;
--   report_month_end = last day of current month.


-- ============================================================
-- Last day after calculated date
-- ============================================================
-- LAST_DAY can be applied to a date expression.
--
-- Пример:
SELECT LAST_DAY(SYSDATE + 10) AS month_end_after_10_days
FROM dual;

-- Meaning:
--   first calculate SYSDATE + 10 days;
--   then find last day of that calculated date's month.
--
-- If SYSDATE + 10 is still in same month,
-- result is current month end.
--
-- If it moves to next month,
-- result is next month end.


-- ============================================================
-- First day of next month idea
-- ============================================================
-- If LAST_DAY returns month end,
-- then month end plus 1 day gives first day of next month.
--
-- Пример:
SELECT LAST_DAY(DATE '2026-08-15') + 1 AS first_day_next_month
FROM dual;

-- Result:
--   01-SEP-26
--
-- Почему:
--   last day of August is 31-AUG-26;
--   plus 1 day = 01-SEP-26.


-- ============================================================
-- LAST_DAY and NULL
-- ============================================================
-- Если date_value is NULL,
-- result будет NULL.
--
-- Пример:
SELECT LAST_DAY(NULL) AS month_end
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- LAST_DAY returns DATE, not day number
-- ============================================================
-- LAST_DAY returns full DATE value.
--
-- Пример:
SELECT LAST_DAY(DATE '2026-08-15') AS month_end
FROM dual;

-- Result:
--   31-AUG-26
--
-- This is DATE value.
-- It is not just number 31.
--
-- You can use it in date arithmetic:
SELECT LAST_DAY(DATE '2026-08-15') - DATE '2026-08-01' AS day_difference
FROM dual;

-- Result:
--   30


-- ============================================================
-- LAST_DAY does not change table data
-- ============================================================
-- SELECT with LAST_DAY показывает calculated result.
--
-- Пример:
SELECT hire_date AS original_hire_date,
       LAST_DAY(hire_date) AS hire_month_end
FROM employees;

-- original_hire_date показывает value из table.
-- hire_month_end показывает calculated value.
--
-- Table employees не изменяется.


-- ============================================================
-- Common use case: month end column
-- ============================================================
-- Частая задача:
--   рядом с date показать month end.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       LAST_DAY(hire_date) AS hire_month_end
FROM employees;

-- Meaning:
--   helpful for reports where month end matters.


-- ============================================================
-- Common use case: days remaining
-- ============================================================
-- Еще одна частая задача:
--   посчитать days remaining until end of month.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       LAST_DAY(hire_date) - hire_date AS days_remaining_in_hire_month
FROM employees;

-- Meaning:
--   how many days from hire_date to month end.


-- ============================================================
-- Common use case: current month end
-- ============================================================
-- Для current month:
SELECT LAST_DAY(SYSDATE) AS current_month_end
FROM dual;

-- Meaning:
--   last day of the month that contains current database date.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что LAST_DAY returns NUMBER.
--    Нет, LAST_DAY returns DATE.
--
-- 2. Думать, что LAST_DAY returns only day number.
--    Нет, it returns full date of month end.
--
-- 3. Использовать string dates без понимания NLS_DATE_FORMAT.
--    DATE literal is clearer for examples.
--
-- 4. Забывать, что Oracle DATE can contain time.
--    LAST_DAY returns DATE, and time part can matter in comparisons.
--
-- 5. Думать, что every February has 28 days.
--    Leap years have February 29.
--
-- 6. Думать, что SELECT with LAST_DAY changes table data.
--    It only returns calculated result set.
--
-- 7. Забывать, что calendar rules can depend on NLS_CALENDAR.
--    Default examples usually use Gregorian calendar.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Find last day of current month:
SELECT LAST_DAY(SYSDATE) AS result
FROM dual;

-- 2. Find last day of August 2026:
SELECT LAST_DAY(DATE '2026-08-15') AS result
FROM dual;

-- 3. Find last day of April 2026:
SELECT LAST_DAY(DATE '2026-04-10') AS result
FROM dual;

-- 4. Check February in common year:
SELECT LAST_DAY(DATE '2026-02-01') AS result
FROM dual;

-- 5. Check February in leap year:
SELECT LAST_DAY(DATE '2028-02-01') AS result
FROM dual;

-- 6. Calculate days left in fixed month:
SELECT LAST_DAY(DATE '2026-08-15') - DATE '2026-08-15' AS result
FROM dual;

-- 7. Use employees hire_date:
SELECT employee_id,
       first_name,
       hire_date,
       LAST_DAY(hire_date) AS hire_month_end
FROM employees;

-- 8. Calculate days until month end for hire_date:
SELECT employee_id,
       hire_date,
       LAST_DAY(hire_date) - hire_date AS days_until_month_end
FROM employees;

-- 9. Check NLS settings:
SELECT parameter,
       value
FROM sys.nls_session_parameters
WHERE parameter IN ('NLS_CALENDAR', 'NLS_DATE_FORMAT', 'NLS_DATE_LANGUAGE');


-- ============================================================
-- Mini summary
-- ============================================================
-- LAST_DAY returns last day of the month that contains date_value.
--
-- Syntax:
--   LAST_DAY(date_value)
--
-- Important:
--   result type is DATE;
--   LAST_DAY returns full date, not just day number;
--   every date inside same month has same LAST_DAY result;
--   February can end on 28 or 29 depending on year;
--   string date values depend on session date format;
--   last day definition depends on NLS_CALENDAR;
--   DATE values can contain time;
--   SELECT with LAST_DAY does not change table data.
