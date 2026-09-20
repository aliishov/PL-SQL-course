-- ============================================================
-- Conversion functions
-- TO_CHAR for dates
-- ============================================================
-- TO_CHAR(date) - single-row conversion function.
--
-- Простыми словами:
--   TO_CHAR для dates берет DATE value
--   и возвращает text по указанному format mask.
--
-- Result:
--   VARCHAR2
--
-- Важно:
--   DATE value внутри table не меняется;
--   меняется только то, как value показывается в result set.
--
-- В этом уроке только TO_CHAR for DATE values.
-- TO_CHAR for numbers уже отдельная тема.
-- Other conversion functions будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- TO_CHAR(date) отвечает на вопрос:
--   "Как показать date как text в нужном виде?"
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'DD-MM-YYYY') AS result
FROM dual;

-- Result:
--   20-09-2026
--
-- Почему:
--   DD   = day of month;
--   MM   = month number;
--   YYYY = four-digit year.
--
-- Hyphens are just text separators.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   TO_CHAR(date_value, format_mask, nls_parameters)
--
-- Где:
--   date_value       - DATE value;
--   format_mask      - how date should be displayed;
--   nls_parameters   - optional language settings.
--
-- Short syntax:
--
--   TO_CHAR(date_value)
--
-- If format_mask is omitted,
-- Oracle uses session default date format.


-- ============================================================
-- TO_CHAR without format mask
-- ============================================================
-- Если format mask не указан,
-- Oracle uses default session date format.
--
-- Пример:
SELECT TO_CHAR(SYSDATE) AS result
FROM dual;

-- Result depends on NLS_DATE_FORMAT.
--
-- Чтобы посмотреть default date format:
SELECT parameter,
       value
FROM nls_session_parameters
WHERE parameter = 'NLS_DATE_FORMAT';


-- ============================================================
-- Use DATE value, not random text
-- ============================================================
-- TO_CHAR for dates is meant for DATE values.
--
-- В начале файла есть пример:
SELECT TO_CHAR('20-SEP-01') AS result
FROM dual;

-- Такой пример relies on implicit conversion.
--
-- Для учебного и стабильного кода лучше использовать DATE literal:
SELECT TO_CHAR(DATE '2001-09-20') AS result
FROM dual;

-- DATE literal:
--   DATE 'YYYY-MM-DD'
--
-- It does not depend on NLS_DATE_FORMAT.


-- ============================================================
-- DATE value and text output
-- ============================================================
-- DATE and formatted text are different things.
--
-- Пример:
SELECT SYSDATE AS original_date,
       TO_CHAR(SYSDATE, 'DD-MM-YYYY') AS formatted_date
FROM dual;

-- original_date is DATE.
-- formatted_date is VARCHAR2.
--
-- TO_CHAR does not change original DATE value.


-- ============================================================
-- Year format elements
-- ============================================================
-- Year format elements:
--
--   Y      - last 1 digit of year;
--   YY     - last 2 digits of year;
--   YYY    - last 3 digits of year;
--   YYYY   - 4-digit year;
--   RR     - 2-digit year with special century logic;
--   YEAR   - year written as words.
--
-- These elements return text.


-- ============================================================
-- Y, YY, YYY, YYYY
-- ============================================================
SELECT TO_CHAR(DATE '2026-09-20', 'Y') AS result
FROM dual;

-- Result:
--   6

SELECT TO_CHAR(DATE '2026-09-20', 'YY') AS result
FROM dual;

-- Result:
--   26

SELECT TO_CHAR(DATE '2026-09-20', 'YYY') AS result
FROM dual;

-- Result:
--   026

SELECT TO_CHAR(DATE '2026-09-20', 'YYYY') AS result
FROM dual;

-- Result:
--   2026
--
-- Usually YYYY is the clearest year format.


-- ============================================================
-- RR
-- ============================================================
-- RR returns last 2 digits of year.
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'RR') AS result
FROM dual;

-- Result:
--   26
--
-- RR is important mostly when converting text to date.
-- In this TO_CHAR lesson, remember:
--   RR displays 2 digits.


-- ============================================================
-- YEAR
-- ============================================================
-- YEAR writes year as words.
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'YEAR') AS result
FROM dual;

-- Result:
--   TWENTY TWENTY-SIX
--
-- Capitalization follows format element:
SELECT TO_CHAR(DATE '2026-09-20', 'YEAR') AS upper_year,
       TO_CHAR(DATE '2026-09-20', 'Year') AS title_year,
       TO_CHAR(DATE '2026-09-20', 'year') AS lower_year
FROM dual;


-- ============================================================
-- Month format elements
-- ============================================================
-- Month format elements:
--
--   MM      - month number;
--   MON     - short month name;
--   MONTH   - full month name.
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'MM') AS result
FROM dual;

-- Result:
--   09


-- ============================================================
-- MON
-- ============================================================
-- MON returns short month name.
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'MON') AS result
FROM dual;

-- Result in English session:
--   SEP
--
-- Capitalization follows format element:
SELECT TO_CHAR(DATE '2026-09-20', 'MON') AS upper_mon,
       TO_CHAR(DATE '2026-09-20', 'Mon') AS title_mon,
       TO_CHAR(DATE '2026-09-20', 'mon') AS lower_mon
FROM dual;


-- ============================================================
-- MONTH
-- ============================================================
-- MONTH returns full month name.
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'MONTH') AS result
FROM dual;

-- Result in English session:
--   SEPTEMBER
--
-- MONTH can be padded with spaces.
--
-- Cleaner variant:
SELECT TO_CHAR(DATE '2026-09-20', 'FMMONTH') AS result
FROM dual;

-- FM removes padding.


-- ============================================================
-- NLS_DATE_LANGUAGE
-- ============================================================
-- Month and day names depend on date language.
--
-- Пример из начала файла:
SELECT e.hire_date,
       TO_CHAR(e.hire_date, 'Month', 'NLS_DATE_LANGUAGE = RUSSIAN') AS russian_month
FROM employees e;

-- Meaning:
--   show month name using Russian date language.
--
-- English example:
SELECT TO_CHAR(DATE '2026-09-20',
               'Month',
               'NLS_DATE_LANGUAGE = English') AS result
FROM dual;

-- Result:
--   September


-- ============================================================
-- FM with MONTH
-- ============================================================
-- Without FM, MONTH can add extra spaces.
--
-- Пример из начала файла:
SELECT e.hire_date,
       TO_CHAR(e.hire_date, 'Month') || 'hello' AS month_text
FROM employees e;

-- Result can have spaces before hello.
--
-- With FM:
SELECT e.hire_date,
       TO_CHAR(e.hire_date, 'fmMonth') || 'hello' AS month_text
FROM employees e;

-- Result is cleaner:
--   Septemberhello
--
-- FM = fill mode.
-- It removes padding.


-- ============================================================
-- Filter by month name
-- ============================================================
-- Пример из начала файла:
SELECT e.first_name,
       e.hire_date
FROM employees e
WHERE TO_CHAR(e.hire_date, 'fmMonth') = 'August';

-- Meaning:
--   convert hire_date month name to text;
--   compare with text 'August'.
--
-- Важно:
--   comparison is text comparison.
--   Month language and capitalization matter.


-- ============================================================
-- Day format elements
-- ============================================================
-- Day format elements:
--
--   D      - day of week number;
--   DD     - day of month;
--   DDD    - day of year;
--   DY     - short day name;
--   DAY    - full day name.


-- ============================================================
-- D
-- ============================================================
-- D returns day of week number.
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'D') AS result
FROM dual;

-- Result depends on NLS_TERRITORY.
--
-- In some territories week starts on Sunday.
-- In others week starts on Monday.
--
-- So D is territory-sensitive.


-- ============================================================
-- DD
-- ============================================================
-- DD returns day of month.
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'DD') AS result
FROM dual;

-- Result:
--   20


-- ============================================================
-- DDD
-- ============================================================
-- DDD returns day of year.
--
-- Пример:
SELECT TO_CHAR(DATE '2026-01-01', 'DDD') AS result
FROM dual;

-- Result:
--   001
--
-- Пример:
SELECT TO_CHAR(DATE '2026-12-31', 'DDD') AS result
FROM dual;

-- Result:
--   365


-- ============================================================
-- DY
-- ============================================================
-- DY returns short day name.
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'DY') AS result
FROM dual;

-- Result in English session:
--   SUN
--
-- Capitalization follows format element:
SELECT TO_CHAR(DATE '2026-09-20', 'DY') AS upper_dy,
       TO_CHAR(DATE '2026-09-20', 'Dy') AS title_dy,
       TO_CHAR(DATE '2026-09-20', 'dy') AS lower_dy
FROM dual;


-- ============================================================
-- DAY
-- ============================================================
-- DAY returns full day name.
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'DAY') AS result
FROM dual;

-- Result in English session:
--   SUNDAY
--
-- DAY can be padded with spaces.
--
-- Cleaner:
SELECT TO_CHAR(DATE '2026-09-20', 'FMDAY') AS result
FROM dual;

-- Result:
--   SUNDAY


-- ============================================================
-- W and WW
-- ============================================================
-- W returns week of month.
-- WW returns week of year.
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'W') AS week_of_month
FROM dual;

-- Result:
--   3
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'WW') AS week_of_year
FROM dual;

-- Result:
--   depends on week position inside year.


-- ============================================================
-- Q and CC
-- ============================================================
-- Q returns quarter.
-- CC returns century.
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'Q') AS quarter_number
FROM dual;

-- Result:
--   3
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'CC') AS century_number
FROM dual;

-- Result:
--   21


-- ============================================================
-- Time format elements
-- ============================================================
-- Common time elements:
--
--   AM      - AM/PM marker;
--   P.M.    - P.M. style marker;
--   HH      - hour 01-12;
--   HH24    - hour 00-23;
--   MI      - minute;
--   SS      - second;
--   SSSSS   - seconds after midnight.


-- ============================================================
-- AM and P.M.
-- ============================================================
SELECT TO_CHAR(SYSDATE, 'AM') AS result
FROM dual;

SELECT TO_CHAR(SYSDATE, 'P.M.') AS result
FROM dual;

-- These show meridian marker for current time.


-- ============================================================
-- HH and HH24
-- ============================================================
-- HH is 12-hour format.
-- HH24 is 24-hour format.
--
-- Пример:
SELECT TO_CHAR(SYSDATE, 'HH') AS hour_12,
       TO_CHAR(SYSDATE, 'HH24') AS hour_24
FROM dual;

-- If current time is 18:30:
--   HH   = 06
--   HH24 = 18


-- ============================================================
-- MI and SS
-- ============================================================
-- MI means minutes.
-- SS means seconds.
--
-- Пример:
SELECT TO_CHAR(SYSDATE, 'MI') AS minutes_text,
       TO_CHAR(SYSDATE, 'SS') AS seconds_text
FROM dual;

-- Common mistake:
--   MM is month.
--   MI is minute.


-- ============================================================
-- SSSSS
-- ============================================================
-- SSSSS returns seconds after midnight.
--
-- Пример:
SELECT TO_CHAR(SYSDATE, 'SSSSS') AS seconds_after_midnight
FROM dual;

-- Result:
--   number of seconds since 00:00:00.


-- ============================================================
-- Date and time together
-- ============================================================
-- You can combine date and time elements.
--
-- Пример:
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY HH24:MI:SS') AS result
FROM dual;

-- Result example:
--   20-09-2026 18:45:09


-- ============================================================
-- Punctuation and text
-- ============================================================
-- Punctuation appears exactly as written.
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'DD/MM/YYYY') AS result
FROM dual;

-- Result:
--   20/09/2026
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'DD.MM.YYYY') AS result
FROM dual;

-- Result:
--   20.09.2026


-- ============================================================
-- Text in double quotes
-- ============================================================
-- Text inside double quotes is copied to output.
--
-- Пример из начала файла:
SELECT TO_CHAR(SYSDATE, '"Quarter" Q "of" year') AS result
FROM dual;

-- Result example:
--   Quarter 3 of twenty twenty-six
--
-- Another example:
SELECT TO_CHAR(DATE '2026-09-20', '"Date:" DD-MM-YYYY') AS result
FROM dual;

-- Result:
--   Date: 20-09-2026


-- ============================================================
-- TH, SP and THSP
-- ============================================================
-- TH adds ordinal suffix.
-- SP spells number.
-- THSP combines both ideas.
--
-- Пример:
SELECT TO_CHAR(DATE '2026-09-20', 'DDth "of" Month') AS result
FROM dual;

-- Result idea:
--   20th of September
--
-- Пример:
SELECT TO_CHAR(SYSDATE, 'yyyysp mmsp ssssssp') AS result
FROM dual;

-- This spells selected numeric date/time parts.
--
-- Пример:
SELECT TO_CHAR(SYSDATE, 'MIthsp') AS result
FROM dual;

-- This shows minutes as ordinal words.


-- ============================================================
-- Complex sentence with concatenation
-- ============================================================
-- TO_CHAR date output can be part of a sentence.
--
-- Пример из начала файла:
SELECT 'My colleague with ID = ' || e.employee_id || ' and job_id = ' || e.job_id ||
       ' joined us on ' || TO_CHAR(e.hire_date, 'fmDay "the "ddTH "of "fmMonth YYYY') AS sentence
FROM employees e;

-- Meaning:
--   employee data is concatenated with formatted hire_date.
--
-- FM removes padding from Day and Month.


-- ============================================================
-- TO_CHAR with employee dates
-- ============================================================
-- TO_CHAR often used with date columns.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.hire_date,
       TO_CHAR(e.hire_date, 'DD-MON-YYYY') AS hire_date_text
FROM employees e;

-- Meaning:
--   hire_date is original DATE value;
--   hire_date_text is formatted text.


-- ============================================================
-- TO_CHAR in SELECT list
-- ============================================================
-- TO_CHAR(date) usually appears in SELECT list
-- when output should have fixed readable format.
--
-- Пример:
SELECT e.employee_id,
       TO_CHAR(e.hire_date, 'YYYY-MM-DD') AS hire_date_iso_style
FROM employees e;

-- Result is text.
-- Good for reports.


-- ============================================================
-- TO_CHAR with alias
-- ============================================================
-- Для expression лучше давать alias.
--
-- Пример:
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY') AS today_text
FROM dual;

-- Alias:
--   today_text
--
-- С alias result set читать легче.


-- ============================================================
-- TO_CHAR in WHERE
-- ============================================================
-- TO_CHAR(date) можно использовать in WHERE condition.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE TO_CHAR(e.hire_date, 'YYYY') = '2007';

-- Meaning:
--   convert hire_date year to text;
--   compare with text '2007'.
--
-- Важно:
--   function in WHERE applies to rows.
--   В больших tables это может влиять on performance.


-- ============================================================
-- Filter by month number
-- ============================================================
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE TO_CHAR(e.hire_date, 'MM') = '08';

-- Meaning:
--   find employees where hire month number is 08.


-- ============================================================
-- Filter by day name
-- ============================================================
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE TO_CHAR(e.hire_date, 'DY', 'NLS_DATE_LANGUAGE = English') = 'MON';

-- Meaning:
--   find employees hired on Monday.
--
-- NLS_DATE_LANGUAGE is specified
-- to make 'MON' stable in English.


-- ============================================================
-- Check NLS settings
-- ============================================================
-- Session settings affect default display
-- and language of names.
--
-- Пример:
SELECT parameter,
       value
FROM nls_session_parameters
WHERE parameter IN ('NLS_DATE_FORMAT', 'NLS_DATE_LANGUAGE', 'NLS_TERRITORY');

-- Useful:
--   NLS_DATE_FORMAT controls default date display;
--   NLS_DATE_LANGUAGE controls month/day names;
--   NLS_TERRITORY can affect D format element.


-- ============================================================
-- TO_CHAR and NULL
-- ============================================================
-- Если date value is NULL,
-- result будет NULL.
--
-- Пример:
SELECT TO_CHAR(NULL, 'DD-MM-YYYY') AS result
FROM dual;

-- Result:
--   NULL
--
-- Если format mask is NULL,
-- result тоже будет NULL.
--
-- Пример:
SELECT TO_CHAR(SYSDATE, NULL) AS result
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- TO_CHAR does not change table data
-- ============================================================
-- SELECT with TO_CHAR shows converted output.
--
-- Пример:
SELECT e.hire_date AS original_hire_date,
       TO_CHAR(e.hire_date, 'DD-MM-YYYY') AS hire_date_text
FROM employees e;

-- original_hire_date is DATE value.
-- hire_date_text is formatted text.
--
-- Table employees не изменяется.


-- ============================================================
-- Common scenarios
-- ============================================================
-- 1. Show report date:
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY HH24:MI:SS') AS report_date
FROM dual;

-- 2. Show hire month:
SELECT e.employee_id,
       TO_CHAR(e.hire_date, 'fmMonth YYYY') AS hire_month
FROM employees e;

-- 3. Show year and quarter:
SELECT e.employee_id,
       TO_CHAR(e.hire_date, 'YYYY') AS hire_year,
       TO_CHAR(e.hire_date, 'Q') AS hire_quarter
FROM employees e;

-- 4. Show weekday:
SELECT e.employee_id,
       TO_CHAR(e.hire_date, 'fmDay', 'NLS_DATE_LANGUAGE = English') AS hire_weekday
FROM employees e;


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что TO_CHAR changes DATE column.
--    Нет, it only returns text in result set.
--
-- 2. Думать, что TO_CHAR returns DATE.
--    Нет, TO_CHAR returns VARCHAR2.
--
-- 3. Путать MM and MI.
--    MM means month.
--    MI means minute.
--
-- 4. Забывать HH24 for 24-hour time.
--    HH is 12-hour format.
--
-- 5. Не использовать FM with MONTH or DAY.
--    Output can contain padding spaces.
--
-- 6. Забывать NLS_DATE_LANGUAGE.
--    Month and day names depend on language.
--
-- 7. Использовать implicit string-to-date conversion.
--    DATE literal is clearer for examples.
--
-- 8. Использовать formatted text for date logic.
--    For date calculations, keep DATE values as DATE.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Show current date with default format:
SELECT TO_CHAR(SYSDATE) AS result
FROM dual;

-- 2. Show current date as DD-MM-YYYY:
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY') AS result
FROM dual;

-- 3. Show current date and time:
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY HH24:MI:SS') AS result
FROM dual;

-- 4. Show month name:
SELECT TO_CHAR(DATE '2026-09-20', 'fmMonth') AS result
FROM dual;

-- 5. Show day name:
SELECT TO_CHAR(DATE '2026-09-20', 'fmDay') AS result
FROM dual;

-- 6. Show quarter:
SELECT TO_CHAR(DATE '2026-09-20', 'Q') AS result
FROM dual;

-- 7. Show seconds after midnight:
SELECT TO_CHAR(SYSDATE, 'SSSSS') AS result
FROM dual;

-- 8. Format employees hire_date:
SELECT e.employee_id,
       e.first_name,
       e.hire_date,
       TO_CHAR(e.hire_date, 'DD-MON-YYYY') AS hire_date_text
FROM employees e;

-- 9. Find employees hired in August:
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE TO_CHAR(e.hire_date, 'fmMonth') = 'August';

-- 10. Make readable sentence:
SELECT 'Employee ' || e.first_name ||
       ' was hired on ' ||
       TO_CHAR(e.hire_date, 'fmDay, ddTH "of" fmMonth YYYY') AS sentence
FROM employees e;


-- ============================================================
-- Mini summary
-- ============================================================
-- TO_CHAR for dates converts DATE value to formatted text.
--
-- Syntax:
--   TO_CHAR(date_value, format_mask, nls_parameters)
--
-- Short syntax:
--   TO_CHAR(date_value)
--
-- Important:
--   result type is VARCHAR2;
--   format mask controls output text;
--   Y, YY, YYY, YYYY show year parts;
--   MON and MONTH show month names;
--   D, DD, DDD, DY, DAY show day information;
--   W and WW show week information;
--   Q shows quarter;
--   HH, HH24, MI, SS, SSSSS show time information;
--   FM removes padding;
--   quoted text is copied to output;
--   NLS_DATE_LANGUAGE controls month and day names;
--   SELECT with TO_CHAR does not change table data.
