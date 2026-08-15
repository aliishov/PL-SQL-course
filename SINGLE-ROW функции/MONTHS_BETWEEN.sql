-- Date functions
-- MONTHS_BETWEEN(date1, date2)

SELECT employee_id,
       MONTHS_BETWEEN(end_date, start_date)
FROM job_history;

SELECT MONTHS_BETWEEN('12-MAY-19', '12-JAN-19')
FROM dual;

SELECT MONTHS_BETWEEN('12-JAN-19', '12-MAY-19')
FROM dual;


-- ============================================================
-- Date functions
-- MONTHS_BETWEEN
-- ============================================================
-- MONTHS_BETWEEN - single-row date function.
--
-- Простыми словами:
--   MONTHS_BETWEEN показывает,
--   сколько months находится между two dates.
--
-- Result:
--   NUMBER
--
-- Важно:
--   MONTHS_BETWEEN возвращает не DATE,
--   а number of months.
--
-- В этом уроке только MONTHS_BETWEEN.
-- Другие date functions будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- MONTHS_BETWEEN отвечает на вопрос:
--   "Сколько месяцев прошло между date1 и date2?"
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2019-05-12', DATE '2019-01-12') AS months_count
FROM dual;

-- Result:
--   4
--
-- Почему:
--   date1 = 12-MAY-2019
--   date2 = 12-JAN-2019
--
-- Между January 12 и May 12:
--   4 months.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   MONTHS_BETWEEN(date1, date2)
--
-- Где:
--   date1   - первая date;
--   date2   - вторая date.
--
-- Formula idea:
--   date1 - date2
--
-- Если date1 later than date2,
-- result будет positive.
--
-- Если date1 earlier than date2,
-- result будет negative.
--
-- Если dates are equal,
-- result будет 0.


-- ============================================================
-- Positive result
-- ============================================================
-- Если first date позже second date,
-- result будет positive number.
--
-- Пример из начала файла:
SELECT MONTHS_BETWEEN('12-MAY-19', '12-JAN-19') AS months_count
FROM dual;

-- Result:
--   4
--
-- Meaning:
--   12-MAY-19 later than 12-JAN-19;
--   между ними 4 months.
--
-- Важно:
--   string literals with dates depend on NLS_DATE_FORMAT.
--   Более ясный учебный вариант:
SELECT MONTHS_BETWEEN(DATE '2019-05-12', DATE '2019-01-12') AS months_count
FROM dual;


-- ============================================================
-- Negative result
-- ============================================================
-- Если first date раньше second date,
-- result будет negative number.
--
-- Пример из начала файла:
SELECT MONTHS_BETWEEN('12-JAN-19', '12-MAY-19') AS months_count
FROM dual;

-- Result:
--   -4
--
-- Meaning:
--   12-JAN-19 earlier than 12-MAY-19;
--   поэтому result negative.
--
-- Более ясный учебный вариант:
SELECT MONTHS_BETWEEN(DATE '2019-01-12', DATE '2019-05-12') AS months_count
FROM dual;


-- ============================================================
-- Same dates
-- ============================================================
-- Если date1 и date2 одинаковые,
-- MONTHS_BETWEEN возвращает 0.
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2019-05-12', DATE '2019-05-12') AS months_count
FROM dual;

-- Result:
--   0
--
-- Почему:
--   между одинаковыми dates нет разницы в months.


-- ============================================================
-- Same day of month
-- ============================================================
-- Если у обеих dates одинаковый day of month,
-- result is whole number.
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2019-06-15', DATE '2019-02-15') AS months_count
FROM dual;

-- Result:
--   4
--
-- Почему:
--   day of month одинаковый:
--   15 and 15.
--
-- Разница:
--   February 15 -> June 15 = 4 months.


-- ============================================================
-- Different day of month
-- ============================================================
-- Если day of month отличается,
-- result может быть decimal number.
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2019-02-15', DATE '2019-01-10') AS months_count
FROM dual;

-- Result:
--   about 1.161290322580645
--
-- Почему:
--   между January 10 и February 10 есть 1 full month;
--   затем есть extra 5 days;
--   fractional part считается по 31-day month rule.
--
-- Для beginner level главное:
--   different day of month can create decimal result.


-- ============================================================
-- Fractional month rule
-- ============================================================
-- Если days are different,
-- Oracle считает fractional part
-- based on 31 days.
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2019-02-11', DATE '2019-01-10') AS months_count
FROM dual;

-- Result:
--   about 1.032258064516129
--
-- Почему:
--   1 full month:
--     January 10 -> February 10
--
-- Extra:
--   1 day
--
-- Fractional part:
--   1 / 31
--
-- So result:
--   1 + 1/31


-- ============================================================
-- Both dates are last day of month
-- ============================================================
-- Если обе dates are last day of month,
-- result is whole number.
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2019-02-28', DATE '2019-01-31') AS months_count
FROM dual;

-- Result:
--   1
--
-- Почему:
--   31-JAN-2019 is last day of January;
--   28-FEB-2019 is last day of February;
--   Oracle treats this as full month.


-- ============================================================
-- Last day example with more months
-- ============================================================
SELECT MONTHS_BETWEEN(DATE '2019-04-30', DATE '2019-01-31') AS months_count
FROM dual;

-- Result:
--   3
--
-- Почему:
--   31-JAN is last day of January;
--   30-APR is last day of April;
--   between them are 3 full months.


-- ============================================================
-- Order of arguments matters
-- ============================================================
-- MONTHS_BETWEEN(date1, date2)
-- and
-- MONTHS_BETWEEN(date2, date1)
-- give opposite signs.
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2019-05-12', DATE '2019-01-12') AS forward_months
FROM dual;

-- Result:
--   4
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2019-01-12', DATE '2019-05-12') AS backward_months
FROM dual;

-- Result:
--   -4
--
-- Same dates, different order.


-- ============================================================
-- MONTHS_BETWEEN with job_history
-- ============================================================
-- В HR schema table job_history имеет:
--   start_date;
--   end_date.
--
-- Пример из начала файла:
SELECT employee_id,
       MONTHS_BETWEEN(end_date, start_date) AS months_in_job
FROM job_history;

-- Meaning:
--   end_date is date1;
--   start_date is date2;
--   result shows how many months between them.
--
-- Если end_date later than start_date,
-- result positive.


-- ============================================================
-- MONTHS_BETWEEN with employees
-- ============================================================
-- Можно посчитать,
-- сколько months прошло from hire_date until current date.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       MONTHS_BETWEEN(SYSDATE, hire_date) AS months_after_hire
FROM employees;

-- Meaning:
--   date1 = SYSDATE;
--   date2 = hire_date;
--   result shows months from hire_date to today.
--
-- SYSDATE здесь используется как current database date.
-- Подробно SYSDATE уже был отдельной темой.


-- ============================================================
-- MONTHS_BETWEEN in SELECT list
-- ============================================================
-- MONTHS_BETWEEN можно использовать в SELECT list.
--
-- Пример:
SELECT employee_id,
       start_date,
       end_date,
       MONTHS_BETWEEN(end_date, start_date) AS months_count
FROM job_history;

-- Meaning:
--   показать original dates;
--   рядом показать calculated number of months.
--
-- Table job_history не изменяется.
-- Это только calculated output.


-- ============================================================
-- MONTHS_BETWEEN with alias
-- ============================================================
-- Для expression лучше давать alias.
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2020-12-01', DATE '2020-01-01') AS months_count
FROM dual;

-- Alias:
--   months_count
--
-- Без alias output column может называться длинно:
--   MONTHS_BETWEEN(DATE'2020-12-01',DATE'2020-01-01')
--
-- С alias result set читать легче.


-- ============================================================
-- MONTHS_BETWEEN in WHERE
-- ============================================================
-- MONTHS_BETWEEN можно использовать в WHERE condition.
--
-- Пример:
SELECT employee_id,
       start_date,
       end_date
FROM job_history
WHERE MONTHS_BETWEEN(end_date, start_date) >= 12;

-- Meaning:
--   вернуть rows,
--   где между start_date и end_date
--   прошло at least 12 months.
--
-- Важно:
--   function in WHERE applies to rows.
--   В больших tables это может влиять на performance.
--   Детали performance будут отдельной темой.


-- ============================================================
-- Short period example
-- ============================================================
-- Если между dates меньше одного month,
-- result будет decimal number меньше 1.
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2019-01-20', DATE '2019-01-10') AS months_count
FROM dual;

-- Result:
--   about 0.32258064516129
--
-- Почему:
--   10 days difference;
--   fractional part uses 31-day month rule;
--   10 / 31.


-- ============================================================
-- More than one year
-- ============================================================
-- Result is still number of months.
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2021-01-01', DATE '2019-01-01') AS months_count
FROM dual;

-- Result:
--   24
--
-- Почему:
--   between January 2019 and January 2021:
--   2 years = 24 months.


-- ============================================================
-- Date literals
-- ============================================================
-- В examples можно использовать DATE literal.
--
-- Syntax:
--   DATE 'YYYY-MM-DD'
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2020-07-01', DATE '2020-01-01') AS months_count
FROM dual;

-- Result:
--   6
--
-- DATE literal удобен,
-- потому что не зависит от NLS_DATE_FORMAT.


-- ============================================================
-- String date values
-- ============================================================
-- В начале файла есть string date examples:
--
--   '12-MAY-19'
--   '12-JAN-19'
--
-- Oracle может convert these strings to DATE,
-- если format подходит current session.
--
-- Пример:
SELECT MONTHS_BETWEEN('12-MAY-19', '12-JAN-19') AS months_count
FROM dual;

-- Result:
--   4
--
-- Важно:
--   if session date format is different,
--   string conversion can fail or work differently.
--
-- Для надежных учебных examples лучше использовать:
--   DATE '2019-05-12'


-- ============================================================
-- Time part
-- ============================================================
-- Oracle DATE can contain time part.
--
-- MONTHS_BETWEEN can consider time part
-- when dates do not have same day of month.
--
-- Для beginner level главное:
--   DATE is not only day-month-year;
--   DATE can also contain hour-minute-second;
--   time part can affect decimal result.
--
-- More detailed time formatting будет отдельной темой.


-- ============================================================
-- MONTHS_BETWEEN and NULL
-- ============================================================
-- Если date1 is NULL,
-- result будет NULL.
--
-- Пример:
SELECT MONTHS_BETWEEN(NULL, DATE '2019-01-01') AS months_count
FROM dual;

-- Result:
--   NULL
--
-- Если date2 is NULL,
-- result тоже будет NULL.
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2019-05-01', NULL) AS months_count
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- Whole number result
-- ============================================================
-- Whole number result обычно получается,
-- когда:
--   dates have same day of month;
--   or both dates are last day of month.
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2020-08-10', DATE '2020-05-10') AS months_count
FROM dual;

-- Result:
--   3
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2020-02-29', DATE '2020-01-31') AS months_count
FROM dual;

-- Result:
--   1
--
-- Почему:
--   both dates are last day of month.


-- ============================================================
-- Decimal result
-- ============================================================
-- Decimal result появляется,
-- когда dates do not align by day of month.
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2020-08-20', DATE '2020-05-10') AS months_count
FROM dual;

-- Result:
--   about 3.32258064516129
--
-- Почему:
--   May 10 -> August 10 = 3 months;
--   extra 10 days;
--   10 / 31 = decimal part.


-- ============================================================
-- Using result as number
-- ============================================================
-- MONTHS_BETWEEN returns NUMBER.
--
-- Поэтому result можно использовать
-- in numeric comparison.
--
-- Пример:
SELECT employee_id,
       start_date,
       end_date,
       MONTHS_BETWEEN(end_date, start_date) AS months_count
FROM job_history
WHERE MONTHS_BETWEEN(end_date, start_date) > 6;

-- Meaning:
--   вернуть rows,
--   где period is longer than 6 months.


-- ============================================================
-- Approximate years from months
-- ============================================================
-- Так как result is number of months,
-- можно сделать simple expression for years.
--
-- Пример:
SELECT employee_id,
       start_date,
       end_date,
       MONTHS_BETWEEN(end_date, start_date) AS months_count,
       MONTHS_BETWEEN(end_date, start_date) / 12 AS years_count
FROM job_history;

-- Meaning:
--   months_count shows months;
--   years_count shows months divided by 12.
--
-- Это simple calculation.
-- Formatting и округление будут отдельными темами.


-- ============================================================
-- Current employment months
-- ============================================================
-- Можно считать months from hire_date to current date.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date,
       MONTHS_BETWEEN(SYSDATE, hire_date) AS current_months_count
FROM employees;

-- Meaning:
--   показать how many months passed since hire_date.
--
-- Result может быть decimal,
-- потому что current date and hire_date
-- не всегда имеют same day of month.


-- ============================================================
-- Future date example
-- ============================================================
-- Если date1 is future compared to date2,
-- result positive.
--
-- Пример:
SELECT MONTHS_BETWEEN(DATE '2026-12-15', DATE '2026-08-15') AS months_count
FROM dual;

-- Result:
--   4
--
-- Если поменять порядок:
SELECT MONTHS_BETWEEN(DATE '2026-08-15', DATE '2026-12-15') AS months_count
FROM dual;

-- Result:
--   -4


-- ============================================================
-- Common use case: contract duration
-- ============================================================
-- MONTHS_BETWEEN подходит,
-- когда нужно посчитать duration in months.
--
-- Пример:
SELECT employee_id,
       start_date,
       end_date,
       MONTHS_BETWEEN(end_date, start_date) AS contract_months
FROM job_history;

-- Meaning:
--   start_date is beginning;
--   end_date is ending;
--   contract_months is duration in months.


-- ============================================================
-- Common use case: filter long periods
-- ============================================================
-- Можно оставить только periods longer than N months.
--
-- Пример:
SELECT employee_id,
       start_date,
       end_date
FROM job_history
WHERE MONTHS_BETWEEN(end_date, start_date) >= 24;

-- Meaning:
--   вернуть rows,
--   где duration is at least 24 months.


-- ============================================================
-- Common use case: compare to current date
-- ============================================================
-- Можно сравнить date column with current date
-- through months difference.
--
-- Пример:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE MONTHS_BETWEEN(SYSDATE, hire_date) >= 12;

-- Meaning:
--   вернуть employees,
--   hired at least 12 months ago.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Путать order of arguments.
--    MONTHS_BETWEEN(later_date, earlier_date) gives positive result.
--
-- 2. Думать, что result is DATE.
--    MONTHS_BETWEEN returns NUMBER.
--
-- 3. Ожидать only whole numbers.
--    Different day of month can produce decimal result.
--
-- 4. Забывать про last day of month rule.
--    If both dates are last days, result can be whole number.
--
-- 5. Использовать string dates без понимания NLS_DATE_FORMAT.
--    DATE literal is clearer for examples.
--
-- 6. Забывать that NULL gives NULL.
--    If one argument is NULL, result is NULL.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Count months between two dates:
SELECT MONTHS_BETWEEN(DATE '2020-05-01', DATE '2020-01-01') AS result
FROM dual;

-- 2. Reverse the dates:
SELECT MONTHS_BETWEEN(DATE '2020-01-01', DATE '2020-05-01') AS result
FROM dual;

-- 3. Same dates:
SELECT MONTHS_BETWEEN(DATE '2020-05-01', DATE '2020-05-01') AS result
FROM dual;

-- 4. Different day of month:
SELECT MONTHS_BETWEEN(DATE '2020-05-15', DATE '2020-01-10') AS result
FROM dual;

-- 5. Both dates are last day of month:
SELECT MONTHS_BETWEEN(DATE '2020-02-29', DATE '2020-01-31') AS result
FROM dual;

-- 6. Use job_history:
SELECT employee_id,
       start_date,
       end_date,
       MONTHS_BETWEEN(end_date, start_date) AS months_count
FROM job_history;

-- 7. Filter periods at least 12 months:
SELECT employee_id,
       start_date,
       end_date
FROM job_history
WHERE MONTHS_BETWEEN(end_date, start_date) >= 12;

-- 8. Count months since hire_date:
SELECT employee_id,
       first_name,
       hire_date,
       MONTHS_BETWEEN(SYSDATE, hire_date) AS months_after_hire
FROM employees;


-- ============================================================
-- Mini summary
-- ============================================================
-- MONTHS_BETWEEN returns number of months between two dates.
--
-- Syntax:
--   MONTHS_BETWEEN(date1, date2)
--
-- Important:
--   result type is NUMBER;
--   date1 later than date2 gives positive result;
--   date1 earlier than date2 gives negative result;
--   same dates give 0;
--   same day of month gives whole number;
--   both last days of months can give whole number;
--   different days can give decimal result;
--   decimal part is based on 31-day month rule;
--   SELECT with MONTHS_BETWEEN does not change table data.
