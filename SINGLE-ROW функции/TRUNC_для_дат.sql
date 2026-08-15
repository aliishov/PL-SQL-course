-- Date functions
-- TRUNC(date, date precision format)

SELECT TRUNC(SYSDATE)
FROM dual;

SELECT hire_date,
       TRUNC(hire_date) trunced
FROM employees
WHERE employee_id IN(120, 121);

SELECT hire_date,
       TRUNC(hire_date, 'CC') trunced
FROM employees
WHERE employee_id IN(120, 121);

SELECT hire_date,
       TRUNC(hire_date, 'YYYY') trunced
FROM employees
WHERE employee_id IN(120, 121);

SELECT hire_date,
       TRUNC(hire_date, 'Q') trunced
FROM employees
WHERE employee_id IN(120, 121);

SELECT hire_date,
       TRUNC(hire_date, 'MM') trunced
FROM employees
WHERE employee_id IN(120, 121);

SELECT hire_date,
       TRUNC(hire_date, 'MONTH') trunced
FROM employees
WHERE employee_id IN(120, 121);


-- ============================================================
-- Date functions
-- TRUNC for dates
-- ============================================================
-- TRUNC(date)   - single-row date function.
--
-- Простыми словами:
--   TRUNC for dates обрезает DATE
--   до начала указанной date unit.
--
-- Result:
--   DATE
--
-- Важно:
--   это не numeric TRUNC.
--   Здесь TRUNC работает with DATE values.
--
-- В этом уроке только TRUNC for dates.
-- Другие date functions будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- TRUNC(date) отвечает на вопрос:
--   "Где начинается эта date unit?"
--
-- Date unit может быть:
--   day;
--   month;
--   quarter;
--   year;
--   century.
--
-- Пример:
SELECT TRUNC(DATE '2026-08-15', 'MM') AS truncated_date
FROM dual;

-- Result:
--   01-AUG-26
--
-- Почему:
--   source date is inside August 2026;
--   beginning of that month is 01-AUG-2026.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   TRUNC(date_value, format_model)
--
-- Где:
--   date_value     - DATE value;
--   format_model   - date unit for truncation.
--
-- format_model можно не писать:
--
--   TRUNC(date_value)
--
-- Если format_model не указан,
-- Oracle uses default format model:
--   'DD'
--
-- То есть DATE обрезается до day
-- with time set to midnight.


-- ============================================================
-- TRUNC date without format model
-- ============================================================
-- Пример из начала файла:
SELECT TRUNC(SYSDATE) AS truncated_date
FROM dual;

-- Meaning:
--   взять current database date/time;
--   убрать time part;
--   оставить date at midnight.
--
-- If SYSDATE is:
--   15-AUG-26 14:30:25
--
-- TRUNC(SYSDATE) gives:
--   15-AUG-26 00:00:00
--
-- Display may not show time,
-- because NLS_DATE_FORMAT controls visible format.


-- ============================================================
-- TRUNC with fixed date
-- ============================================================
-- DATE literal has midnight time by default.
--
-- Пример:
SELECT TRUNC(DATE '2026-08-15') AS truncated_date
FROM dual;

-- Result:
--   15-AUG-26
--
-- Почему:
--   format_model omitted;
--   default unit = day;
--   date literal already has midnight time.


-- ============================================================
-- TRUNC with employees hire_date
-- ============================================================
-- Пример из начала файла:
SELECT hire_date,
       TRUNC(hire_date) AS trunced
FROM employees
WHERE employee_id IN(120, 121);

-- Meaning:
--   take hire_date;
--   cut it to day;
--   time part becomes midnight.
--
-- В HR sample data hire_date usually displays only date,
-- so result may look same as hire_date.
--
-- But Oracle DATE can contain time.


-- ============================================================
-- Format model
-- ============================================================
-- format_model tells Oracle:
--   to which date unit should the date be truncated.
--
-- In this lesson:
--   'DD'       - day, default;
--   'MM'       - month;
--   'MONTH'    - month;
--   'Q'        - quarter;
--   'YYYY'     - year;
--   'CC'       - century.
--
-- TRUNC does not choose nearest unit.
-- It returns beginning of the current unit.


-- ============================================================
-- TRUNC to day
-- ============================================================
-- 'DD' cuts time part and keeps same calendar day.
--
-- Пример:
SELECT TRUNC(SYSDATE, 'DD') AS truncated_day
FROM dual;

-- Meaning:
--   current date with time set to midnight.
--
-- This is the same main idea as:
SELECT TRUNC(SYSDATE) AS truncated_day
FROM dual;

-- Because omitted format_model means 'DD'.


-- ============================================================
-- TRUNC to month with MM
-- ============================================================
-- 'MM' returns first day of the month.
--
-- Пример:
SELECT TRUNC(DATE '2026-08-15', 'MM') AS truncated_month
FROM dual;

-- Result:
--   01-AUG-26
--
-- Пример:
SELECT TRUNC(DATE '2026-08-31', 'MM') AS truncated_month
FROM dual;

-- Result:
--   01-AUG-26
--
-- Почему:
--   both dates are inside August 2026;
--   beginning of August is 01-AUG-26.


-- ============================================================
-- TRUNC to month with MONTH
-- ============================================================
-- 'MONTH' also returns first day of the month.
--
-- Пример из начала файла:
SELECT hire_date,
       TRUNC(hire_date, 'MONTH') AS trunced
FROM employees
WHERE employee_id IN(120, 121);

-- Meaning:
--   truncate hire_date to month.
--
-- Пример:
SELECT TRUNC(DATE '2026-04-10', 'MONTH') AS truncated_month
FROM dual;

-- Result:
--   01-APR-26
--
-- Пример:
SELECT TRUNC(DATE '2026-04-30', 'MONTH') AS truncated_month
FROM dual;

-- Result:
--   01-APR-26


-- ============================================================
-- MM and MONTH return same unit
-- ============================================================
-- 'MM' and 'MONTH' both mean month truncation.
--
-- Пример:
SELECT TRUNC(DATE '2026-08-16', 'MM') AS trunc_mm,
       TRUNC(DATE '2026-08-16', 'MONTH') AS trunc_month
FROM dual;

-- Both results:
--   01-AUG-26
--
-- Difference:
--   format_model text is different;
--   truncation unit is same.


-- ============================================================
-- TRUNC to year with YYYY
-- ============================================================
-- 'YYYY' returns January 1 of the same year.
--
-- Пример:
SELECT TRUNC(DATE '2026-06-30', 'YYYY') AS truncated_year
FROM dual;

-- Result:
--   01-JAN-26
--
-- Пример:
SELECT TRUNC(DATE '2026-12-31', 'YYYY') AS truncated_year
FROM dual;

-- Result:
--   01-JAN-26
--
-- Почему:
--   both dates are inside year 2026;
--   beginning of year 2026 is 01-JAN-26.


-- ============================================================
-- TRUNC hire_date to year
-- ============================================================
-- Пример из начала файла:
SELECT hire_date,
       TRUNC(hire_date, 'YYYY') AS trunced
FROM employees
WHERE employee_id IN(120, 121);

-- Meaning:
--   truncate hire_date to beginning of its year.
--
-- Result will be January 1
-- of the same year as hire_date.


-- ============================================================
-- TRUNC to quarter with Q
-- ============================================================
-- 'Q' returns first day of the quarter.
--
-- Quarter months:
--   Q1 = January, February, March;
--   Q2 = April, May, June;
--   Q3 = July, August, September;
--   Q4 = October, November, December.
--
-- Пример:
SELECT TRUNC(DATE '2026-08-15', 'Q') AS truncated_quarter
FROM dual;

-- Result:
--   01-JUL-26
--
-- Почему:
--   August is inside Q3;
--   beginning of Q3 is July 1.
--
-- Пример:
SELECT TRUNC(DATE '2026-12-31', 'Q') AS truncated_quarter
FROM dual;

-- Result:
--   01-OCT-26
--
-- December is inside Q4.
-- Beginning of Q4 is October 1.


-- ============================================================
-- TRUNC hire_date to quarter
-- ============================================================
-- Пример из начала файла:
SELECT hire_date,
       TRUNC(hire_date, 'Q') AS trunced
FROM employees
WHERE employee_id IN(120, 121);

-- Meaning:
--   truncate hire_date to beginning of quarter.
--
-- Possible results:
--   01-JAN;
--   01-APR;
--   01-JUL;
--   01-OCT.


-- ============================================================
-- Quarter examples
-- ============================================================
SELECT TRUNC(DATE '2026-02-15', 'Q') AS truncated_quarter
FROM dual;

-- Result:
--   01-JAN-26

SELECT TRUNC(DATE '2026-05-16', 'Q') AS truncated_quarter
FROM dual;

-- Result:
--   01-APR-26

SELECT TRUNC(DATE '2026-09-30', 'Q') AS truncated_quarter
FROM dual;

-- Result:
--   01-JUL-26

SELECT TRUNC(DATE '2026-11-20', 'Q') AS truncated_quarter
FROM dual;

-- Result:
--   01-OCT-26


-- ============================================================
-- TRUNC to century with CC
-- ============================================================
-- 'CC' returns beginning of the century unit.
--
-- For beginner level:
--   CC is less common than MM, Q, YYYY.
--
-- But it is useful to know
-- that date TRUNC can work with large date units too.
--
-- Пример из начала файла:
SELECT hire_date,
       TRUNC(hire_date, 'CC') AS trunced
FROM employees
WHERE employee_id IN(120, 121);

-- Meaning:
--   truncate hire_date to beginning of its century unit.
--
-- This is mostly for understanding format models.
-- In daily work, month/year truncation is more common.


-- ============================================================
-- TRUNC returns beginning of unit
-- ============================================================
-- When truncating to month, quarter, year, or century,
-- result is the beginning date of that unit.
--
-- Examples:
--   TRUNC(date, 'MM')   -> first day of month;
--   TRUNC(date, 'Q')    -> first day of quarter;
--   TRUNC(date, 'YYYY') -> January 1;
--   TRUNC(date, 'CC')   -> first day of century unit.
--
-- This is why results often show day = 01.


-- ============================================================
-- TRUNC does not round to nearest unit
-- ============================================================
-- TRUNC always moves to the beginning
-- of the current date unit.
--
-- Пример:
SELECT TRUNC(DATE '2026-08-15', 'MM') AS day_15,
       TRUNC(DATE '2026-08-16', 'MM') AS day_16,
       TRUNC(DATE '2026-08-31', 'MM') AS day_31
FROM dual;

-- All results:
--   01-AUG-26
--
-- Почему:
--   all dates are inside August 2026.
--   Month truncation returns beginning of August.


-- ============================================================
-- TRUNC in SELECT list
-- ============================================================
-- TRUNC for dates можно использовать in SELECT list.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       TRUNC(hire_date, 'MM') AS hire_month_start
FROM employees;

-- Meaning:
--   show original hire_date;
--   show beginning of hire_date month.
--
-- Table employees не изменяется.
-- Result is calculated output.


-- ============================================================
-- TRUNC with alias
-- ============================================================
-- Для expression лучше давать alias.
--
-- Пример:
SELECT TRUNC(DATE '2026-08-16', 'MM') AS month_start
FROM dual;

-- Alias:
--   month_start
--
-- Без alias output column может называться длинно:
--   TRUNC(DATE'2026-08-16','MM')
--
-- С alias result set читать легче.


-- ============================================================
-- TRUNC in WHERE
-- ============================================================
-- TRUNC for dates можно использовать in WHERE condition.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE TRUNC(hire_date, 'YYYY') = DATE '2007-01-01';

-- Meaning:
--   truncate hire_date to beginning of year;
--   return rows where that year start is 01-JAN-2007.
--
-- In other words:
--   hire_date is inside year 2007.
--
-- Важно:
--   function in WHERE applies to rows.
--   В больших tables это может влиять на performance.
--   Детали performance будут отдельной темой.


-- ============================================================
-- Find rows in month
-- ============================================================
-- TRUNC(date, 'MM') часто используют,
-- чтобы сравнивать dates by month.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE TRUNC(hire_date, 'MM') = DATE '2007-06-01';

-- Meaning:
--   hire_date is inside June 2007.
--
-- Because every date in June 2007
-- has same TRUNC(hire_date, 'MM'):
--   01-JUN-2007


-- ============================================================
-- Find rows in quarter
-- ============================================================
-- TRUNC(date, 'Q') can identify quarter start.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE TRUNC(hire_date, 'Q') = DATE '2007-04-01';

-- Meaning:
--   hire_date is inside Q2 of 2007.
--
-- Q2 start:
--   01-APR-2007


-- ============================================================
-- Date literals
-- ============================================================
-- Для fixed examples удобно использовать DATE literal.
--
-- Syntax:
--   DATE 'YYYY-MM-DD'
--
-- Пример:
SELECT TRUNC(DATE '2026-08-16', 'MONTH') AS truncated_date
FROM dual;

-- Result:
--   01-AUG-26
--
-- DATE literal does not depend on NLS_DATE_FORMAT.


-- ============================================================
-- String date values
-- ============================================================
-- TRUNC can receive values
-- that Oracle can convert to DATE.
--
-- But string date values depend on session date format.
--
-- Example:
--   '15-AUG-26'
--
-- It may work if current session format accepts it.
--
-- Clearer beginner examples use:
--   DATE '2026-08-15'


-- ============================================================
-- DATE display format
-- ============================================================
-- TRUNC returns DATE.
--
-- How DATE is displayed depends on NLS_DATE_FORMAT.
--
-- Пример:
SELECT parameter,
       value
FROM sys.nls_session_parameters
WHERE parameter = 'NLS_DATE_FORMAT';

-- Meaning:
--   check current session date display format.
--
-- Same DATE value can be displayed differently
-- in different sessions.


-- ============================================================
-- Gregorian calendar rule
-- ============================================================
-- Oracle documentation says:
--   TRUNC(date) works according to Gregorian calendar rules.
--
-- It is not sensitive to NLS_CALENDAR.
--
-- For beginner level:
--   default examples use normal Gregorian calendar behavior.


-- ============================================================
-- TRUNC date and NULL
-- ============================================================
-- Если date_value is NULL,
-- result будет NULL.
--
-- Пример:
SELECT TRUNC(NULL, 'MM') AS truncated_date
FROM dual;

-- Result:
--   NULL
--
-- Если format_model is NULL,
-- result тоже будет NULL.
--
-- Пример:
SELECT TRUNC(DATE '2026-08-15', NULL) AS truncated_date
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- TRUNC date does not change table data
-- ============================================================
-- SELECT with TRUNC(date) показывает calculated result.
--
-- Пример:
SELECT hire_date AS original_hire_date,
       TRUNC(hire_date, 'MM') AS hire_month_start
FROM employees;

-- original_hire_date показывает value из table.
-- hire_month_start показывает calculated value.
--
-- Table employees не изменяется.


-- ============================================================
-- Common use case: remove time part
-- ============================================================
-- Частая задача:
--   compare DATE values by day,
--   ignoring time part.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       TRUNC(hire_date) AS hire_day
FROM employees;

-- Meaning:
--   hire_day is hire_date with time set to midnight.


-- ============================================================
-- Common use case: month start
-- ============================================================
-- Частая задача:
--   show beginning of month.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       TRUNC(hire_date, 'MM') AS hire_month_start
FROM employees;

-- Meaning:
--   hire_month_start is first day of hire month.


-- ============================================================
-- Common use case: report quarter
-- ============================================================
-- Можно получить quarter start for report.
--
-- Пример:
SELECT employee_id,
       hire_date,
       TRUNC(hire_date, 'Q') AS report_quarter_start
FROM employees;

-- Meaning:
--   report_quarter_start is first day of hire quarter.


-- ============================================================
-- Common use case: report year
-- ============================================================
-- Можно получить year start for report.
--
-- Пример:
SELECT employee_id,
       hire_date,
       TRUNC(hire_date, 'YYYY') AS report_year_start
FROM employees;

-- Meaning:
--   report_year_start is January 1 of hire year.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что this is numeric TRUNC.
--    Здесь TRUNC works with DATE values.
--
-- 2. Думать, что TRUNC(date, 'MM') returns current day.
--    It returns first day of current month.
--
-- 3. Думать, что TRUNC(date, 'YYYY') changes only year number.
--    It returns January 1 of the same year.
--
-- 4. Забывать that TRUNC(date) without format uses 'DD'.
--    It removes time part to midnight.
--
-- 5. Использовать string dates без понимания NLS_DATE_FORMAT.
--    DATE literal is clearer for examples.
--
-- 6. Думать, что SELECT with TRUNC changes table data.
--    It only returns calculated result set.
--
-- 7. Путать truncation with choosing nearest period.
--    TRUNC returns beginning of current unit.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Truncate current database date to day:
SELECT TRUNC(SYSDATE) AS result
FROM dual;

-- 2. Truncate fixed date to month:
SELECT TRUNC(DATE '2026-08-15', 'MM') AS result
FROM dual;

-- 3. Truncate end of month to month:
SELECT TRUNC(DATE '2026-08-31', 'MM') AS result
FROM dual;

-- 4. Truncate fixed date to year:
SELECT TRUNC(DATE '2026-12-31', 'YYYY') AS result
FROM dual;

-- 5. Truncate fixed date to quarter:
SELECT TRUNC(DATE '2026-08-15', 'Q') AS result
FROM dual;

-- 6. Compare MM and MONTH:
SELECT TRUNC(DATE '2026-08-15', 'MM') AS result_mm,
       TRUNC(DATE '2026-08-15', 'MONTH') AS result_month
FROM dual;

-- 7. Use employees hire_date:
SELECT employee_id,
       first_name,
       hire_date,
       TRUNC(hire_date, 'MM') AS hire_month_start
FROM employees;

-- 8. Use selected employees from the first examples:
SELECT hire_date,
       TRUNC(hire_date, 'YYYY') AS year_start,
       TRUNC(hire_date, 'Q') AS quarter_start,
       TRUNC(hire_date, 'MM') AS month_start
FROM employees
WHERE employee_id IN(120, 121);

-- 9. Find rows inside one month:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE TRUNC(hire_date, 'MM') = DATE '2007-06-01';


-- ============================================================
-- Mini summary
-- ============================================================
-- TRUNC for dates cuts DATE values to beginning of a date unit.
--
-- Syntax:
--   TRUNC(date_value, format_model)
--
-- Short syntax:
--   TRUNC(date_value)
--
-- Important:
--   result type is DATE;
--   omitted format_model means day;
--   TRUNC(date) removes time part to midnight;
--   'MM' and 'MONTH' return first day of month;
--   'Q' returns first day of quarter;
--   'YYYY' returns January 1 of same year;
--   'CC' returns beginning of century unit;
--   TRUNC(date) uses Gregorian calendar rules;
--   SELECT with TRUNC(date) does not change table data.
