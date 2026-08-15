-- Date functions
-- NEXT_DAY(date, day_of_the_week)

SELECT NEXT_DAY(SYSDATE, 1)
FROM dual;

SELECT NEXT_DAY(SYSDATE, 'sat')
FROM dual;

SELECT NEXT_DAY(SYSDATE, 'monday')
FROM dual;

SELECT *
FROM sys.nls_session_parameters;


-- ============================================================
-- Date functions
-- NEXT_DAY
-- ============================================================
-- NEXT_DAY      - single-row date function.
--
-- Простыми словами:
--   NEXT_DAY возвращает date следующего указанного weekday
--   после исходной date.
--
-- Result:
--   DATE
--
-- Важно:
--   NEXT_DAY ищет день строго after date_value.
--
-- Если date_value уже является нужным weekday,
-- NEXT_DAY вернет такой же weekday на следующей week.
--
-- В этом уроке только NEXT_DAY.
-- Другие date functions будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- NEXT_DAY отвечает на вопрос:
--   "Какая дата будет в следующий Monday?"
--   "Какая дата будет в следующий Saturday?"
--   "Какая дата будет в следующий указанный weekday?"
--
-- Пример:
SELECT NEXT_DAY(DATE '2009-10-15', 'TUESDAY') AS next_weekday
FROM dual;

-- Result:
--   20-OCT-09
--
-- Почему:
--   15-OCT-2009 was Thursday;
--   next Tuesday after that date is 20-OCT-2009.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   NEXT_DAY(date_value, day_name)
--
-- Где:
--   date_value   - исходная DATE;
--   day_name     - name или abbreviation weekday.
--
-- Official syntax uses day name as text:
--   'MONDAY'
--   'TUESDAY'
--   'SAT'
--   'FRI'
--
-- Result type:
--   DATE


-- ============================================================
-- NEXT_DAY with SYSDATE
-- ============================================================
-- SYSDATE возвращает current database date and time.
--
-- Пример из начала файла:
SELECT NEXT_DAY(SYSDATE, 'sat') AS next_saturday
FROM dual;

-- Meaning:
--   найти следующий Saturday
--   after current database date.
--
-- Result будет зависеть от того,
-- в какой день query выполняется.


-- ============================================================
-- Full weekday name
-- ============================================================
-- Можно писать full weekday name.
--
-- Пример:
SELECT NEXT_DAY(DATE '2026-08-15', 'MONDAY') AS next_monday
FROM dual;

-- Result:
--   17-AUG-26
--
-- Почему:
--   15-AUG-2026 is Saturday;
--   next Monday is 17-AUG-2026.
--
-- Пример из начала файла:
SELECT NEXT_DAY(SYSDATE, 'monday') AS next_monday
FROM dual;

-- Meaning:
--   найти next Monday after current database date.


-- ============================================================
-- Weekday abbreviation
-- ============================================================
-- Можно писать abbreviation weekday.
--
-- Пример:
SELECT NEXT_DAY(DATE '2026-08-15', 'SAT') AS next_saturday
FROM dual;

-- Result:
--   22-AUG-26
--
-- Почему:
--   15-AUG-2026 is Saturday;
--   NEXT_DAY ищет date strictly after source date;
--   therefore result is Saturday of next week.
--
-- Пример:
SELECT NEXT_DAY(DATE '2026-08-15', 'MON') AS next_monday
FROM dual;

-- Result:
--   17-AUG-26


-- ============================================================
-- Strictly after source date
-- ============================================================
-- NEXT_DAY does not return source date itself.
--
-- Пример:
SELECT NEXT_DAY(DATE '2026-08-15', 'SATURDAY') AS next_saturday
FROM dual;

-- Result:
--   22-AUG-26
--
-- Почему:
--   source date is already Saturday;
--   but NEXT_DAY searches the next Saturday after it.
--
-- It means:
--   not 15-AUG-26;
--   but 22-AUG-26.


-- ============================================================
-- Different weekday examples
-- ============================================================
SELECT NEXT_DAY(DATE '2026-08-15', 'SUNDAY') AS next_sunday
FROM dual;

-- Result:
--   16-AUG-26

SELECT NEXT_DAY(DATE '2026-08-15', 'MONDAY') AS next_monday
FROM dual;

-- Result:
--   17-AUG-26

SELECT NEXT_DAY(DATE '2026-08-15', 'FRIDAY') AS next_friday
FROM dual;

-- Result:
--   21-AUG-26

SELECT NEXT_DAY(DATE '2026-08-15', 'SATURDAY') AS next_saturday
FROM dual;

-- Result:
--   22-AUG-26


-- ============================================================
-- Day language of session
-- ============================================================
-- day_name must be written in date language of session.
--
-- In English session:
--   'MONDAY'
--   'TUESDAY'
--   'SATURDAY'
--
-- In another session language,
-- day names can be different.
--
-- Поэтому example with 'monday'
-- is clear when session date language is English.
--
-- Для проверки session parameters:
SELECT *
FROM sys.nls_session_parameters;

-- Более focused query:
SELECT *
FROM sys.nls_session_parameters
WHERE parameter IN ('NLS_DATE_LANGUAGE', 'NLS_TERRITORY', 'NLS_DATE_FORMAT');

-- NLS_DATE_LANGUAGE affects weekday names
-- accepted by NEXT_DAY.


-- ============================================================
-- Case of day name
-- ============================================================
-- In usual English session,
-- uppercase and lowercase day names both work.
--
-- Пример:
SELECT NEXT_DAY(DATE '2026-08-15', 'MONDAY') AS next_monday
FROM dual;

-- Result:
--   17-AUG-26
--
-- Пример:
SELECT NEXT_DAY(DATE '2026-08-15', 'monday') AS next_monday
FROM dual;

-- Result:
--   17-AUG-26
--
-- Но language still matters.
-- The word must be valid for the session language.


-- ============================================================
-- Extra characters after abbreviation
-- ============================================================
-- Oracle accepts enough letters for abbreviation.
--
-- Characters immediately after valid abbreviation are ignored.
--
-- Пример:
SELECT NEXT_DAY(DATE '2026-08-15', 'MONDAY') AS next_monday
FROM dual;

-- Result:
--   17-AUG-26
--
-- Пример:
SELECT NEXT_DAY(DATE '2026-08-15', 'MONxxxx') AS next_monday
FROM dual;

-- Result:
--   17-AUG-26
--
-- Почему:
--   MON is valid abbreviation in English;
--   extra characters after it are ignored.
--
-- Для readable code лучше писать normal names:
--   'MON'
--   'MONDAY'


-- ============================================================
-- Numeric weekday argument
-- ============================================================
-- В начале файла есть example:
SELECT NEXT_DAY(SYSDATE, 1) AS next_day_number
FROM dual;

-- Для beginner level лучше помнить:
--   official syntax uses day name text.
--
-- Numeric weekday values can be confusing,
-- because their meaning may depend on session territory rules.
--
-- Clearer examples:
SELECT NEXT_DAY(SYSDATE, 'MONDAY') AS next_monday
FROM dual;

SELECT NEXT_DAY(SYSDATE, 'SATURDAY') AS next_saturday
FROM dual;


-- ============================================================
-- Return type is DATE
-- ============================================================
-- NEXT_DAY returns DATE.
--
-- Это значит:
--   result can be selected;
--   result can be compared with other DATE values;
--   result can be used in date arithmetic.
--
-- Пример:
SELECT NEXT_DAY(DATE '2026-08-15', 'MONDAY') + 7 AS monday_after_next
FROM dual;

-- Result:
--   24-AUG-26
--
-- Почему:
--   next Monday = 17-AUG-26;
--   plus 7 days = 24-AUG-26.


-- ============================================================
-- Time part is preserved
-- ============================================================
-- Oracle DATE can contain time.
--
-- NEXT_DAY returns date with the same
-- hour, minute, and second as source date.
--
-- Example idea:
--   source date:
--     15-AUG-26 14:30:25
--
--   NEXT_DAY(source date, 'MONDAY'):
--     17-AUG-26 14:30:25
--
-- Display may hide time part,
-- depending on NLS_DATE_FORMAT.


-- ============================================================
-- NEXT_DAY with column values
-- ============================================================
-- NEXT_DAY можно использовать with date columns.
--
-- Пример:
SELECT employee_id,
       hire_date,
       NEXT_DAY(hire_date, 'MONDAY') AS next_monday_after_hire
FROM employees;

-- Meaning:
--   for each hire_date,
--   find next Monday after hire_date.
--
-- Table employees не изменяется.
-- Result is calculated output.


-- ============================================================
-- NEXT_DAY with job_history
-- ============================================================
-- Можно применять NEXT_DAY к start_date or end_date.
--
-- Пример:
SELECT employee_id,
       start_date,
       NEXT_DAY(start_date, 'FRIDAY') AS next_friday_after_start
FROM job_history;

-- Meaning:
--   для каждой start_date найти next Friday.
--
-- Пример:
SELECT employee_id,
       end_date,
       NEXT_DAY(end_date, 'MONDAY') AS next_monday_after_end
FROM job_history;

-- Meaning:
--   для каждой end_date найти next Monday.


-- ============================================================
-- NEXT_DAY in SELECT list
-- ============================================================
-- NEXT_DAY можно использовать in SELECT list.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       NEXT_DAY(hire_date, 'SATURDAY') AS first_saturday_after_hire
FROM employees;

-- Meaning:
--   show employee data;
--   show first Saturday after hire_date.


-- ============================================================
-- NEXT_DAY with alias
-- ============================================================
-- Для expression лучше давать alias.
--
-- Пример:
SELECT NEXT_DAY(DATE '2026-08-15', 'MONDAY') AS next_monday
FROM dual;

-- Alias:
--   next_monday
--
-- Без alias output column может называться длинно:
--   NEXT_DAY(DATE'2026-08-15','MONDAY')
--
-- С alias result set читать легче.


-- ============================================================
-- NEXT_DAY in WHERE
-- ============================================================
-- NEXT_DAY можно использовать in WHERE condition.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE NEXT_DAY(hire_date, 'MONDAY') < SYSDATE;

-- Meaning:
--   calculate next Monday after hire_date;
--   compare it with current database date;
--   return rows where that Monday is in the past.
--
-- SYSDATE уже был отдельной темой.
--
-- Важно:
--   function in WHERE applies to rows.
--   В больших tables это может влиять на performance.
--   Детали performance будут отдельной темой.


-- ============================================================
-- Find dates before next weekday
-- ============================================================
-- Можно сравнить date column
-- with calculated next weekday.
--
-- Пример:
SELECT employee_id,
       start_date,
       end_date
FROM job_history
WHERE end_date < NEXT_DAY(start_date, 'FRIDAY');

-- Meaning:
--   find next Friday after start_date;
--   return rows where end_date is earlier.
--
-- Это учебный example for comparison with calculated DATE.


-- ============================================================
-- Current next weekday
-- ============================================================
-- Common use:
--   find next specific weekday after today.
--
-- Пример:
SELECT NEXT_DAY(SYSDATE, 'MONDAY') AS next_monday
FROM dual;

-- Meaning:
--   next Monday after current database date/time.
--
-- Пример:
SELECT NEXT_DAY(SYSDATE, 'FRIDAY') AS next_friday
FROM dual;

-- Meaning:
--   next Friday after current database date/time.


-- ============================================================
-- Schedule example
-- ============================================================
-- NEXT_DAY can be used to calculate schedule dates.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       NEXT_DAY(hire_date, 'MONDAY') AS first_monday_check
FROM employees;

-- Meaning:
--   calculate first Monday after hire_date
--   as a possible check date.


-- ============================================================
-- One week after next weekday
-- ============================================================
-- Since NEXT_DAY returns DATE,
-- you can add days to result.
--
-- Пример:
SELECT NEXT_DAY(DATE '2026-08-15', 'MONDAY') AS next_monday,
       NEXT_DAY(DATE '2026-08-15', 'MONDAY') + 7 AS second_monday
FROM dual;

-- Result:
--   next_monday   = 17-AUG-26
--   second_monday = 24-AUG-26


-- ============================================================
-- Previous date trick
-- ============================================================
-- Sometimes source date itself should be allowed
-- if it is already the required weekday.
--
-- NEXT_DAY itself does not do that.
-- It always returns a later date.
--
-- Example:
SELECT NEXT_DAY(DATE '2026-08-15', 'SATURDAY') AS next_saturday
FROM dual;

-- Result:
--   22-AUG-26
--
-- If you need to include source Saturday itself,
-- one simple idea is to subtract 1 day first:
SELECT NEXT_DAY(DATE '2026-08-15' - 1, 'SATURDAY') AS saturday_or_next_saturday
FROM dual;

-- Result:
--   15-AUG-26
--
-- Почему:
--   source date minus 1 day = Friday;
--   next Saturday after Friday is original Saturday.


-- ============================================================
-- Invalid day name
-- ============================================================
-- If day_name is not valid for session language,
-- Oracle returns error.
--
-- Пример:
-- SELECT NEXT_DAY(SYSDATE, 'NOTADAY') AS result_date
-- FROM dual;
--
-- Possible error:
--   ORA-01846: not a valid day of the week
--
-- Поэтому важно писать valid weekday name
-- for current session language.


-- ============================================================
-- NEXT_DAY and NULL
-- ============================================================
-- Если date_value is NULL,
-- result будет NULL.
--
-- Пример:
SELECT NEXT_DAY(NULL, 'MONDAY') AS result_date
FROM dual;

-- Result:
--   NULL
--
-- Если day_name is NULL,
-- result тоже будет NULL.
--
-- Пример:
SELECT NEXT_DAY(SYSDATE, NULL) AS result_date
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- Date literals
-- ============================================================
-- Для fixed examples удобно использовать DATE literal.
--
-- Syntax:
--   DATE 'YYYY-MM-DD'
--
-- Пример:
SELECT NEXT_DAY(DATE '2026-08-15', 'SUNDAY') AS result_date
FROM dual;

-- Result:
--   16-AUG-26
--
-- DATE literal does not depend on NLS_DATE_FORMAT.


-- ============================================================
-- String date values
-- ============================================================
-- Можно встретить examples with string dates.
--
-- Пример:
SELECT NEXT_DAY('15-AUG-26', 'MONDAY') AS result_date
FROM dual;

-- This can work if session date format accepts that string.
--
-- Но для clearer examples лучше:
SELECT NEXT_DAY(DATE '2026-08-15', 'MONDAY') AS result_date
FROM dual;

-- Почему:
--   DATE literal avoids date string conversion problems.


-- ============================================================
-- NLS session parameters
-- ============================================================
-- NEXT_DAY depends on session date language
-- for weekday names.
--
-- Пример из начала файла:
SELECT *
FROM sys.nls_session_parameters;

-- More focused:
SELECT parameter,
       value
FROM sys.nls_session_parameters
WHERE parameter IN ('NLS_DATE_LANGUAGE', 'NLS_TERRITORY', 'NLS_DATE_FORMAT');

-- Useful parameters:
--   NLS_DATE_LANGUAGE - language for weekday names;
--   NLS_TERRITORY     - territory settings;
--   NLS_DATE_FORMAT   - display and string date format.


-- ============================================================
-- Common use case: next business weekday
-- ============================================================
-- Частая задача:
--   find next Monday, Friday, or another weekday.
--
-- Пример:
SELECT NEXT_DAY(SYSDATE, 'MONDAY') AS next_work_week_start
FROM dual;

-- Meaning:
--   find next Monday after current database date.


-- ============================================================
-- Common use case: first weekday after event
-- ============================================================
-- Можно посчитать first weekday after event date.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       NEXT_DAY(hire_date, 'FRIDAY') AS first_friday_after_hire
FROM employees;

-- Meaning:
--   event date = hire_date;
--   calculated date = next Friday after event.


-- ============================================================
-- Common use case: weekly follow-up date
-- ============================================================
-- NEXT_DAY can help calculate a weekly follow-up date.
--
-- Пример:
SELECT employee_id,
       start_date,
       NEXT_DAY(start_date, 'MONDAY') AS follow_up_date
FROM job_history;

-- Meaning:
--   follow_up_date is first Monday after start_date.


-- ============================================================
-- NEXT_DAY does not change table data
-- ============================================================
-- SELECT with NEXT_DAY показывает calculated result.
--
-- Пример:
SELECT hire_date AS original_hire_date,
       NEXT_DAY(hire_date, 'MONDAY') AS next_monday_after_hire
FROM employees;

-- original_hire_date показывает value из table.
-- next_monday_after_hire показывает calculated value.
--
-- Table employees не изменяется.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что NEXT_DAY can return same date.
--    Нет, it returns first matching weekday after source date.
--
-- 2. Забывать, что day_name depends on session language.
--    English 'MONDAY' may fail in non-English date language.
--
-- 3. Писать invalid weekday name.
--    Oracle can return ORA-01846.
--
-- 4. Думать, что NEXT_DAY returns NUMBER.
--    Нет, NEXT_DAY returns DATE.
--
-- 5. Забывать that DATE can contain time.
--    NEXT_DAY preserves time part.
--
-- 6. Использовать string dates без понимания NLS_DATE_FORMAT.
--    DATE literal is clearer for examples.
--
-- 7. Сильно полагаться на numeric weekday argument.
--    Official syntax uses weekday name text.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Find next Monday after fixed date:
SELECT NEXT_DAY(DATE '2026-08-15', 'MONDAY') AS result
FROM dual;

-- 2. Find next Saturday after same Saturday:
SELECT NEXT_DAY(DATE '2026-08-15', 'SATURDAY') AS result
FROM dual;

-- 3. Find next Sunday after fixed date:
SELECT NEXT_DAY(DATE '2026-08-15', 'SUNDAY') AS result
FROM dual;

-- 4. Use abbreviation:
SELECT NEXT_DAY(DATE '2026-08-15', 'FRI') AS result
FROM dual;

-- 5. Use SYSDATE:
SELECT NEXT_DAY(SYSDATE, 'MONDAY') AS result
FROM dual;

-- 6. Use employees hire_date:
SELECT employee_id,
       first_name,
       hire_date,
       NEXT_DAY(hire_date, 'MONDAY') AS next_monday_after_hire
FROM employees;

-- 7. Use job_history start_date:
SELECT employee_id,
       start_date,
       NEXT_DAY(start_date, 'FRIDAY') AS next_friday_after_start
FROM job_history;

-- 8. Check NLS parameters:
SELECT parameter,
       value
FROM sys.nls_session_parameters
WHERE parameter IN ('NLS_DATE_LANGUAGE', 'NLS_TERRITORY', 'NLS_DATE_FORMAT');


-- ============================================================
-- Mini summary
-- ============================================================
-- NEXT_DAY returns the first named weekday after a date.
--
-- Syntax:
--   NEXT_DAY(date_value, day_name)
--
-- Important:
--   result type is DATE;
--   day_name should be weekday name or abbreviation;
--   day_name depends on session date language;
--   NEXT_DAY searches strictly after source date;
--   if source date is already that weekday, result is next week;
--   returned DATE preserves time part;
--   DATE literal is clearer than string date for examples;
--   SELECT with NEXT_DAY does not change table data.
