-- Date functions
-- ADD_MONTHS(date, number_of_months)

SELECT end_date, ADD_MONTHS(end_date, 4)
FROM job_history;

SELECT end_date, ADD_MONTHS(end_date, -4)
FROM job_history;

SELECT end_date, ADD_MONTHS(end_date, 4.5)
FROM job_history;

SELECT ADD_MONTHS('30-SEP-26', 1)
FROM dual;

SELECT ADD_MONTHS('31-DEC-26', 2)
FROM dual;


-- ============================================================
-- Date functions
-- ADD_MONTHS
-- ============================================================
-- ADD_MONTHS    - single-row date function.
--
-- Простыми словами:
--   ADD_MONTHS добавляет или вычитает months from date.
--
-- Result:
--   DATE
--
-- Важно:
--   ADD_MONTHS возвращает DATE value.
--
-- В этом уроке только ADD_MONTHS.
-- Другие date functions будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- ADD_MONTHS отвечает на вопрос:
--   "Какая date будет через N months?"
--
-- Пример:
SELECT ADD_MONTHS(DATE '2026-08-15', 3) AS result_date
FROM dual;

-- Result:
--   15-NOV-26
--
-- Почему:
--   source date = 15-AUG-2026;
--   number_of_months = 3;
--   через 3 months будет 15-NOV-2026.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   ADD_MONTHS(date_value, number_of_months)
--
-- Где:
--   date_value          - исходная DATE;
--   number_of_months    - сколько months добавить.
--
-- number_of_months может быть:
--   positive number;
--   negative number;
--   zero.
--
-- Positive number adds months.
-- Negative number subtracts months.
-- Zero returns same date.


-- ============================================================
-- Add positive months
-- ============================================================
-- Positive number_of_months добавляет months.
--
-- Пример:
SELECT ADD_MONTHS(DATE '2026-01-10', 2) AS result_date
FROM dual;

-- Result:
--   10-MAR-26
--
-- Почему:
--   January + 2 months = March.
--
-- Пример:
SELECT ADD_MONTHS(DATE '2026-06-25', 6) AS result_date
FROM dual;

-- Result:
--   25-DEC-26


-- ============================================================
-- Subtract months with negative number
-- ============================================================
-- Negative number_of_months вычитает months.
--
-- Пример:
SELECT ADD_MONTHS(DATE '2026-08-15', -3) AS result_date
FROM dual;

-- Result:
--   15-MAY-26
--
-- Почему:
--   August minus 3 months = May.
--
-- Пример из начала файла:
SELECT end_date,
       ADD_MONTHS(end_date, -4) AS four_months_before
FROM job_history;

-- Meaning:
--   для каждой end_date показать date
--   на 4 months раньше.


-- ============================================================
-- Add zero months
-- ============================================================
-- Если number_of_months = 0,
-- result будет same date.
--
-- Пример:
SELECT ADD_MONTHS(DATE '2026-08-15', 0) AS result_date
FROM dual;

-- Result:
--   15-AUG-26
--
-- Никакого сдвига по months нет.


-- ============================================================
-- Same day of month
-- ============================================================
-- Обычно ADD_MONTHS сохраняет same day of month.
--
-- Пример:
SELECT ADD_MONTHS(DATE '2026-01-12', 1) AS result_date
FROM dual;

-- Result:
--   12-FEB-26
--
-- Day of month:
--   12 -> 12
--
-- Пример:
SELECT ADD_MONTHS(DATE '2026-01-12', 5) AS result_date
FROM dual;

-- Result:
--   12-JUN-26


-- ============================================================
-- If target month has fewer days
-- ============================================================
-- Иногда target month has fewer days
-- than source day of month.
--
-- Пример:
SELECT ADD_MONTHS(DATE '2026-01-31', 1) AS result_date
FROM dual;

-- Result:
--   28-FEB-26
--
-- Почему:
--   source date has day 31;
--   February 2026 has no day 31;
--   Oracle returns last day of February.
--
-- Пример:
SELECT ADD_MONTHS(DATE '2024-01-31', 1) AS result_date
FROM dual;

-- Result:
--   29-FEB-24
--
-- Почему:
--   2024 is leap year;
--   February has 29 days.


-- ============================================================
-- Last day of month rule
-- ============================================================
-- Если source date is last day of month,
-- result becomes last day of target month.
--
-- Пример из начала файла:
SELECT ADD_MONTHS('30-SEP-26', 1) AS result_date
FROM dual;

-- Result:
--   31-OCT-26
--
-- Почему:
--   30-SEP-26 is last day of September;
--   target month is October;
--   Oracle returns last day of October.
--
-- Более ясный учебный вариант:
SELECT ADD_MONTHS(DATE '2026-09-30', 1) AS result_date
FROM dual;


-- ============================================================
-- Last day with February
-- ============================================================
-- February особенно хорошо показывает last day rule.
--
-- Пример:
SELECT ADD_MONTHS(DATE '2026-02-28', 1) AS result_date
FROM dual;

-- Result:
--   31-MAR-26
--
-- Почему:
--   28-FEB-2026 is last day of February;
--   result is last day of March.
--
-- Пример:
SELECT ADD_MONTHS(DATE '2024-02-29', 1) AS result_date
FROM dual;

-- Result:
--   31-MAR-24
--
-- Почему:
--   29-FEB-2024 is last day of February in leap year.


-- ============================================================
-- December to next year
-- ============================================================
-- ADD_MONTHS can move date to another year.
--
-- Пример из начала файла:
SELECT ADD_MONTHS('31-DEC-26', 2) AS result_date
FROM dual;

-- Result:
--   28-FEB-27
--
-- Почему:
--   31-DEC-26 plus 2 months = February 2027;
--   February 2027 has no day 31;
--   result is last day of February.
--
-- Более ясный учебный вариант:
SELECT ADD_MONTHS(DATE '2026-12-31', 2) AS result_date
FROM dual;


-- ============================================================
-- Move backward to previous year
-- ============================================================
-- Negative months can move date to previous year.
--
-- Пример:
SELECT ADD_MONTHS(DATE '2026-01-15', -2) AS result_date
FROM dual;

-- Result:
--   15-NOV-25
--
-- Почему:
--   January 2026 minus 2 months = November 2025.


-- ============================================================
-- number_of_months should be whole months
-- ============================================================
-- ADD_MONTHS works with whole months.
--
-- Oracle documentation describes second argument as integer.
--
-- Если передать decimal number,
-- Oracle converts it to integer.
--
-- Пример из начала файла:
SELECT end_date,
       ADD_MONTHS(end_date, 4.5) AS result_date
FROM job_history;

-- Meaning:
--   4.5 is not "four and half months" in normal date arithmetic.
--   ADD_MONTHS shifts by whole months.
--
-- For beginner level:
--   use whole numbers:
--     4
--     -4
--     12
--
-- If you need days or hours,
-- use date arithmetic with numbers.
-- Это отдельная тема была рядом с SYSDATE.


-- ============================================================
-- ADD_MONTHS with job_history
-- ============================================================
-- В HR schema table job_history имеет:
--   start_date;
--   end_date.
--
-- Пример из начала файла:
SELECT end_date,
       ADD_MONTHS(end_date, 4) AS four_months_later
FROM job_history;

-- Meaning:
--   для каждой row взять end_date;
--   добавить 4 months;
--   показать calculated result.
--
-- Table job_history не изменяется.


-- ============================================================
-- ADD_MONTHS with start_date
-- ============================================================
-- Можно добавить months к start_date.
--
-- Пример:
SELECT employee_id,
       start_date,
       ADD_MONTHS(start_date, 6) AS six_months_after_start
FROM job_history;

-- Meaning:
--   показать date через 6 months after start_date.


-- ============================================================
-- ADD_MONTHS with end_date
-- ============================================================
-- Можно добавить или вычесть months from end_date.
--
-- Пример:
SELECT employee_id,
       end_date,
       ADD_MONTHS(end_date, 1) AS one_month_after_end,
       ADD_MONTHS(end_date, -1) AS one_month_before_end
FROM job_history;

-- Meaning:
--   one_month_after_end  = end_date plus 1 month;
--   one_month_before_end = end_date minus 1 month.


-- ============================================================
-- ADD_MONTHS in SELECT list
-- ============================================================
-- ADD_MONTHS можно использовать в SELECT list.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       ADD_MONTHS(hire_date, 12) AS one_year_after_hire
FROM employees;

-- Meaning:
--   show hire_date;
--   рядом show date after 12 months.
--
-- 12 months = 1 year in this simple calendar calculation.


-- ============================================================
-- ADD_MONTHS with alias
-- ============================================================
-- Для expression лучше давать alias.
--
-- Пример:
SELECT ADD_MONTHS(DATE '2026-08-15', 1) AS next_month_date
FROM dual;

-- Alias:
--   next_month_date
--
-- Без alias output column может называться длинно:
--   ADD_MONTHS(DATE'2026-08-15',1)
--
-- С alias result set читать легче.


-- ============================================================
-- ADD_MONTHS in WHERE
-- ============================================================
-- ADD_MONTHS можно использовать в WHERE condition.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE ADD_MONTHS(hire_date, 12) < SYSDATE;

-- Meaning:
--   hire_date plus 12 months;
--   compare with current database date;
--   return employees hired more than 12 months ago.
--
-- SYSDATE already was a separate lesson.
--
-- Важно:
--   function in WHERE applies to rows.
--   В больших tables это может влиять на performance.
--   Детали performance будут отдельной темой.


-- ============================================================
-- Find rows before calculated date
-- ============================================================
-- Можно сравнить date column
-- with another calculated date.
--
-- Пример:
SELECT employee_id,
       start_date,
       end_date
FROM job_history
WHERE end_date < ADD_MONTHS(start_date, 24);

-- Meaning:
--   calculate start_date plus 24 months;
--   return rows where end_date is earlier than that.
--
-- Это помогает найти periods shorter than 24 months.


-- ============================================================
-- Current date plus months
-- ============================================================
-- ADD_MONTHS можно использовать with current database date.
--
-- Пример:
SELECT ADD_MONTHS(SYSDATE, 1) AS next_month
FROM dual;

-- Meaning:
--   current date plus 1 month.
--
-- Пример:
SELECT ADD_MONTHS(SYSDATE, -1) AS previous_month
FROM dual;

-- Meaning:
--   current date minus 1 month.


-- ============================================================
-- Same time part
-- ============================================================
-- Oracle DATE can contain time.
--
-- ADD_MONTHS changes month part,
-- but keeps time part from source date.
--
-- Example idea:
--   source date:
--     15-AUG-26 14:30:25
--
--   ADD_MONTHS(source date, 1):
--     15-SEP-26 14:30:25
--
-- Display may hide time part,
-- depending on NLS_DATE_FORMAT.


-- ============================================================
-- Date literals
-- ============================================================
-- Для учебных examples удобно использовать DATE literal.
--
-- Syntax:
--   DATE 'YYYY-MM-DD'
--
-- Пример:
SELECT ADD_MONTHS(DATE '2026-08-15', 1) AS result_date
FROM dual;

-- Result:
--   15-SEP-26
--
-- DATE literal не зависит от NLS_DATE_FORMAT.


-- ============================================================
-- String date values
-- ============================================================
-- В начале файла есть string date examples:
--
--   '30-SEP-26'
--   '31-DEC-26'
--
-- Oracle может convert these strings to DATE,
-- если format подходит current session.
--
-- Пример:
SELECT ADD_MONTHS('30-SEP-26', 1) AS result_date
FROM dual;

-- Result:
--   31-OCT-26
--
-- Важно:
--   if session date format is different,
--   string conversion can fail or work differently.
--
-- Для надежных учебных examples лучше использовать:
--   DATE '2026-09-30'


-- ============================================================
-- ADD_MONTHS and NULL
-- ============================================================
-- Если date_value is NULL,
-- result будет NULL.
--
-- Пример:
SELECT ADD_MONTHS(NULL, 1) AS result_date
FROM dual;

-- Result:
--   NULL
--
-- Если number_of_months is NULL,
-- result тоже будет NULL.
--
-- Пример:
SELECT ADD_MONTHS(DATE '2026-08-15', NULL) AS result_date
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- Month movement examples
-- ============================================================
SELECT ADD_MONTHS(DATE '2026-01-15', 1) AS result_date
FROM dual;

-- Result:
--   15-FEB-26

SELECT ADD_MONTHS(DATE '2026-01-15', 2) AS result_date
FROM dual;

-- Result:
--   15-MAR-26

SELECT ADD_MONTHS(DATE '2026-01-15', 6) AS result_date
FROM dual;

-- Result:
--   15-JUL-26

SELECT ADD_MONTHS(DATE '2026-01-15', 12) AS result_date
FROM dual;

-- Result:
--   15-JAN-27


-- ============================================================
-- End of month examples
-- ============================================================
SELECT ADD_MONTHS(DATE '2026-04-30', 1) AS result_date
FROM dual;

-- Result:
--   31-MAY-26
--
-- 30-APR is last day of April,
-- so result is last day of May.

SELECT ADD_MONTHS(DATE '2026-05-31', 1) AS result_date
FROM dual;

-- Result:
--   30-JUN-26
--
-- 31-MAY is last day of May,
-- so result is last day of June.

SELECT ADD_MONTHS(DATE '2026-06-30', 1) AS result_date
FROM dual;

-- Result:
--   31-JUL-26
--
-- 30-JUN is last day of June,
-- so result is last day of July.


-- ============================================================
-- Not last day example
-- ============================================================
-- If source date is not last day
-- and target month has that day,
-- Oracle keeps same day of month.
--
-- Пример:
SELECT ADD_MONTHS(DATE '2026-04-29', 1) AS result_date
FROM dual;

-- Result:
--   29-MAY-26
--
-- Почему:
--   29-APR is not last day of April;
--   May has day 29;
--   result keeps day 29.


-- ============================================================
-- Target month shorter example
-- ============================================================
-- If source day does not exist in target month,
-- Oracle returns last day of target month.
--
-- Пример:
SELECT ADD_MONTHS(DATE '2026-03-31', -1) AS result_date
FROM dual;

-- Result:
--   28-FEB-26
--
-- Почему:
--   February 2026 has no day 31.


-- ============================================================
-- Common use case: probation end date
-- ============================================================
-- Частая задача:
--   посчитать date after N months.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       ADD_MONTHS(hire_date, 3) AS probation_end_date
FROM employees;

-- Meaning:
--   probation period = 3 months;
--   result shows date after 3 months from hire_date.


-- ============================================================
-- Common use case: yearly anniversary
-- ============================================================
-- 12 months можно использовать
-- для simple yearly anniversary.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       ADD_MONTHS(hire_date, 12) AS first_anniversary
FROM employees;

-- Meaning:
--   first_anniversary is one year after hire_date.
--
-- Если hire_date is last day of month,
-- last day rule can affect result.


-- ============================================================
-- Common use case: previous period
-- ============================================================
-- Negative months useful for previous periods.
--
-- Пример:
SELECT employee_id,
       end_date,
       ADD_MONTHS(end_date, -6) AS six_months_before_end
FROM job_history;

-- Meaning:
--   show date 6 months before end_date.


-- ============================================================
-- Common use case: future period
-- ============================================================
-- Positive months useful for future periods.
--
-- Пример:
SELECT employee_id,
       end_date,
       ADD_MONTHS(end_date, 6) AS six_months_after_end
FROM job_history;

-- Meaning:
--   show date 6 months after end_date.


-- ============================================================
-- ADD_MONTHS does not change table data
-- ============================================================
-- SELECT with ADD_MONTHS показывает calculated result.
--
-- Пример:
SELECT hire_date AS original_hire_date,
       ADD_MONTHS(hire_date, 1) AS one_month_later
FROM employees;

-- original_hire_date показывает value из table.
-- one_month_later показывает calculated value.
--
-- Table employees не изменяется.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что ADD_MONTHS returns NUMBER.
--    Нет, ADD_MONTHS returns DATE.
--
-- 2. Забывать, что positive number adds months.
--    ADD_MONTHS(date, 4) means plus 4 months.
--
-- 3. Забывать, что negative number subtracts months.
--    ADD_MONTHS(date, -4) means minus 4 months.
--
-- 4. Ожидать same day of month всегда.
--    Last day rule and shorter target month can change day.
--
-- 5. Использовать decimal months without understanding.
--    ADD_MONTHS works with whole months.
--
-- 6. Использовать string dates без понимания NLS_DATE_FORMAT.
--    DATE literal is clearer for examples.
--
-- 7. Думать, что SELECT with ADD_MONTHS changes table data.
--    It only returns calculated result set.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Add 1 month:
SELECT ADD_MONTHS(DATE '2026-08-15', 1) AS result
FROM dual;

-- 2. Add 6 months:
SELECT ADD_MONTHS(DATE '2026-08-15', 6) AS result
FROM dual;

-- 3. Subtract 3 months:
SELECT ADD_MONTHS(DATE '2026-08-15', -3) AS result
FROM dual;

-- 4. Add 0 months:
SELECT ADD_MONTHS(DATE '2026-08-15', 0) AS result
FROM dual;

-- 5. Check end of month rule:
SELECT ADD_MONTHS(DATE '2026-01-31', 1) AS result
FROM dual;

-- 6. Check last day source date:
SELECT ADD_MONTHS(DATE '2026-09-30', 1) AS result
FROM dual;

-- 7. Use job_history end_date:
SELECT employee_id,
       end_date,
       ADD_MONTHS(end_date, 4) AS four_months_later
FROM job_history;

-- 8. Use employees hire_date:
SELECT employee_id,
       first_name,
       hire_date,
       ADD_MONTHS(hire_date, 12) AS one_year_after_hire
FROM employees;

-- 9. Filter by calculated date:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE ADD_MONTHS(hire_date, 12) < SYSDATE;


-- ============================================================
-- Mini summary
-- ============================================================
-- ADD_MONTHS adds or subtracts months from a date.
--
-- Syntax:
--   ADD_MONTHS(date_value, number_of_months)
--
-- Important:
--   result type is DATE;
--   positive number adds months;
--   negative number subtracts months;
--   zero returns same date;
--   second argument represents whole months;
--   if source date is last day of month, result is last day of target month;
--   if target month has fewer days, result is last day of target month;
--   DATE literal is clearer than string date for examples;
--   SELECT with ADD_MONTHS does not change table data.
