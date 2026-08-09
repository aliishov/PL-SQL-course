-- ============================================================
-- NOT operator
-- ============================================================
-- NOT           - logical operator, который меняет результат condition
--                 на противоположный.
--
-- Простыми словами:
--   NOT означает "не".
--
-- NOT используется в WHERE,
-- когда нужно выбрать rows,
-- которые не подходят под указанное condition.
--
-- Синтаксис:
--   SELECT column_name1,
--          column_name2
--   FROM table_name
--   WHERE NOT condition;
--
-- Главное правило:
--   NOT TRUE  = FALSE
--   NOT FALSE = TRUE
--
-- Если condition подходит,
-- NOT делает его неподходящим.
--
-- Если condition не подходит,
-- NOT делает его подходящим.


-- ============================================================
-- NOT with simple comparison
-- ============================================================
-- Example:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE NOT (salary = 17000);

-- Meaning:
--   показать employees,
--   у которых salary не равен 17000.
--
-- Oracle сначала проверяет:
--   salary = 17000
--
-- Потом NOT переворачивает result:
--   если salary = 17000, row убирается;
--   если salary не равен 17000, row остается.
--
-- Такой query похож по смыслу на:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE salary <> 17000;

-- В обычном коде для "не равно" часто пишут <>.
-- Но NOT помогает понять общую logic:
--   NOT переворачивает condition.


-- ============================================================
-- NOT with text comparison
-- ============================================================
-- Example:
SELECT employee_id,
       first_name,
       job_id
FROM employees
WHERE NOT (job_id = 'IT_PROG');

-- Meaning:
--   показать employees,
--   у которых job_id не равен 'IT_PROG'.
--
-- Text values пишутся в single quotes.
--
-- Более короткий вариант:
SELECT employee_id,
       first_name,
       job_id
FROM employees
WHERE job_id <> 'IT_PROG';

-- Оба examples показывают идею "не равно",
-- но первый показывает именно работу NOT.


-- ============================================================
-- NOT with date comparison
-- ============================================================
-- Example:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE NOT (hire_date = TO_DATE('2005-01-01', 'YYYY-MM-DD'));

-- Meaning:
--   показать employees,
--   у которых hire_date не равен 01 January 2005.
--
-- Для dates лучше использовать TO_DATE
-- с явным format mask.


-- ============================================================
-- NOT with parentheses
-- ============================================================
-- Parentheses помогают явно показать,
-- какое condition переворачивает NOT.
--
-- Example:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE NOT (salary = 17000);

-- Meaning:
--   не salary = 17000.
--
-- Это читается понятнее,
-- если condition длиннее или сложнее.
--
-- Простое правило:
--   если сомневаешься, поставь parentheses.
--
-- Example:
SELECT employee_id,
       first_name,
       department_id
FROM employees
WHERE NOT (department_id = 90);

-- Meaning:
--   показать employees,
--   у которых department_id не равен 90.


-- ============================================================
-- NOT with LIKE
-- ============================================================
-- NOT можно использовать с LIKE,
-- чтобы выбрать text values, которые не подходят под pattern.
--
-- Example:
SELECT employee_id,
       first_name
FROM employees
WHERE first_name NOT LIKE 'S%';

-- Meaning:
--   показать employees,
--   у которых first_name не начинается с S.
--
-- То же самое можно написать так:
SELECT employee_id,
       first_name
FROM employees
WHERE NOT (first_name LIKE 'S%');

-- В учебном коде чаще читается лучше:
--   first_name NOT LIKE 'S%'
--
-- Здесь LIKE уже отдельная тема.
-- В этом уроке главное:
--   NOT переворачивает результат LIKE pattern.


-- ============================================================
-- NOT with IN
-- ============================================================
-- NOT можно использовать с IN,
-- чтобы выбрать values, которых нет в списке.
--
-- Example:
SELECT employee_id,
       first_name,
       department_id
FROM employees
WHERE department_id NOT IN (60, 90);

-- Meaning:
--   показать employees,
--   у которых department_id не равен 60
--   и не равен 90.
--
-- То же самое можно написать так:
SELECT employee_id,
       first_name,
       department_id
FROM employees
WHERE NOT (department_id IN (60, 90));

-- В учебном коде чаще читается лучше:
--   department_id NOT IN (60, 90)
--
-- Важно:
--   NOT IN с NULL в списке может давать неожиданный result.
--   Подробнее это обычно разбирают отдельно,
--   когда изучают NULL глубже.


-- ============================================================
-- NOT with BETWEEN
-- ============================================================
-- NOT можно использовать с BETWEEN,
-- чтобы выбрать values вне диапазона.
--
-- Example:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE salary NOT BETWEEN 4000 AND 10000;

-- Meaning:
--   показать employees,
--   у которых salary не находится в диапазоне
--   от 4000 до 10000 включительно.
--
-- То есть подходят values:
--   меньше 4000;
--   больше 10000.
--
-- То же самое можно написать так:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE NOT (salary BETWEEN 4000 AND 10000);

-- В учебном коде чаще читается лучше:
--   salary NOT BETWEEN 4000 AND 10000
--
-- Слово AND здесь является частью BETWEEN syntax.


-- ============================================================
-- IS NOT NULL
-- ============================================================
-- Для NULL используется специальная форма:
--   IS NOT NULL
--
-- Example:
SELECT employee_id,
       first_name,
       commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

-- Meaning:
--   показать employees,
--   у которых commission_pct заполнен.
--
-- Важно:
--   Для NULL нельзя надежно писать:
--     NOT commission_pct = NULL
--
-- Правильно:
--   commission_pct IS NOT NULL
--
-- IS NULL / IS NOT NULL уже отдельная тема.
-- Здесь важно увидеть,
-- что NOT участвует в форме IS NOT NULL.


-- ============================================================
-- Truth table
-- ============================================================
-- NOT работает так:
--
--   condition | NOT condition
--   ----------+--------------
--   TRUE      | FALSE
--   FALSE     | TRUE
--
-- В WHERE row попадает в result set,
-- когда final condition TRUE.
--
-- Example:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE NOT (salary = 17000);

-- Если salary = 17000:
--   salary = 17000 -> TRUE
--   NOT TRUE       -> FALSE
--   row не попадает в result set.
--
-- Если salary = 9000:
--   salary = 17000 -> FALSE
--   NOT FALSE      -> TRUE
--   row попадает в result set.


-- ============================================================
-- Formatting NOT
-- ============================================================
-- Однострочный query:
SELECT employee_id, first_name, salary FROM employees WHERE NOT (salary = 17000);

-- Работает, но читается хуже.
--
-- Лучше:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE NOT (salary = 17000);

-- Еще лучше для "не равно":
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE salary <> 17000;

-- Хорошая привычка:
--   если NOT стоит перед condition,
--   используй parentheses для читаемости.
--
-- Для специальных forms часто читается лучше:
--   NOT LIKE
--   NOT IN
--   NOT BETWEEN
--   IS NOT NULL


-- ============================================================
-- Simple examples
-- ============================================================
-- NOT with number:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE NOT (salary = 17000);

-- NOT with text:
SELECT employee_id,
       first_name,
       job_id
FROM employees
WHERE NOT (job_id = 'IT_PROG');

-- NOT with date:
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE NOT (hire_date = TO_DATE('2005-01-01', 'YYYY-MM-DD'));

-- NOT LIKE:
SELECT employee_id,
       first_name
FROM employees
WHERE first_name NOT LIKE 'S%';

-- NOT IN:
SELECT employee_id,
       first_name,
       department_id
FROM employees
WHERE department_id NOT IN (60, 90);

-- NOT BETWEEN:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE salary NOT BETWEEN 4000 AND 10000;

-- IS NOT NULL:
SELECT employee_id,
       first_name,
       commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что NOT просто означает "не равно".
--    NOT шире: он переворачивает любое condition.
--
-- 2. Забывать parentheses.
--
--    Менее понятно:
--      WHERE NOT salary = 17000
--
--    Понятнее:
--      WHERE NOT (salary = 17000)
--
-- 3. Проверять NULL через NOT column = NULL.
--
--    Неправильно:
--      WHERE NOT commission_pct = NULL
--
--    Правильно:
--      WHERE commission_pct IS NOT NULL
--
-- 4. Путать NOT LIKE и обычный LIKE.
--
--    LIKE показывает rows, которые подходят под pattern.
--    NOT LIKE показывает rows, которые не подходят под pattern.
--
-- 5. Использовать NOT там, где проще прочитать обычный operator.
--
--    Вместо:
--      NOT (salary = 17000)
--
--    часто проще:
--      salary <> 17000


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Выведи employees,
--   у которых salary не равен 17000.
--   Используй NOT.
--
-- Task 2:
--   Выведи employees,
--   у которых job_id не равен 'IT_PROG'.
--   Используй NOT.
--
-- Task 3:
--   Выведи employees,
--   у которых hire_date не равен 2005-01-01.
--   Используй TO_DATE.
--
-- Task 4:
--   Выведи employees,
--   у которых first_name не начинается с S.
--
-- Task 5:
--   Выведи employees,
--   у которых department_id не находится в списке:
--     60
--     90
--
-- Task 6:
--   Выведи employees,
--   у которых salary не находится между 4000 и 10000.
--
-- Task 7:
--   Выведи employees,
--   у которых commission_pct заполнен.
--
-- Task 8:
--   Объясни своими словами:
--     что делает NOT;
--     зачем нужны parentheses;
--     чем NOT LIKE отличается от LIKE;
--     почему для NULL используют IS NOT NULL.


-- ============================================================
-- Summary
-- ============================================================
-- NOT:
--   logical operator;
--   используется в WHERE;
--   переворачивает condition;
--   TRUE делает FALSE;
--   FALSE делает TRUE.
--
-- Частые формы:
--   NOT (condition)
--   NOT LIKE
--   NOT IN
--   NOT BETWEEN
--   IS NOT NULL
--
-- Главное:
--   NOT выбирает rows,
--   которые не подходят под указанное condition.
