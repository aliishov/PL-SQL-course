-- ============================================================
-- Operator priority
-- ============================================================
-- Operator priority / precedence - порядок,
-- в котором Oracle вычисляет expressions и conditions.
--
-- Простыми словами:
--   если в WHERE есть несколько operators,
--   Oracle не читает их просто слева направо.
--
-- Oracle учитывает priority:
--   что вычислить раньше;
--   что вычислить позже.
--
-- Главная идея урока:
--   если condition сложный,
--   используй parentheses ().
--
-- Parentheses делают query понятным
-- и для Oracle,
-- и для человека.


-- ============================================================
-- Simplified priority list
-- ============================================================
-- Упрощенный порядок для этого курса:
--
--   1.  ()
--   2.  * /
--   3.  + - ||
--   4.  = > < >= <= != <>
--   5.  LIKE, IN, BETWEEN, IS NULL
--   6.  NOT
--   7.  AND
--   8.  OR
--
-- Важно:
--   Parentheses имеют самый высокий priority.
--
-- Поэтому:
--   (condition1 OR condition2) AND condition3
--
-- и:
--   condition1 OR condition2 AND condition3
--
-- могут дать разный result set.


-- ============================================================
-- Parentheses ()
-- ============================================================
-- Parentheses заставляют Oracle сначала вычислить то,
-- что находится внутри ().
--
-- Example:
SELECT *
FROM employees
WHERE (first_name LIKE '__n%' AND commission_pct IS NULL)
   OR (first_name LIKE 'A%' AND job_id = 'SA_REP');

-- Meaning:
--   row подходит, если:
--
--   group 1:
--     first_name подходит под pattern '__n%'
--     и commission_pct отсутствует
--
--   или group 2:
--     first_name начинается с A
--     и job_id равен 'SA_REP'
--
-- Parentheses показывают две отдельные logic groups.


-- ============================================================
-- Arithmetic priority
-- ============================================================
-- В arithmetic expressions:
--
--   * и / выполняются раньше,
--   чем + и -.
--
-- Example:
SELECT first_name,
       salary,
       employee_id
FROM employees
WHERE salary > employee_id * 50;

-- В expression:
--   salary > employee_id * 50
--
-- Oracle сначала вычисляет:
--   employee_id * 50
--
-- Потом сравнивает:
--   salary > result
--
-- Если нужен другой порядок,
-- используй parentheses.
--
-- Example:
SELECT first_name,
       salary,
       employee_id
FROM employees
WHERE salary > (employee_id + 10) * 50;

-- Здесь сначала:
--   employee_id + 10
--
-- Потом:
--   result * 50
--
-- Потом:
--   salary > result


-- ============================================================
-- Concatenation priority
-- ============================================================
-- || соединяет text values.
--
-- Example:
SELECT first_name || ' ' || last_name AS full_name
FROM employees;

-- Если expression смешивает concatenation и arithmetic,
-- лучше использовать parentheses,
-- чтобы смысл был очевиден.
--
-- Example:
SELECT first_name || ' annual salary = ' || (salary * 12) AS employee_info
FROM employees;

-- Здесь:
--   salary * 12 считается внутри parentheses;
--   потом result соединяется с text.
--
-- Parentheses делают expression легче читать.


-- ============================================================
-- Comparison priority
-- ============================================================
-- Comparison operators создают condition:
--
--   =
--   >
--   <
--   >=
--   <=
--   !=
--   <>
--
-- Example:
SELECT *
FROM employees
WHERE salary > employee_id * 50;

-- Oracle сначала вычисляет arithmetic expression:
--   employee_id * 50
--
-- Потом comparison:
--   salary > calculated_value
--
-- Еще example:
SELECT *
FROM employees
WHERE job_id = 'SA_REP';

-- Здесь comparison проверяет,
-- равен ли job_id значению 'SA_REP'.


-- ============================================================
-- Special conditions priority
-- ============================================================
-- Эти conditions обычно вычисляются до logical operators:
--
--   LIKE
--   IN
--   BETWEEN
--   IS NULL
--   IS NOT NULL
--
-- Example:
SELECT *
FROM employees
WHERE first_name LIKE '__n%'
  AND commission_pct IS NULL;

-- Oracle понимает это как:
--   (first_name LIKE '__n%')
--   AND
--   (commission_pct IS NULL)
--
-- Example:
SELECT *
FROM employees
WHERE job_id IN ('IT_PROG', 'PU_CLERK')
   OR commission_pct IS NULL;

-- Oracle понимает это как:
--   (job_id IN ('IT_PROG', 'PU_CLERK'))
--   OR
--   (commission_pct IS NULL)


-- ============================================================
-- NOT priority
-- ============================================================
-- NOT выполняется раньше AND и OR.
--
-- Example:
SELECT *
FROM employees
WHERE NOT (job_id = 'IT_PROG')
  AND department_id = 60;

-- Meaning:
--   job_id не равен 'IT_PROG'
--   и department_id равен 60.
--
-- Хорошая практика:
--   с NOT часто использовать parentheses.
--
-- Example:
SELECT *
FROM employees
WHERE NOT (salary BETWEEN 4000 AND 10000);

-- Parentheses ясно показывают,
-- какое condition переворачивает NOT.


-- ============================================================
-- AND priority
-- ============================================================
-- AND выполняется раньше OR.
--
-- Это очень важное правило.
--
-- Example without parentheses:
SELECT *
FROM employees
WHERE first_name LIKE '__n%'
  AND commission_pct IS NULL
   OR first_name LIKE 'A%'
  AND job_id = 'SA_REP';

-- Oracle читает это как:
--   (first_name LIKE '__n%' AND commission_pct IS NULL)
--   OR
--   (first_name LIKE 'A%' AND job_id = 'SA_REP')
--
-- Почему?
--   Потому что AND имеет higher priority than OR.
--
-- Лучше написать явно:
SELECT *
FROM employees
WHERE (first_name LIKE '__n%' AND commission_pct IS NULL)
   OR (first_name LIKE 'A%' AND job_id = 'SA_REP');

-- Так query легче понять.


-- ============================================================
-- OR priority
-- ============================================================
-- OR имеет lower priority than AND.
--
-- Поэтому OR часто лучше группировать parentheses,
-- если рядом есть AND.
--
-- Example:
SELECT *
FROM employees
WHERE ((first_name LIKE '__n%' AND commission_pct IS NULL)
    OR first_name LIKE 'A%')
  AND job_id = 'SA_REP';

-- Meaning:
--   сначала проверяется group:
--     first_name LIKE '__n%' AND commission_pct IS NULL
--     или first_name LIKE 'A%'
--
--   потом весь group должен сочетаться с:
--     job_id = 'SA_REP'
--
-- Parentheses меняют grouping,
-- поэтому result может отличаться от query без parentheses.


-- ============================================================
-- Example 1: without explicit parentheses
-- ============================================================
-- Query:
SELECT first_name,
       last_name,
       salary,
       department_id,
       job_id,
       commission_pct
FROM employees
WHERE last_name LIKE '%i%'
  AND salary > employee_id * 50
   OR job_id IN ('IT_PROG', 'PU_CLERK')
  AND commission_pct IS NULL;

-- Because AND has higher priority than OR,
-- Oracle reads it like this:
--
--   (last_name LIKE '%i%' AND salary > employee_id * 50)
--   OR
--   (job_id IN ('IT_PROG', 'PU_CLERK') AND commission_pct IS NULL)
--
-- Чтобы человек не гадал,
-- лучше написать parentheses явно.


-- ============================================================
-- Example 1: with explicit parentheses
-- ============================================================
SELECT first_name,
       last_name,
       salary,
       department_id,
       job_id,
       commission_pct
FROM employees
WHERE (last_name LIKE '%i%' AND salary > employee_id * 50)
   OR (job_id IN ('IT_PROG', 'PU_CLERK') AND commission_pct IS NULL);

-- Этот query делает то же самое,
-- но читается намного понятнее.


-- ============================================================
-- Example 2: different grouping
-- ============================================================
-- Query:
SELECT first_name,
       last_name,
       salary,
       department_id,
       job_id,
       commission_pct
FROM employees
WHERE last_name LIKE '%i%'
   OR salary > employee_id * 50
  AND job_id IN ('IT_PROG', 'PU_CLERK')
   OR commission_pct IS NULL;

-- Oracle reads it like this:
--
--   last_name LIKE '%i%'
--   OR
--   (salary > employee_id * 50 AND job_id IN ('IT_PROG', 'PU_CLERK'))
--   OR
--   commission_pct IS NULL
--
-- Because:
--   AND is evaluated before OR.


-- ============================================================
-- Example 2: with explicit parentheses
-- ============================================================
SELECT first_name,
       last_name,
       salary,
       department_id,
       job_id,
       commission_pct
FROM employees
WHERE (last_name LIKE '%i%')
   OR (salary > employee_id * 50 AND job_id IN ('IT_PROG', 'PU_CLERK'))
   OR (commission_pct IS NULL);

-- Parentheses do not always change result.
-- Sometimes they only make the same logic easier to read.
--
-- Но если grouping другой,
-- result может измениться.


-- ============================================================
-- Example 3: parentheses change meaning
-- ============================================================
-- Without parentheses:
SELECT employee_id,
       first_name,
       salary,
       department_id
FROM employees
WHERE salary > 10000
   OR department_id = 90
  AND job_id = 'SA_REP';

-- Oracle reads it like this:
--   salary > 10000
--   OR
--   (department_id = 90 AND job_id = 'SA_REP')
--
-- With parentheses:
SELECT employee_id,
       first_name,
       salary,
       department_id
FROM employees
WHERE (salary > 10000 OR department_id = 90)
  AND job_id = 'SA_REP';

-- Meaning changed:
--   сначала salary > 10000 или department_id = 90;
--   потом обязательно job_id = 'SA_REP'.
--
-- Это может вернуть другой result set.


-- ============================================================
-- Good practice
-- ============================================================
-- Если в WHERE есть только AND:
--   parentheses часто не обязательны.
--
-- Example:
SELECT employee_id,
       first_name,
       salary,
       department_id
FROM employees
WHERE salary > 10000
  AND department_id = 90
  AND job_id = 'SA_REP';

-- Если в WHERE есть только OR:
--   parentheses часто не обязательны.
--
-- Example:
SELECT employee_id,
       first_name,
       department_id
FROM employees
WHERE department_id = 10
   OR department_id = 20
   OR department_id = 30;

-- Если AND и OR смешаны:
--   лучше ставить parentheses.
--
-- Example:
SELECT employee_id,
       first_name,
       salary,
       department_id
FROM employees
WHERE (salary > 10000 OR department_id = 90)
  AND job_id = 'SA_REP';


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что Oracle всегда читает WHERE слева направо.
--    На самом деле Oracle учитывает operator priority.
--
-- 2. Забывать, что AND выполняется раньше OR.
--
-- 3. Не использовать parentheses в сложных conditions.
--
-- 4. Думать, что parentheses только для mathematics.
--    В WHERE parentheses очень важны для logical grouping.
--
-- 5. Писать query, который работает,
--    но его сложно прочитать через неделю.
--
-- 6. Ошибаться в string literal.
--
--    Правильно:
--      'IT_PROG'
--
--    Неправильно:
--      'IT_ROG'


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Объясни порядок:
--     salary > employee_id * 50
--
--   Что считается первым?
--
-- Task 2:
--   Объясни, как Oracle прочитает:
--
--     salary > 10000
--     OR department_id = 90
--     AND job_id = 'SA_REP'
--
-- Task 3:
--   Перепиши Task 2 с parentheses так,
--   чтобы logic была видна явно.
--
-- Task 4:
--   Напиши query:
--     salary > 10000 или department_id = 90,
--     и обязательно job_id = 'SA_REP'.
--
-- Task 5:
--   Напиши query:
--     last_name содержит i
--     и salary больше employee_id * 50,
--     или job_id находится в списке 'IT_PROG', 'PU_CLERK'
--     и commission_pct отсутствует.
--
--   Используй parentheses.
--
-- Task 6:
--   Объясни своими словами:
--     зачем нужны parentheses;
--     почему AND выполняется раньше OR;
--     почему сложные WHERE conditions лучше группировать явно.


-- ============================================================
-- Summary
-- ============================================================
-- Operator priority помогает Oracle понять,
-- что вычислять раньше.
--
-- Самое важное для WHERE:
--   () first
--   NOT before AND
--   AND before OR
--
-- Главное правило:
--   Если condition сложный,
--   не надейся на память о priority.
--   Используй parentheses.
