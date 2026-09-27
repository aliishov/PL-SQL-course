-- ============================================================
-- Conversion functions
-- TO_NUMBER
-- ============================================================
-- TO_NUMBER(text) - single-row conversion function.
--
-- Простыми словами:
--   TO_NUMBER converts text value to NUMBER value.
--
-- Result:
--   NUMBER
--
-- Важно:
--   TO_NUMBER does not format a number for output;
--   it reads text and creates a numeric value.
--
-- В этом уроке только TO_NUMBER.
-- TO_CHAR for numbers and other conversion functions
-- уже рассматриваются в отдельных темах.


-- ============================================================
-- Main idea
-- ============================================================
-- TO_NUMBER отвечает на вопрос:
--   "Как превратить text into real NUMBER?"
--
-- Пример:
SELECT TO_NUMBER('25') AS result
FROM dual;

-- Result:
--   25
--
-- Text '25' becomes NUMBER 25.
-- После преобразования result можно использовать
-- in calculations and numeric comparisons.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   TO_NUMBER(char_value, format_mask, nls_parameters)
--
-- Где:
--   char_value      - text that contains a number;
--   format_mask     - how this number is written in text;
--   nls_parameters  - optional settings for separators/currency.
--
-- Short syntax:
--
--   TO_NUMBER(char_value)
--
-- char_value is required.
-- format_mask and nls_parameters are optional.


-- ============================================================
-- TO_NUMBER without format mask
-- ============================================================
-- Simple numeric text can be converted without format mask.
--
-- Пример:
SELECT TO_NUMBER('25') AS result
FROM dual;

-- Decimal text can also be converted:
SELECT TO_NUMBER('25.12') AS result
FROM dual;

-- But decimal and group characters can depend
-- on NLS settings of the current session.
--
-- Therefore, when text contains separators or currency symbols,
-- explicit format_mask is clearer and safer.


-- ============================================================
-- Result is NUMBER
-- ============================================================
-- TO_NUMBER returns NUMBER, not text.
--
-- Пример:
SELECT TO_NUMBER('25') + 5 AS result
FROM dual;

-- Result:
--   30
--
-- Addition works because TO_NUMBER('25') returns numeric value.
--
-- Another example:
SELECT TO_NUMBER('3.14', '9.99') * 2 AS result
FROM dual;

-- Result:
--   6.28


-- ============================================================
-- Format mask describes input text
-- ============================================================
-- In TO_NUMBER, format mask describes
-- how the source text is written.
--
-- Text:
--   '4,444.18'
--
-- Matching mask:
--   '9,999.99'
--
-- Пример:
SELECT TO_NUMBER('4,444.18', '9,999.99') AS result
FROM dual;

-- Result:
--   4444.18
--
-- Comma and dot are part of the input format.
-- They are not stored inside NUMBER.


-- ============================================================
-- Main number format elements
-- ============================================================
-- Common elements used with TO_NUMBER:
--
--   9    - digit position;
--   0    - digit position that can describe a written zero;
--   .    - decimal point;
--   ,    - group separator;
--   D    - decimal character from NLS settings;
--   G    - group separator from NLS settings;
--   $    - dollar sign;
--   L    - local currency symbol;
--   S    - sign before or after the number;
--   MI   - trailing minus sign;
--   PR   - negative number inside angle brackets.
--
-- Format elements tell Oracle how to read char_value.


-- ============================================================
-- Currency symbol
-- ============================================================
-- If text contains dollar sign,
-- format mask must describe it.
--
-- Пример:
SELECT TO_NUMBER('$25123.14', '$99999.99') AS result
FROM dual;

-- Result:
--   25123.14
--
-- Dollar sign is removed during conversion.
-- Result is regular NUMBER.
--
-- Local currency can be described with L:
SELECT TO_NUMBER('$125.50',
                 'L999D99',
                 'NLS_NUMERIC_CHARACTERS = ''.,'' NLS_CURRENCY = ''$''') AS result
FROM dual;

-- L uses the currency symbol from NLS_CURRENCY.


-- ============================================================
-- Group and decimal separators
-- ============================================================
-- A number written as text may contain:
--   group separator;
--   decimal separator.
--
-- Пример with literal comma and dot:
SELECT TO_NUMBER('4,444.18', '9,999.99') AS result
FROM dual;

-- Meaning:
--   comma separates digit groups;
--   dot separates integer and decimal parts.
--
-- Result:
--   4444.18


-- ============================================================
-- D and G format elements
-- ============================================================
-- D means decimal character from NLS settings.
-- G means group character from NLS settings.
--
-- Пример:
SELECT TO_NUMBER('4,444.18',
                 '9G999D99',
                 'NLS_NUMERIC_CHARACTERS = ''.,''') AS result
FROM dual;

-- In third argument:
--   first character  = decimal character;
--   second character = group character.
--
-- Here:
--   decimal character = dot;
--   group character   = comma.


-- ============================================================
-- Different separator convention
-- ============================================================
-- Some text uses comma for decimals
-- and dot for digit groups.
--
-- Пример:
SELECT TO_NUMBER('4.444,18',
                 '9G999D99',
                 'NLS_NUMERIC_CHARACTERS = '',.''') AS result
FROM dual;

-- Here:
--   decimal character = comma;
--   group character   = dot.
--
-- Result is still the same numeric value:
--   4444.18
--
-- NLS parameters make conversion independent
-- from session defaults for this function call.


-- ============================================================
-- Negative numbers
-- ============================================================
-- A regular minus sign can be converted as part of number text.
--
-- Пример:
SELECT TO_NUMBER('-125.50', 'S999D99',
                 'NLS_NUMERIC_CHARACTERS = ''.,''') AS result
FROM dual;

-- Result:
--   -125.5
--
-- S tells Oracle to read the sign.


-- ============================================================
-- PR format element
-- ============================================================
-- In some reports, negative values are written
-- inside angle brackets.
--
-- Пример:
SELECT TO_NUMBER('<4,444.18>', '9,999.99PR') AS result
FROM dual;

-- Result:
--   -4444.18
--
-- PR means:
--   angle brackets represent a negative value.
--
-- This is useful when text comes from a formatted report.


-- ============================================================
-- MI format element
-- ============================================================
-- MI describes a minus sign written after the number.
--
-- Пример:
SELECT TO_NUMBER('125.50-', '999.99MI') AS result
FROM dual;

-- Result:
--   -125.5
--
-- Without MI, Oracle does not know that trailing minus
-- is part of the numeric format.


-- ============================================================
-- TO_NUMBER and TO_CHAR are opposite directions
-- ============================================================
-- TO_CHAR(number) converts NUMBER to text.
-- TO_NUMBER(text) converts text to NUMBER.
--
-- Пример:
SELECT TO_CHAR(3.14, '9.99') AS number_text,
       TO_NUMBER('3.14', '9.99') AS numeric_value
FROM dual;

-- number_text:
--   VARCHAR2 result for display.
--
-- numeric_value:
--   NUMBER result for calculations.
--
-- They may look similar on screen,
-- but their data types and purposes are different.


-- ============================================================
-- Avoid implicit conversion
-- ============================================================
-- Oracle can sometimes convert numeric text automatically.
-- This is implicit conversion.
--
-- Example with text on the right side:
SELECT e.employee_id,
       e.first_name,
       e.salary
FROM employees e
WHERE e.salary > '10000';

-- It may work because Oracle tries to convert text to NUMBER.
-- But explicit conversion shows the intended data type clearly.
--
-- Better:
SELECT e.employee_id,
       e.first_name,
       e.salary
FROM employees e
WHERE e.salary > TO_NUMBER('10000');

-- If text has formatting, format mask is especially important:
SELECT e.employee_id,
       e.first_name,
       e.salary
FROM employees e
WHERE e.salary > TO_NUMBER('$10,000', '$99,999');


-- ============================================================
-- TO_NUMBER in calculations
-- ============================================================
-- Converted text can participate in numeric expressions.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.salary + TO_NUMBER('500') AS increased_salary
FROM employees e;

-- TO_NUMBER('500') becomes NUMBER 500,
-- then Oracle performs numeric addition.


-- ============================================================
-- TO_NUMBER in WHERE
-- ============================================================
-- TO_NUMBER is useful when a numeric boundary
-- arrives as formatted text.
--
-- Пример:
SELECT e.employee_id,
       e.first_name,
       e.salary
FROM employees e
WHERE e.salary >= TO_NUMBER('5,000', '9,999');

-- Left side is NUMBER column.
-- Right side becomes NUMBER after conversion.
-- Comparison is numeric.


-- ============================================================
-- Spaces around numeric text
-- ============================================================
-- Oracle can read surrounding spaces in simple numeric text.
--
-- Пример:
SELECT TO_NUMBER('   250   ') AS result
FROM dual;

-- Result:
--   250
--
-- Spaces inside a number are different:
-- they must match a valid format or conversion will fail.


-- ============================================================
-- NULL
-- ============================================================
-- If char_value is NULL,
-- result is NULL.
--
-- Пример:
SELECT TO_NUMBER(NULL) AS result
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- Invalid numeric text
-- ============================================================
-- Text must represent a valid number
-- and must match the format mask.
--
-- Invalid example:
-- SELECT TO_NUMBER('twenty-five') AS result
-- FROM dual;
--
-- This causes conversion error because the text
-- does not contain a numeric value.
--
-- Another invalid example:
-- SELECT TO_NUMBER('$1,250.50', '9,999.99') AS result
-- FROM dual;
--
-- The text contains $, but format mask does not.
-- A matching mask would be:
--   '$9,999.99'


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Writing TO_NUBER instead of TO_NUMBER.
--    Correct function name is TO_NUMBER.
--
-- 2. Thinking that TO_NUMBER formats output.
--    No, TO_NUMBER creates NUMBER from text.
--
-- 3. Passing non-numeric text.
--    Text must represent a valid numeric value.
--
-- 4. Using a format mask that does not match input text.
--    Currency signs and separators must be described correctly.
--
-- 5. Ignoring NLS numeric settings.
--    Dot and comma can have different meanings in different sessions.
--
-- 6. Confusing TO_NUMBER with TO_CHAR.
--    TO_NUMBER: text -> NUMBER.
--    TO_CHAR: NUMBER -> text.
--
-- 7. Applying TO_NUMBER to an existing NUMBER column.
--    Numeric column is already NUMBER and needs no conversion.
--
-- 8. Comparing a NUMBER column with formatted text directly.
--    Convert formatted text explicitly with TO_NUMBER.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Convert simple text '750' to NUMBER.
SELECT TO_NUMBER('750') AS result
FROM dual;

-- 2. Convert text '$2,450.75' to NUMBER.
SELECT TO_NUMBER('$2,450.75', '$9,999.99') AS result
FROM dual;

-- 3. Convert '<1,250.50>' to a negative NUMBER.
SELECT TO_NUMBER('<1,250.50>', '9,999.99PR') AS result
FROM dual;

-- 4. Show employees whose salary is greater than text value '10000'.
SELECT e.employee_id,
       e.first_name,
       e.salary
FROM employees e
WHERE e.salary > TO_NUMBER('10000');

-- 5. Show employees whose salary is at least formatted value '$5,000'.
SELECT e.employee_id,
       e.first_name,
       e.salary
FROM employees e
WHERE e.salary >= TO_NUMBER('$5,000', '$9,999');

-- 6. Add text value '300' to every employee salary.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.salary + TO_NUMBER('300') AS increased_salary
FROM employees e;

-- 7. Subtract formatted text value '1,000' from salary.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.salary - TO_NUMBER('1,000', '9,999') AS reduced_salary
FROM employees e;

-- 8. Show employees whose commission_pct is greater than text '0.20'.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct
FROM employees e
WHERE e.commission_pct > TO_NUMBER('0.20', '9D99',
                                   'NLS_NUMERIC_CHARACTERS = ''.,''');

-- 9. Multiply salary by numeric value converted from text '1.10'.
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.salary * TO_NUMBER('1.10', '9D99',
                            'NLS_NUMERIC_CHARACTERS = ''.,''') AS new_salary
FROM employees e;

-- 10. Show employees whose salary is between two converted text values.
SELECT e.employee_id,
       e.first_name,
       e.salary
FROM employees e
WHERE e.salary >= TO_NUMBER('5,000', '99,999')
  AND e.salary <= TO_NUMBER('15,000', '99,999');


-- ============================================================
-- Mini summary
-- ============================================================
-- TO_NUMBER converts text to NUMBER.
--
-- Syntax:
--   TO_NUMBER(char_value, format_mask, nls_parameters)
--
-- Important:
--   result type is NUMBER;
--   format mask describes input text;
--   converted value can be used in calculations and comparisons;
--   currency symbols and separators must match the format mask;
--   D and G use NLS numeric characters;
--   PR reads negative values inside angle brackets;
--   MI reads a trailing minus sign;
--   TO_NUMBER and TO_CHAR convert in opposite directions;
--   explicit conversion is clearer than implicit conversion;
--   invalid numeric text causes a conversion error.
