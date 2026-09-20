-- ============================================================
-- Conversion functions
-- TO_DATE
-- ============================================================
-- TO_DATE(text) - single-row conversion function.
--
-- Простыми словами:
--   TO_DATE converts text value to DATE value.
--
-- Result:
--   DATE
--
-- Важно:
--   TO_DATE does not format date for output.
--   It creates DATE value from text.
--
-- В этом уроке только TO_DATE.
-- TO_CHAR for dates and TO_CHAR for numbers уже отдельные темы.
-- Other conversion functions будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- TO_DATE отвечает на вопрос:
--   "Как превратить text into real DATE?"
--
-- Пример:
SELECT TO_DATE('20-09-2026', 'DD-MM-YYYY') AS result
FROM dual;

-- Result is DATE.
--
-- Как именно result будет показан на экране,
-- зависит от NLS_DATE_FORMAT in current session.
--
-- Поэтому для проверки удобно temporarily show DATE через TO_CHAR:
SELECT TO_CHAR(TO_DATE('20-09-2026', 'DD-MM-YYYY'), 'DD-MON-YYYY') AS result
FROM dual;

-- Result:
--   20-SEP-2026


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   TO_DATE(char_value, format_mask, nls_parameters)
--
-- Где:
--   char_value       - text that contains date;
--   format_mask      - how this text is written;
--   nls_parameters   - optional language settings.
--
-- Short syntax:
--
--   TO_DATE(char_value)
--
-- But short syntax depends on session settings.
-- For learning and real code, use explicit format_mask.


-- ============================================================
-- Text and format mask must match
-- ============================================================
-- Format mask describes the text, not the desired output.
--
-- Text:
--   '20-09-2026'
--
-- Correct mask:
--   'DD-MM-YYYY'
--
-- Пример:
SELECT TO_DATE('20-09-2026', 'DD-MM-YYYY') AS result
FROM dual;

-- Почему:
--   20   matches DD;
--   09   matches MM;
--   2026 matches YYYY.


-- ============================================================
-- Different text, different mask
-- ============================================================
-- If text is written differently,
-- format mask must also be different.
--
-- Пример:
SELECT TO_DATE('2026/09/20', 'YYYY/MM/DD') AS result
FROM dual;

-- Another example:
SELECT TO_DATE('20.SEP.2026', 'DD.MON.YYYY') AS result
FROM dual;

-- Separators usually must match the text.
-- If text has dots, mask should have dots.
-- If text has slashes, mask should have slashes.


-- ============================================================
-- DATE is not text
-- ============================================================
-- TO_DATE returns DATE.
-- DATE can be compared, filtered, stored and used in date logic.
--
-- Пример:
SELECT TO_DATE('08-MAR-2026', 'DD-MON-YYYY') AS real_date
FROM dual;

-- real_date is not VARCHAR2.
-- It is DATE.
--
-- If you want to control output appearance,
-- use TO_CHAR after TO_DATE:
SELECT TO_CHAR(TO_DATE('08-MAR-2026', 'DD-MON-YYYY'), 'DD-MM-YYYY') AS date_text
FROM dual;

-- Here:
--   TO_DATE creates DATE;
--   TO_CHAR displays that DATE as text.


-- ============================================================
-- Avoid implicit conversion
-- ============================================================
-- This comparison uses implicit string-to-date conversion:
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE e.hire_date > '01-JAN-05';

-- It may work in one session
-- and fail or behave differently in another session.
--
-- Better:
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE e.hire_date > TO_DATE('01-JAN-2005', 'DD-MON-YYYY');

-- Now Oracle clearly knows:
--   left side  = DATE column;
--   right side = DATE value.


-- ============================================================
-- RR and YYYY
-- ============================================================
-- YYYY expects 4-digit year.
--
-- Пример:
SELECT TO_DATE('20-SEP-2026', 'DD-MON-YYYY') AS result
FROM dual;

-- RR is used with 2-digit year.
--
-- Пример:
SELECT TO_DATE('20-SEP-26', 'DD-MON-RR') AS result
FROM dual;

-- In this lesson remember:
--   use YYYY when text has 4 digits;
--   use RR when text has 2 digits and you intentionally want RR logic.


-- ============================================================
-- Time part
-- ============================================================
-- Oracle DATE can contain both date and time.
--
-- Пример:
SELECT TO_DATE('20-SEP-2026 19:07:58', 'DD-MON-YYYY HH24:MI:SS') AS result
FROM dual;

-- Format elements:
--   HH24 = hour from 00 to 23;
--   MI   = minute;
--   SS   = second.
--
-- To see time clearly:
SELECT TO_CHAR(TO_DATE('20-SEP-2026 19:07:58', 'DD-MON-YYYY HH24:MI:SS'),
               'DD-MON-YYYY HH24:MI:SS') AS result
FROM dual;


-- ============================================================
-- Custom separators
-- ============================================================
-- Format mask can describe unusual text,
-- if it matches that text.
--
-- Пример:
SELECT TO_DATE('18:40 2026!20-Sep', 'HH24:MI YYYY!DD-Mon') AS result
FROM dual;

-- Meaning:
--   18:40    -> HH24:MI;
--   2026     -> YYYY;
--   20-Sep   -> DD-Mon.
--
-- For readability in real code,
-- prefer simple and predictable date strings.


-- ============================================================
-- NLS_DATE_LANGUAGE
-- ============================================================
-- Month names depend on language.
--
-- If text contains English month name:
SELECT TO_DATE('20-September-2026',
               'DD-Month-YYYY',
               'NLS_DATE_LANGUAGE = English') AS result
FROM dual;

-- If text contains Russian month name:
SELECT TO_DATE('20-Сентябрь-2026',
               'DD-Month-YYYY',
               'NLS_DATE_LANGUAGE = Russian') AS result
FROM dual;

-- NLS_DATE_LANGUAGE helps Oracle understand month names in text.


-- ============================================================
-- Filtering rows with TO_DATE
-- ============================================================
-- Common use case:
-- compare DATE column with date written as text.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE e.hire_date >= TO_DATE('01-JAN-2006', 'DD-MON-YYYY');

-- Another example:
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE e.hire_date < TO_DATE('01-JAN-2008', 'DD-MON-YYYY');

-- TO_DATE is on the text value,
-- not on the column.


-- ============================================================
-- Date range
-- ============================================================
-- To filter one period,
-- convert both border values to DATE.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE e.hire_date >= TO_DATE('01-JAN-2006', 'DD-MON-YYYY')
  AND e.hire_date <  TO_DATE('01-JAN-2007', 'DD-MON-YYYY');

-- This finds employees hired during year 2006.
--
-- The upper border uses < next year.
-- This pattern works well even when DATE has time part.


-- ============================================================
-- NULL
-- ============================================================
-- If source text is NULL,
-- result is NULL.
--
-- Пример:
SELECT TO_DATE(NULL, 'DD-MON-YYYY') AS result
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что TO_DATE formats output.
--    Нет, TO_DATE creates DATE value.
--    TO_CHAR formats output.
--
-- 2. Писать text and wrong mask.
--    '20-09-2026' does not match 'DD-MON-YYYY'.
--
-- 3. Comparing DATE column with plain string.
--    Use TO_DATE for the string value.
--
-- 4. Путать MM and MI.
--    MM = month.
--    MI = minute.
--
-- 5. Using YYYY with 2-digit year.
--    For '26' use RR.
--    For '2026' use YYYY.
--
-- 6. Forgetting NLS_DATE_LANGUAGE with month names.
--    Month names are language-dependent.
--
-- 7. Applying TO_DATE to a DATE column.
--    TO_DATE is for text.
--    DATE column is already DATE.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Convert text '15-08-2026' to DATE.
SELECT TO_DATE('15-08-2026', 'DD-MM-YYYY') AS result
FROM dual;

-- 2. Convert text with time to DATE and show it with TO_CHAR.
SELECT TO_CHAR(TO_DATE('15-08-2026 14:30:25', 'DD-MM-YYYY HH24:MI:SS'),
               'DD-MON-YYYY HH24:MI:SS') AS result
FROM dual;

-- 3. Convert text with English month name.
SELECT TO_DATE('15-August-2026',
               'DD-Month-YYYY',
               'NLS_DATE_LANGUAGE = English') AS result
FROM dual;

-- 4. Show employees hired after 01-JAN-2005.
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE e.hire_date > TO_DATE('01-JAN-2005', 'DD-MON-YYYY');

-- 5. Show employees hired before 01-JAN-2007.
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE e.hire_date < TO_DATE('01-JAN-2007', 'DD-MON-YYYY');

-- 6. Show employees hired during 2006.
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE e.hire_date >= TO_DATE('01-JAN-2006', 'DD-MON-YYYY')
  AND e.hire_date <  TO_DATE('01-JAN-2007', 'DD-MON-YYYY');

-- 7. Show employees hired on or after 20-SEP-2006.
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE e.hire_date >= TO_DATE('20-SEP-2006', 'DD-MON-YYYY');

-- 8. Show employee name, hire_date and formatted hire_date_text
--    for employees hired after 01-JAN-2007.
SELECT e.employee_id,
       e.first_name,
       e.hire_date,
       TO_CHAR(e.hire_date, 'DD-MON-YYYY') AS hire_date_text
FROM employees e
WHERE e.hire_date > TO_DATE('01-JAN-2007', 'DD-MON-YYYY');

-- 9. Show employees whose hire_date is before 01-JUL-2006.
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE e.hire_date < TO_DATE('01-JUL-2006', 'DD-MON-YYYY');

-- 10. Show readable sentence for employees hired after 01-JAN-2008.
SELECT 'Employee ' || e.first_name ||
       ' was hired on ' ||
       TO_CHAR(e.hire_date, 'DD-MON-YYYY') AS sentence
FROM employees e
WHERE e.hire_date > TO_DATE('01-JAN-2008', 'DD-MON-YYYY');


-- ============================================================
-- Mini summary
-- ============================================================
-- TO_DATE converts text to DATE.
--
-- Syntax:
--   TO_DATE(char_value, format_mask, nls_parameters)
--
-- Important:
--   result type is DATE;
--   format mask describes input text;
--   TO_DATE does not control output format;
--   use TO_CHAR if you need formatted output text;
--   avoid implicit conversion from string to DATE;
--   use explicit TO_DATE in date comparisons;
--   use HH24:MI:SS when text contains time;
--   use NLS_DATE_LANGUAGE when text contains month names.
