-- ============================================================
-- Conversion functions
-- TO_CHAR for numbers
-- ============================================================
-- TO_CHAR(number) - single-row conversion function.
--
-- Простыми словами:
--   TO_CHAR для numbers конвертирует NUMBER value в text.
--
-- Result:
--   VARCHAR2
--
-- Важно:
--   number внутри table не меняется;
--   TO_CHAR только возвращает formatted text в result set.
--
-- В этом уроке только TO_CHAR for number values.
-- TO_CHAR for dates будет отдельной темой.
-- Other conversion functions будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- TO_CHAR(number) отвечает на вопрос:
--   "Как показать number как text in specific format?"
--
-- Пример:
SELECT TO_CHAR(18, '999') AS number_text
FROM dual;

-- Result:
--    18
--
-- Почему:
--   format mask '999' позволяет показать до 3 digits.
--
-- Result is text.
-- It appears as number.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   TO_CHAR(number_value, format_mask, nls_parameters)
--
-- Где:
--   number_value      - NUMBER value или numeric expression;
--   format_mask       - how to display number as text;
--   nls_parameters    - optional settings for separators/currency.
--
-- Short syntax:
--
--   TO_CHAR(number_value)
--
-- If format_mask is omitted,
-- Oracle converts number to text using default representation.
--
-- Result is VARCHAR2.


-- ============================================================
-- TO_CHAR without format mask
-- ============================================================
-- Если format mask не указан,
-- Oracle просто converts number to text.
--
-- Пример из начала файла:
SELECT TO_CHAR(18) AS number_text
FROM dual;

-- Result:
--   18
--
-- Важно:
--   result is text.
--   It is not NUMBER anymore.


-- ============================================================
-- Format model
-- ============================================================
-- Format model describes how number should look in output.
--
-- Common number format elements:
--
--   9    - optional digit position;
--   0    - forced zero position;
--   .    - decimal point;
--   D    - decimal character from NLS settings;
--   ,    - group separator;
--   G    - group separator from NLS settings;
--   $    - dollar sign;
--   L    - local currency symbol;
--   MI   - trailing minus sign;
--   PR   - negative value in angle brackets;
--   S    - sign for positive and negative numbers.


-- ============================================================
-- 9 format element
-- ============================================================
-- 9 means:
--   show digit if it exists;
--   otherwise leave blank.
--
-- Пример из начала файла:
SELECT TO_CHAR(18, '99999') AS result
FROM dual;

-- Result idea:
--      18
--
-- Почему:
--   format has 5 digit positions;
--   number has only 2 digits;
--   extra positions become blanks.
--
-- Пример:
SELECT TO_CHAR(123, '99999') AS result
FROM dual;

-- Result idea:
--     123


-- ============================================================
-- If number is wider than format
-- ============================================================
-- Если number does not fit format,
-- Oracle returns # characters.
--
-- Пример из начала файла:
SELECT TO_CHAR(181818, '99999') AS result
FROM dual;

-- Result:
--   #####
--
-- Почему:
--   number has 6 digits;
--   format allows only 5 digit positions.
--
-- Нужно сделать format mask wider:
SELECT TO_CHAR(181818, '999999') AS result
FROM dual;

-- Result:
--   181818


-- ============================================================
-- 0 format element
-- ============================================================
-- 0 means:
--   show digit if it exists;
--   otherwise show zero.
--
-- Пример из начала файла:
SELECT TO_CHAR(18, '099999') AS result
FROM dual;

-- Result:
--   000018
--
-- Почему:
--   format has forced zero positions;
--   missing leading digits become zeros.
--
-- Пример:
SELECT TO_CHAR(181818, '099999') AS result
FROM dual;

-- Result:
--   181818


-- ============================================================
-- 9 vs 0
-- ============================================================
-- Difference:
--   9 can show blanks;
--   0 forces zeros.
--
-- Пример:
SELECT TO_CHAR(18, '999999') AS with_9,
       TO_CHAR(18, '000000') AS with_0
FROM dual;

-- Result idea:
--   with_9 =     18
--   with_0 = 000018
--
-- Use 0 when fixed width with leading zeros is needed.


-- ============================================================
-- Decimal point with dot
-- ============================================================
-- Dot in format mask shows decimal point.
--
-- Пример из начала файла:
SELECT TO_CHAR(18.35, '099999.999') AS result
FROM dual;

-- Result:
--   000018.350
--
-- Почему:
--   099999 gives integer part with leading zeros;
--   .999 gives 3 decimal positions.
--
-- Пример:
SELECT TO_CHAR(18, '099999.999') AS result
FROM dual;

-- Result:
--   000018.000


-- ============================================================
-- Decimal character with D
-- ============================================================
-- D means decimal character from NLS settings.
--
-- Пример из начала файла:
SELECT TO_CHAR(18.35, '099999D999') AS result
FROM dual;

-- Result can be:
--   000018.350
--
-- Or:
--   000018,350
--
-- It depends on NLS numeric characters.
--
-- D is useful when output should follow session locale.


-- ============================================================
-- Group separator with comma
-- ============================================================
-- Comma in format mask shows group separator.
--
-- Пример из начала файла:
SELECT TO_CHAR(1234567, '99,999,999') AS result
FROM dual;

-- Result:
--    1,234,567
--
-- Почему:
--   commas are included in format mask;
--   output uses comma at those positions.


-- ============================================================
-- Group separator with G
-- ============================================================
-- G means group separator from NLS settings.
--
-- Пример из начала файла:
SELECT TO_CHAR(1234567, '99G99G9G999') AS result
FROM dual;

-- Result depends on NLS settings.
--
-- In one session it may use comma:
--   12,34,5,567
--
-- In another session it may use another group character.
--
-- Usually format masks use regular grouping style:
SELECT TO_CHAR(1234567, '9G999G999') AS result
FROM dual;

-- Result idea:
--   1,234,567


-- ============================================================
-- Dollar sign
-- ============================================================
-- $ puts dollar sign in output.
--
-- Пример из начала файла:
SELECT TO_CHAR(18, '$0999') AS result
FROM dual;

-- Result:
--   $0018
--
-- Meaning:
--   show number with dollar sign and forced zeros.
--
-- Пример:
SELECT TO_CHAR(123, '$9999') AS result
FROM dual;

-- Result idea:
--   $ 123


-- ============================================================
-- Local currency symbol with L
-- ============================================================
-- L shows local currency symbol
-- according to NLS settings.
--
-- Пример из начала файла:
SELECT TO_CHAR(18, 'L0999') AS result
FROM dual;

-- Result depends on NLS currency setting.
--
-- It can appear as:
--   $0018
--
-- Or another local currency symbol.
--
-- L is locale-sensitive.


-- ============================================================
-- MI format element
-- ============================================================
-- MI shows minus sign at the end
-- for negative numbers.
--
-- Пример:
SELECT TO_CHAR(18, '999MI') AS result
FROM dual;

-- Result idea:
--   18
--
-- Пример:
SELECT TO_CHAR(-18, '999MI') AS result
FROM dual;

-- Result:
--   18-
--
-- MI is useful when report style expects trailing minus.


-- ============================================================
-- PR format element
-- ============================================================
-- PR shows negative numbers in angle brackets.
--
-- Пример:
SELECT TO_CHAR(18, '9999PR') AS result
FROM dual;

-- Result idea:
--    18
--
-- Пример:
SELECT TO_CHAR(-18, '9999PR') AS result
FROM dual;

-- Result:
--   < 18>
--
-- Exact spaces can depend on format width.
--
-- PR is another report-style sign format.


-- ============================================================
-- S format element
-- ============================================================
-- S shows sign for both positive and negative numbers.
--
-- Пример:
SELECT TO_CHAR(18, 'S099') AS result
FROM dual;

-- Result:
--   +018
--
-- Пример:
SELECT TO_CHAR(-18, 'S099') AS result
FROM dual;

-- Result:
--   -018
--
-- Use S when sign should be visible for all numbers.


-- ============================================================
-- Rounding in formatted output
-- ============================================================
-- TO_CHAR can round displayed decimal part
-- based on format mask.
--
-- Пример:
SELECT TO_CHAR(18.356, '999.99') AS result
FROM dual;

-- Result:
--   18.36
--
-- Почему:
--   format has 2 decimal positions;
--   third decimal digit is 6;
--   displayed result rounds to 18.36.
--
-- Важно:
--   original number is not changed in table.
--   Only output text is formatted.


-- ============================================================
-- Decimal digits and trailing zeros
-- ============================================================
-- 9 after decimal point shows optional decimal digit.
-- 0 after decimal point forces zero.
--
-- Пример:
SELECT TO_CHAR(18, '999.999') AS optional_decimals,
       TO_CHAR(18, '999.000') AS forced_decimals
FROM dual;

-- Result idea:
--   optional_decimals =  18.
--   forced_decimals   =  18.000
--
-- Use 0 when trailing zeros should be visible.


-- ============================================================
-- FM modifier
-- ============================================================
-- FM means fill mode.
--
-- It removes leading and trailing blanks
-- from formatted result.
--
-- Пример:
SELECT TO_CHAR(18, '99999') AS normal_format,
       TO_CHAR(18, 'FM99999') AS fm_format
FROM dual;

-- Result idea:
--   normal_format =    18
--   fm_format     = 18
--
-- FM is useful when extra spaces are not wanted.


-- ============================================================
-- B format element
-- ============================================================
-- B can show blank for integer part when value is zero.
--
-- Пример:
SELECT TO_CHAR(0, 'B999') AS result
FROM dual;

-- Result idea:
--   blank output
--
-- For beginner level this is less common.
-- Most examples use 9 and 0.


-- ============================================================
-- NLS numeric characters
-- ============================================================
-- Decimal and group characters can be controlled
-- by NLS settings.
--
-- Пример:
SELECT parameter,
       value
FROM nls_session_parameters
WHERE parameter IN ('NLS_NUMERIC_CHARACTERS', 'NLS_CURRENCY');

-- Useful:
--   NLS_NUMERIC_CHARACTERS controls D and G;
--   NLS_CURRENCY controls L.


-- ============================================================
-- nls_parameters argument
-- ============================================================
-- Third argument can set numeric characters
-- for this TO_CHAR call.
--
-- Пример:
SELECT TO_CHAR(1234.56,
               '9G999D99',
               'NLS_NUMERIC_CHARACTERS = '',.''') AS result
FROM dual;

-- Result idea:
--   1.234,56
--
-- Meaning:
--   decimal character = comma;
--   group character   = dot.
--
-- This affects only this function call.


-- ============================================================
-- TO_CHAR with expressions
-- ============================================================
-- number_value can be expression.
--
-- Пример из начала файла:
SELECT e.first_name,
       e.salary * 1.111 AS raw_salary,
       TO_CHAR(e.salary * 1.111, '$999,999.99') AS formatted_salary
FROM employees e;

-- Meaning:
--   salary * 1.111 is calculated first;
--   TO_CHAR then formats calculated number as text.


-- ============================================================
-- Format too narrow
-- ============================================================
-- If format mask is too narrow,
-- output becomes # characters.
--
-- Пример из начала файла:
SELECT e.first_name,
       e.salary * 1.111 AS raw_salary,
       TO_CHAR(e.salary * 1.111, '$9,999.99') AS formatted_salary
FROM employees e;

-- Meaning:
--   some calculated salaries may not fit '$9,999.99'.
--
-- If value does not fit,
-- Oracle displays # characters.
--
-- Wider format:
SELECT e.first_name,
       TO_CHAR(e.salary * 1.111, '$999,999.99') AS formatted_salary
FROM employees e;


-- ============================================================
-- TO_CHAR with salary column
-- ============================================================
-- TO_CHAR often used with numeric columns.
--
-- Пример:
SELECT employee_id,
       first_name,
       salary,
       TO_CHAR(salary, '$999,999') AS salary_text
FROM employees;

-- Meaning:
--   salary is original NUMBER column;
--   salary_text is formatted text.
--
-- Table employees не изменяется.


-- ============================================================
-- TO_CHAR in SELECT list
-- ============================================================
-- TO_CHAR(number) usually appears in SELECT list
-- when output should be readable in a specific format.
--
-- Пример:
SELECT employee_id,
       salary,
       TO_CHAR(salary, '999G999D99') AS salary_display
FROM employees;

-- Meaning:
--   show salary with group and decimal elements.


-- ============================================================
-- TO_CHAR with alias
-- ============================================================
-- Для expression лучше давать alias.
--
-- Пример:
SELECT TO_CHAR(1234567, '9,999,999') AS number_text
FROM dual;

-- Alias:
--   number_text
--
-- Без alias output column может называться длинно:
--   TO_CHAR(1234567,'9,999,999')
--
-- С alias result set читать легче.


-- ============================================================
-- TO_CHAR in WHERE
-- ============================================================
-- TO_CHAR(number) можно использовать in WHERE condition.
--
-- Пример:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE TO_CHAR(salary, '999999') = '  10000';

-- Meaning:
--   salary is converted to formatted text;
--   comparison is text comparison.
--
-- Важно:
--   this is usually not the best way for numeric filtering.
--   For numeric logic, compare numbers as numbers.
--
-- Function in WHERE applies to rows.
-- В больших tables это может влиять on performance.


-- ============================================================
-- TO_CHAR returns text
-- ============================================================
-- Important:
--   TO_CHAR(number) returns VARCHAR2.
--
-- Пример:
SELECT TO_CHAR(2026) AS year_text
FROM dual;

-- Result:
--   2026
--
-- It appears as number,
-- but result is text.
--
-- This matters in comparisons and sorting.


-- ============================================================
-- Numeric logic vs display logic
-- ============================================================
-- If you need math, use NUMBER values.
--
-- If you need display, use TO_CHAR.
--
-- Пример:
SELECT salary AS number_salary,
       salary + 100 AS numeric_result,
       TO_CHAR(salary, '$999,999') AS display_salary
FROM employees;

-- salary + 100 is numeric calculation.
-- display_salary is text for output.


-- ============================================================
-- Common report formats
-- ============================================================
-- Some common output formats:
--
--   '999,999'
--   '999,999.99'
--   '$999,999.99'
--   'L999G999D99'
--   'FM999G999D00'
--
-- Examples:
SELECT TO_CHAR(1234567, '999,999,999') AS format_1,
       TO_CHAR(1234567.5, '999,999,999.99') AS format_2,
       TO_CHAR(1234567.5, '$999,999,999.99') AS format_3
FROM dual;


-- ============================================================
-- Common scenario: salary report
-- ============================================================
-- Частая задача:
--   show salary in readable report format.
--
-- Пример:
SELECT employee_id,
       first_name,
       salary,
       TO_CHAR(salary, '$999,999') AS salary_report
FROM employees;

-- Meaning:
--   salary remains NUMBER;
--   salary_report is formatted text.


-- ============================================================
-- Common scenario: calculated amount
-- ============================================================
-- Пример:
SELECT employee_id,
       salary,
       commission_pct,
       salary * commission_pct AS raw_commission,
       TO_CHAR(salary * commission_pct, '$999,999.99') AS commission_text
FROM employees;

-- Meaning:
--   raw_commission is numeric expression;
--   commission_text is formatted text.
--
-- If commission_pct is NULL,
-- expression result is NULL.


-- ============================================================
-- Common scenario: fixed code style number
-- ============================================================
-- Sometimes number should be shown with leading zeros.
--
-- Пример:
SELECT employee_id,
       TO_CHAR(employee_id, '000000') AS employee_code
FROM employees;

-- Meaning:
--   employee_id 105 becomes text such as 000105.


-- ============================================================
-- TO_CHAR and NULL
-- ============================================================
-- Если number_value is NULL,
-- result будет NULL.
--
-- Пример:
SELECT TO_CHAR(NULL, '999') AS number_text
FROM dual;

-- Result:
--   NULL
--
-- Если format_mask is NULL,
-- result тоже будет NULL.
--
-- Пример:
SELECT TO_CHAR(18, NULL) AS number_text
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- TO_CHAR does not change table data
-- ============================================================
-- SELECT with TO_CHAR shows converted output.
--
-- Пример:
SELECT salary AS original_salary,
       TO_CHAR(salary, '$999,999') AS salary_text
FROM employees;

-- original_salary is NUMBER column value.
-- salary_text is formatted text.
--
-- Table employees не изменяется.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что TO_CHAR changes NUMBER column.
--    Нет, it only returns text in result set.
--
-- 2. Думать, что TO_CHAR returns NUMBER.
--    Нет, TO_CHAR returns VARCHAR2.
--
-- 3. Делать format mask too narrow.
--    If number does not fit, output shows # characters.
--
-- 4. Путать 9 and 0.
--    9 allows blanks; 0 forces zeros.
--
-- 5. Путать D and dot.
--    D uses NLS decimal character.
--
-- 6. Путать G and comma.
--    G uses NLS group separator.
--
-- 7. Использовать formatted text for numeric logic.
--    For calculations, keep NUMBER values as NUMBER.
--
-- 8. Забывать FM.
--    Without FM, output can contain extra blanks.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Convert number to text without format:
SELECT TO_CHAR(18) AS result
FROM dual;

-- 2. Use 9 positions:
SELECT TO_CHAR(18, '99999') AS result
FROM dual;

-- 3. Use 0 positions:
SELECT TO_CHAR(18, '00000') AS result
FROM dual;

-- 4. Show decimal digits:
SELECT TO_CHAR(18.35, '999.99') AS result
FROM dual;

-- 5. Force decimal zeros:
SELECT TO_CHAR(18, '999.00') AS result
FROM dual;

-- 6. Use group separator:
SELECT TO_CHAR(1234567, '9,999,999') AS result
FROM dual;

-- 7. Use local decimal and group elements:
SELECT TO_CHAR(1234567.89, '9G999G999D99') AS result
FROM dual;

-- 8. Show dollar amount:
SELECT TO_CHAR(1234.5, '$999,999.99') AS result
FROM dual;

-- 9. Show sign:
SELECT TO_CHAR(-18, 'S099') AS result
FROM dual;

-- 10. Format employees salary:
SELECT employee_id,
       first_name,
       salary,
       TO_CHAR(salary, '$999,999') AS salary_text
FROM employees;


-- ============================================================
-- Mini summary
-- ============================================================
-- TO_CHAR for numbers converts NUMBER value to formatted text.
--
-- Syntax:
--   TO_CHAR(number_value, format_mask, nls_parameters)
--
-- Short syntax:
--   TO_CHAR(number_value)
--
-- Important:
--   result type is VARCHAR2;
--   format mask controls output text;
--   9 means optional digit position;
--   0 means forced zero position;
--   D means NLS decimal character;
--   G means NLS group separator;
--   $ shows dollar sign;
--   L shows local currency symbol;
--   MI, PR, S control sign display;
--   FM removes extra blanks;
--   narrow format returns # characters;
--   SELECT with TO_CHAR does not change table data.
