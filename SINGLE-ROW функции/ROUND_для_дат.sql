-- Date functions
-- ROUND(date, date precision format)

SELECT ROUND(SYSDATE)
FROM dual;

SELECT hire_date,
       ROUND(hire_date) rounded
FROM employees
WHERE employee_id IN(120, 121);

SELECT hire_date,
       ROUND(hire_date, 'CC') rounded
FROM employees
WHERE employee_id IN(120, 121);

SELECT hire_date,
       ROUND(hire_date, 'YYYY') rounded
FROM employees
WHERE employee_id IN(120, 121);

SELECT hire_date,
       ROUND(hire_date, 'Q') rounded
FROM employees
WHERE employee_id IN(120, 121);

SELECT hire_date,
       ROUND(hire_date, 'MM') rounded
FROM employees
WHERE employee_id IN(120, 121);

SELECT hire_date,
       ROUND(hire_date, 'MONTH') rounded
FROM employees
WHERE employee_id IN(120, 121);


-- ============================================================
-- Date functions
-- ROUND for dates
-- ============================================================
-- ROUND(date)   - single-row date function.
--
-- Простыми словами:
--   ROUND for dates округляет DATE
--   до указанной date unit.
--
-- Result:
--   DATE
--
-- Важно:
--   это не numeric ROUND.
--   Здесь ROUND работает with DATE values.
--
-- В этом уроке только ROUND for dates.
-- Другие date functions будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- ROUND(date) отвечает на вопрос:
--   "К какой ближайшей date unit нужно округлить эту date?"
--
-- Date unit может быть:
--   day;
--   month;
--   quarter;
--   year;
--   century.
--
-- Пример:
SELECT ROUND(DATE '2026-08-15', 'MM') AS rounded_date
FROM dual;

-- Result:
--   01-AUG-26
--
-- Почему:
--   15-AUG is before the month rounding border;
--   result is first day of current month.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   ROUND(date_value, format_model)
--
-- Где:
--   date_value     - DATE value;
--   format_model   - date unit for rounding.
--
-- format_model можно не писать:
--
--   ROUND(date_value)
--
-- Если format_model не указан,
-- Oracle uses default format model:
--   'DD'
--
-- То есть date округляется to nearest day.


-- ============================================================
-- ROUND date without format model
-- ============================================================
-- Пример из начала файла:
SELECT ROUND(SYSDATE) AS rounded_date
FROM dual;

-- Meaning:
--   округлить current database date/time
--   to nearest day.
--
-- Если time part before noon,
-- result is current day at midnight.
--
-- Если time part at noon or after noon,
-- result is next day at midnight.
--
-- Display может не показывать midnight,
-- because NLS_DATE_FORMAT controls visible format.


-- ============================================================
-- ROUND with fixed date
-- ============================================================
-- DATE literal has midnight time by default.
--
-- Пример:
SELECT ROUND(DATE '2026-08-15') AS rounded_date
FROM dual;

-- Result:
--   15-AUG-26
--
-- Почему:
--   time part is 00:00:00;
--   это already beginning of day.
--
-- Без format_model Oracle rounds to nearest day.


-- ============================================================
-- ROUND with employees hire_date
-- ============================================================
-- Пример из начала файла:
SELECT hire_date,
       ROUND(hire_date) AS rounded
FROM employees
WHERE employee_id IN(120, 121);

-- Meaning:
--   взять hire_date;
--   округлить до nearest day.
--
-- В HR sample data hire_date usually displays only date,
-- so result может выглядеть same as hire_date.
--
-- Но Oracle DATE can contain time.
-- If time exists, ROUND(date) can change day.


-- ============================================================
-- Format model
-- ============================================================
-- format_model tells Oracle:
--   to which date unit should the date be rounded.
--
-- In this lesson:
--   'DD'       - day, default;
--   'MM'       - month;
--   'MONTH'    - month;
--   'Q'        - quarter;
--   'YYYY'     - year;
--   'CC'       - century.
--
-- 'MM' and 'MONTH' are different names
-- for month rounding unit.


-- ============================================================
-- ROUND to month with MM
-- ============================================================
-- 'MM' rounds date to nearest month.
--
-- Rule:
--   day 1-15  -> first day of current month;
--   day 16+   -> first day of next month.
--
-- Пример:
SELECT ROUND(DATE '2026-08-15', 'MM') AS rounded_date
FROM dual;

-- Result:
--   01-AUG-26
--
-- Почему:
--   day = 15;
--   15 rounds down to current month.
--
-- Пример:
SELECT ROUND(DATE '2026-08-16', 'MM') AS rounded_date
FROM dual;

-- Result:
--   01-SEP-26
--
-- Почему:
--   day = 16;
--   16 rounds up to next month.


-- ============================================================
-- ROUND to month with MONTH
-- ============================================================
-- 'MONTH' also rounds date to nearest month.
--
-- Пример из начала файла:
SELECT hire_date,
       ROUND(hire_date, 'MONTH') AS rounded
FROM employees
WHERE employee_id IN(120, 121);

-- Meaning:
--   round hire_date to nearest month.
--
-- Пример:
SELECT ROUND(DATE '2026-04-10', 'MONTH') AS rounded_date
FROM dual;

-- Result:
--   01-APR-26
--
-- Пример:
SELECT ROUND(DATE '2026-04-20', 'MONTH') AS rounded_date
FROM dual;

-- Result:
--   01-MAY-26


-- ============================================================
-- MM and MONTH return same unit
-- ============================================================
-- 'MM' and 'MONTH' both mean month rounding.
--
-- Пример:
SELECT ROUND(DATE '2026-08-16', 'MM') AS rounded_mm,
       ROUND(DATE '2026-08-16', 'MONTH') AS rounded_month
FROM dual;

-- Both results:
--   01-SEP-26
--
-- Difference:
--   format_model text is different;
--   rounding unit is same.


-- ============================================================
-- ROUND to year with YYYY
-- ============================================================
-- 'YYYY' rounds date to nearest year.
--
-- Rule:
--   before July 1  -> January 1 of current year;
--   July 1 or later -> January 1 of next year.
--
-- Пример:
SELECT ROUND(DATE '2026-06-30', 'YYYY') AS rounded_date
FROM dual;

-- Result:
--   01-JAN-26
--
-- Почему:
--   June 30 is before July 1.
--
-- Пример:
SELECT ROUND(DATE '2026-07-01', 'YYYY') AS rounded_date
FROM dual;

-- Result:
--   01-JAN-27
--
-- Почему:
--   July 1 starts second half of year,
--   so result rounds up to next year.


-- ============================================================
-- ROUND hire_date to year
-- ============================================================
-- Пример из начала файла:
SELECT hire_date,
       ROUND(hire_date, 'YYYY') AS rounded
FROM employees
WHERE employee_id IN(120, 121);

-- Meaning:
--   round hire_date to nearest year.
--
-- If hire_date is before July 1,
-- result is January 1 of same year.
--
-- If hire_date is July 1 or later,
-- result is January 1 of next year.


-- ============================================================
-- ROUND to quarter with Q
-- ============================================================
-- 'Q' rounds date to nearest quarter.
--
-- Quarter months:
--   Q1 = January, February, March;
--   Q2 = April, May, June;
--   Q3 = July, August, September;
--   Q4 = October, November, December.
--
-- Rule:
--   rounds up on the 16th day
--   of the second month of the quarter.
--
-- Пример:
SELECT ROUND(DATE '2026-08-15', 'Q') AS rounded_date
FROM dual;

-- Result:
--   01-JUL-26
--
-- Почему:
--   August is second month of Q3;
--   day = 15;
--   before rounding border.
--
-- Пример:
SELECT ROUND(DATE '2026-08-16', 'Q') AS rounded_date
FROM dual;

-- Result:
--   01-OCT-26
--
-- Почему:
--   August 16 reaches rounding border;
--   result rounds up to next quarter.


-- ============================================================
-- ROUND hire_date to quarter
-- ============================================================
-- Пример из начала файла:
SELECT hire_date,
       ROUND(hire_date, 'Q') AS rounded
FROM employees
WHERE employee_id IN(120, 121);

-- Meaning:
--   round hire_date to nearest quarter.
--
-- Result will be first day of a quarter:
--   01-JAN;
--   01-APR;
--   01-JUL;
--   01-OCT.


-- ============================================================
-- Quarter examples
-- ============================================================
SELECT ROUND(DATE '2026-02-15', 'Q') AS rounded_date
FROM dual;

-- Result:
--   01-JAN-26
--
-- Q1 second month is February.
-- Day 15 rounds down.

SELECT ROUND(DATE '2026-02-16', 'Q') AS rounded_date
FROM dual;

-- Result:
--   01-APR-26
--
-- Q1 second month is February.
-- Day 16 rounds up to Q2.

SELECT ROUND(DATE '2026-05-16', 'Q') AS rounded_date
FROM dual;

-- Result:
--   01-JUL-26
--
-- Q2 second month is May.
-- Day 16 rounds up to Q3.


-- ============================================================
-- ROUND to century with CC
-- ============================================================
-- 'CC' rounds date to nearest century.
--
-- For beginner level:
--   CC is less common than MM, Q, YYYY.
--
-- But it is useful to know
-- that date ROUND can work with large date units too.


-- ============================================================
-- ROUND hire_date to century
-- ============================================================
-- Пример из начала файла:
SELECT hire_date,
       ROUND(hire_date, 'CC') AS rounded
FROM employees
WHERE employee_id IN(120, 121);

-- Meaning:
--   round hire_date to nearest century.
--
-- This is mostly for understanding format models.
-- In daily work, month/year rounding is more common.


-- ============================================================
-- ROUND returns first day of unit
-- ============================================================
-- When rounding to month, quarter, year, or century,
-- result is the beginning date of the rounded unit.
--
-- Examples:
--   ROUND(date, 'MM')   -> first day of month;
--   ROUND(date, 'Q')    -> first day of quarter;
--   ROUND(date, 'YYYY') -> January 1;
--   ROUND(date, 'CC')   -> first day of century.
--
-- This is why results often show day = 01.


-- ============================================================
-- ROUND in SELECT list
-- ============================================================
-- ROUND for dates можно использовать in SELECT list.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       ROUND(hire_date, 'MM') AS rounded_hire_month
FROM employees;

-- Meaning:
--   show original hire_date;
--   show hire_date rounded to nearest month.
--
-- Table employees не изменяется.
-- Result is calculated output.


-- ============================================================
-- ROUND with alias
-- ============================================================
-- Для expression лучше давать alias.
--
-- Пример:
SELECT ROUND(DATE '2026-08-16', 'MM') AS rounded_month
FROM dual;

-- Alias:
--   rounded_month
--
-- Без alias output column может называться длинно:
--   ROUND(DATE'2026-08-16','MM')
--
-- С alias result set читать легче.


-- ============================================================
-- ROUND in WHERE
-- ============================================================
-- ROUND for dates можно использовать in WHERE condition.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE ROUND(hire_date, 'YYYY') = DATE '2007-01-01';

-- Meaning:
--   round hire_date to nearest year;
--   return rows where rounded year is 2007.
--
-- Важно:
--   function in WHERE applies to rows.
--   В больших tables это может влиять на performance.
--   Детали performance будут отдельной темой.


-- ============================================================
-- Compare rounded month
-- ============================================================
-- Можно сравнивать rounded month with fixed DATE.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE ROUND(hire_date, 'MM') = DATE '2007-06-01';

-- Meaning:
--   hire_date rounded to nearest month
--   equals June 1, 2007.
--
-- Это не то же самое,
-- что "hire_date is in June".
--
-- Because dates after the 15th
-- can round to next month.


-- ============================================================
-- Important difference from finding month
-- ============================================================
-- ROUND(date, 'MM') is about nearest month.
--
-- It is not simply "take month start".
--
-- Пример:
SELECT ROUND(DATE '2026-08-15', 'MM') AS day_15,
       ROUND(DATE '2026-08-16', 'MM') AS day_16
FROM dual;

-- Results:
--   day_15 = 01-AUG-26
--   day_16 = 01-SEP-26
--
-- Border is day 16.


-- ============================================================
-- Date literals
-- ============================================================
-- Для fixed examples удобно использовать DATE literal.
--
-- Syntax:
--   DATE 'YYYY-MM-DD'
--
-- Пример:
SELECT ROUND(DATE '2026-08-16', 'MONTH') AS rounded_date
FROM dual;

-- Result:
--   01-SEP-26
--
-- DATE literal does not depend on NLS_DATE_FORMAT.


-- ============================================================
-- String date values
-- ============================================================
-- ROUND can receive values
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
-- ROUND returns DATE.
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
-- ROUND date and NULL
-- ============================================================
-- Если date_value is NULL,
-- result будет NULL.
--
-- Пример:
SELECT ROUND(NULL, 'MM') AS rounded_date
FROM dual;

-- Result:
--   NULL
--
-- Если format_model is NULL,
-- result тоже будет NULL.
--
-- Пример:
SELECT ROUND(DATE '2026-08-15', NULL) AS rounded_date
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- ROUND date does not change table data
-- ============================================================
-- SELECT with ROUND(date) показывает calculated result.
--
-- Пример:
SELECT hire_date AS original_hire_date,
       ROUND(hire_date, 'MM') AS rounded_hire_month
FROM employees;

-- original_hire_date показывает value из table.
-- rounded_hire_month показывает calculated value.
--
-- Table employees не изменяется.


-- ============================================================
-- Common use case: rounded report month
-- ============================================================
-- Иногда нужно показать nearest reporting month.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       ROUND(hire_date, 'MM') AS report_month
FROM employees;

-- Meaning:
--   if hire_date is day 1-15,
--   report_month is current month start.
--
-- If hire_date is day 16+,
-- report_month is next month start.


-- ============================================================
-- Common use case: rounded quarter
-- ============================================================
-- Можно получить nearest quarter start.
--
-- Пример:
SELECT employee_id,
       hire_date,
       ROUND(hire_date, 'Q') AS report_quarter
FROM employees;

-- Meaning:
--   report_quarter is first day of nearest quarter.


-- ============================================================
-- Common use case: rounded year
-- ============================================================
-- Можно получить nearest year start.
--
-- Пример:
SELECT employee_id,
       hire_date,
       ROUND(hire_date, 'YYYY') AS report_year
FROM employees;

-- Meaning:
--   dates before July 1 go to current January 1;
--   dates from July 1 go to next January 1.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что this is numeric ROUND.
--    Здесь ROUND works with DATE values.
--
-- 2. Думать, что ROUND(date, 'MM') always returns current month.
--    From day 16 it returns next month.
--
-- 3. Думать, что ROUND(date, 'YYYY') changes only year number.
--    It returns January 1 of rounded year.
--
-- 4. Забывать that ROUND(date) without format rounds to nearest day.
--    Time part can affect result.
--
-- 5. Использовать string dates без понимания NLS_DATE_FORMAT.
--    DATE literal is clearer for examples.
--
-- 6. Думать, что SELECT with ROUND changes table data.
--    It only returns calculated result set.
--
-- 7. Путать rounding with simply getting a period boundary.
--    ROUND chooses nearest unit using its border rules.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Round fixed date to nearest day:
SELECT ROUND(DATE '2026-08-15') AS result
FROM dual;

-- 2. Round day 15 to month:
SELECT ROUND(DATE '2026-08-15', 'MM') AS result
FROM dual;

-- 3. Round day 16 to month:
SELECT ROUND(DATE '2026-08-16', 'MM') AS result
FROM dual;

-- 4. Round before July 1 to year:
SELECT ROUND(DATE '2026-06-30', 'YYYY') AS result
FROM dual;

-- 5. Round July 1 to year:
SELECT ROUND(DATE '2026-07-01', 'YYYY') AS result
FROM dual;

-- 6. Round quarter before border:
SELECT ROUND(DATE '2026-08-15', 'Q') AS result
FROM dual;

-- 7. Round quarter after border:
SELECT ROUND(DATE '2026-08-16', 'Q') AS result
FROM dual;

-- 8. Use employees hire_date:
SELECT employee_id,
       first_name,
       hire_date,
       ROUND(hire_date, 'MM') AS rounded_month
FROM employees;

-- 9. Use selected employees from the first examples:
SELECT hire_date,
       ROUND(hire_date, 'YYYY') AS rounded_year,
       ROUND(hire_date, 'Q') AS rounded_quarter,
       ROUND(hire_date, 'MM') AS rounded_month
FROM employees
WHERE employee_id IN(120, 121);


-- ============================================================
-- Mini summary
-- ============================================================
-- ROUND for dates rounds DATE values to a date unit.
--
-- Syntax:
--   ROUND(date_value, format_model)
--
-- Short syntax:
--   ROUND(date_value)
--
-- Important:
--   result type is DATE;
--   omitted format_model means nearest day;
--   'MM' and 'MONTH' round to nearest month;
--   month rounds up from day 16;
--   'Q' rounds to nearest quarter;
--   quarter rounds up from day 16 of second quarter month;
--   'YYYY' rounds to nearest year;
--   year rounds up from July 1;
--   'CC' rounds to nearest century;
--   SELECT with ROUND(date) does not change table data.
