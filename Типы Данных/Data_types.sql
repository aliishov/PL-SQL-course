-- ============================================================
-- Oracle PL/SQL Data Types
-- ============================================================
-- Тип данных говорит Oracle:
--   1. какие значения можно хранить;
--   2. сколько памяти примерно нужно;
--   3. какие операции разрешены;
--   4. как Oracle будет сравнивать, округлять и преобразовывать значение.
--
-- В PL/SQL типы используются при объявлении переменных, констант,
-- параметров процедур/функций, record-структур, коллекций и курсоров.
--
-- Общий синтаксис объявления:
--   variable_name data_type;
--   variable_name data_type := initial_value;
--   variable_name data_type DEFAULT initial_value;
--   variable_name data_type NOT NULL := initial_value;
--
-- Пример:
--   v_employee_id NUMBER(10);
--   v_first_name  VARCHAR2(50) := 'Ali';
--   v_created_at  DATE DEFAULT SYSDATE;
--   v_is_active   BOOLEAN NOT NULL := TRUE;
--
-- Важно:
--   SQL-типы используются в таблицах и SQL-запросах.
--   PL/SQL-типы используются внутри PL/SQL-кода.
--   Некоторые PL/SQL-типы нельзя напрямую хранить в таблицах.
--
-- Перед запуском примеров с DBMS_OUTPUT:
   SET SERVEROUTPUT ON;


-- ============================================================
-- Numeric data types
-- ============================================================
-- NUMBER        - Основной числовой тип Oracle.
--                 Хранит целые и дробные числа.
--                 Можно использовать без точности:
--                   NUMBER
--                 или с точностью и масштабом:
--                   NUMBER(p, s)
--
-- NUMBER(p, s)  - Число с precision и scale.
--                 p(precision) - максимальное количество значащих цифр.
--                 s(scale)     - сколько цифр отводится на дробную часть.
--
--                 Примеры:
--                   NUMBER(5)     - максимум 5 цифр: 12345
--                   NUMBER(5, 2)  - 5 цифр всего, 2 после точки: 123.45
--                   NUMBER(3, 2)  - 3 цифры всего, 2 после точки: 1.23
--                   NUMBER(10, 0) - целое число до 10 цифр
--
--                 Частая ошибка:
--                   NUMBER(3, 2) не значит "3 цифры до точки и 2 после".
--                   Это значит "3 цифры всего, из них 2 после точки".
--
-- INTEGER       - Целое число.
--                 В Oracle обычно является подтипом NUMBER.
--                 Удобно читать, когда по смыслу дробная часть не нужна.
--                 Примеры: 1, 2, 3, 100, -50
--
-- INT           - Сокращенная форма INTEGER.
--                 В учебном коде лучше писать INTEGER или NUMBER(10),
--                 чтобы смысл был понятнее.
--
-- SMALLINT      - Небольшое целое число.
--                 В Oracle это тоже числовой тип из семейства NUMBER.
--
-- DECIMAL(p, s) - Десятичное число.
--                 Похоже на NUMBER(p, s).
--                 Часто встречается в ANSI SQL.
--
-- NUMERIC(p, s) - Десятичное число.
--                 Похоже на NUMBER(p, s).
--
-- FLOAT         - Число с плавающей точкой.
--                 Используется реже, чем NUMBER.
--                 Для денег, количества товаров и точных расчетов
--                 обычно лучше NUMBER(p, s), а не FLOAT.
--
-- BINARY_FLOAT  - 32-bit число с плавающей точкой.
--                 Быстрее для некоторых научных/приближенных расчетов,
--                 но не подходит для точных денежных значений.
--
-- BINARY_DOUBLE - 64-bit число с плавающей точкой.
--                 Может хранить очень большие/маленькие приближенные числа.
--                 Тоже не лучший выбор для денег.
--
-- PLS_INTEGER   - PL/SQL-тип для целых чисел.
--                 Работает внутри PL/SQL, часто быстрее NUMBER для счетчиков.
--                 Подходит для циклов, индексов, счетчиков, флагов-чисел.
--
-- BINARY_INTEGER - Старый PL/SQL-тип для целых чисел.
--                  Во многих случаях вместо него используют PLS_INTEGER.
--
-- NATURAL       - PL/SQL-подтип для неотрицательных целых чисел.
--                 Значения: 0, 1, 2, 3 ...
--
-- POSITIVE      - PL/SQL-подтип для положительных целых чисел.
--                 Значения: 1, 2, 3 ...
--
-- SIGNTYPE      - PL/SQL-подтип для знака числа.
--                 Обычно используется для -1, 0, 1.
--
-- SIMPLE_INTEGER - PL/SQL-тип для целых чисел NOT NULL.
--                  Используется, когда нужна максимальная скорость
--                  и ты точно не работаешь с NULL.
--                  Для обычного учебного кода чаще достаточно PLS_INTEGER.
--
-- Когда что выбирать:
--   NUMBER(10)      - id, количество, целое значение в таблице.
--   NUMBER(10, 2)   - деньги, цена, сумма.
--   PLS_INTEGER     - счетчик цикла внутри PL/SQL.
--   BINARY_DOUBLE   - приближенные научные расчеты.
--
-- Примеры объявлений:
--   v_id          NUMBER(10);
--   v_salary      NUMBER(9, 2) := 2500.50;
--   v_percent     NUMBER(5, 2) := 12.75;
--   v_counter     PLS_INTEGER := 0;
--   v_temperature BINARY_DOUBLE := 36.6;
--
-- Пример блока:
   DECLARE
     v_price    NUMBER(8, 2) := 199.99;
     v_quantity PLS_INTEGER := 3;
     v_total    NUMBER(10, 2);
   BEGIN
     v_total := v_price * v_quantity;
     DBMS_OUTPUT.PUT_LINE('Total = ' || v_total);
   END;
--   /


-- ============================================================
-- Alpha-numeric / Character data types
-- ============================================================
-- CHAR(length)      - Строка фиксированной длины.
--                     Если записать меньше символов, Oracle дополняет
--                     значение пробелами справа.
--                     Поэтому CHAR удобен только для кодов фиксированной длины.
--
--                     Пример:
--                       CHAR(2) = 'AZ'
--                       CHAR(1) = 'Y'
--
--                     Не лучший выбор для имен, email, описаний,
--                     потому что лишние пробелы могут мешать сравнению.
--
-- VARCHAR2(size)    - Строка переменной длины.
--                     Основной строковый тип в Oracle.
--                     size задает максимальную длину.
--
--                     Примеры:
--                       VARCHAR2(30)  = 'Ali'
--                       VARCHAR2(100) = 'ali@example.com'
--                       VARCHAR2(255) = короткое описание
--
--                     Для большинства текстовых значений используй VARCHAR2.
--
-- VARCHAR(size)     - Не рекомендуется.
--                     В Oracle лучше использовать VARCHAR2,
--                     потому что поведение VARCHAR может зависеть
--                     от будущих стандартов/версий.
--
-- NCHAR(length)     - Unicode-строка фиксированной длины.
--                     Использует national character set.
--                     Нужен редко, только если проект явно требует NCHAR.
--
-- NVARCHAR2(size)   - Unicode-строка переменной длины.
--                     Использует national character set.
--                     Может быть полезен для многоязычного текста,
--                     но во многих базах VARCHAR2 уже хранит Unicode,
--                     если база создана с подходящей кодировкой.
--
-- CLOB              - Character Large Object.
--                     Очень большой текст.
--                     Используется для статей, логов, HTML, JSON-текста,
--                     больших комментариев, документов.
--
-- NCLOB             - Unicode Character Large Object.
--                     Большой Unicode-текст.
--
-- LONG              - Старый тип для большого текста.
--                     Устаревший.
--                     В новых таблицах лучше использовать CLOB.
--
-- RAW(size)         - Бинарные данные небольшой длины.
--                     Например: hash, token, binary key.
--
-- LONG RAW          - Старый тип для больших бинарных данных.
--                     Устаревший.
--                     В новых таблицах лучше использовать BLOB.
--
-- BYTE vs CHAR semantics:
--   VARCHAR2(10 BYTE) - максимум 10 bytes.
--   VARCHAR2(10 CHAR) - максимум 10 characters.
--
-- Для английского текста 1 символ часто равен 1 byte.
-- Для Unicode-символов один символ может занимать несколько bytes.
-- Если в проекте есть русский, азербайджанский, турецкий и другие языки,
-- часто удобнее думать в CHAR, а не BYTE.
--
-- Когда что выбирать:
--   VARCHAR2(50)    - имя, фамилия, город.
--   VARCHAR2(320)   - email.
--   CHAR(1)         - маленький фиксированный флаг: 'Y'/'N'.
--   CLOB            - большой текст.
--   RAW(32)         - hash или binary token.
--
-- Примеры объявлений:
--   v_first_name VARCHAR2(50) := 'Ali';
--   v_status     CHAR(1) := 'A';
--   v_note       CLOB;
--   v_hash       RAW(32);
--
-- Пример блока:
   DECLARE
     v_first_name VARCHAR2(50) := 'Raul';
     v_last_name  VARCHAR2(50) := 'Alishov';
     v_full_name  VARCHAR2(101);
   BEGIN
     v_full_name := v_first_name || ' ' || v_last_name;
     DBMS_OUTPUT.PUT_LINE(v_full_name);
   END;
--   /


-- ============================================================
-- Date and time data types
-- ============================================================
-- DATE                  - Дата и время.
--                         Содержит:
--                           year, month, day, hour, minute, second.
--
--                         Не хранит доли секунды.
--                         Не хранит time zone.
--
--                         Пример:
--                           DATE = 07-Aug-26 15:28:43
--
-- TIMESTAMP(f)          - Дата и время с долями секунды.
--                         f указывает количество цифр доли секунды.
--                         Если f не указан, часто используется значение 6.
--
--                         Пример:
--                           TIMESTAMP(6) = 07-Aug-26 15:28:43.123000
--
-- TIMESTAMP WITH TIME ZONE
--                       - Дата и время с time zone.
--                         Хранит информацию о часовом поясе или offset.
--
--                         Пример:
--                           07-Aug-26 15:28:43.123000 +04:00
--
-- TIMESTAMP WITH LOCAL TIME ZONE
--                       - Дата и время, которое нормализуется в базе
--                         и отображается в time zone текущей сессии.
--
--                         Удобно, когда пользователи находятся
--                         в разных часовых поясах.
--
-- INTERVAL YEAR TO MONTH
--                       - Интервал в годах и месяцах.
--
--                         Примеры:
--                           INTERVAL '2' YEAR
--                           INTERVAL '6' MONTH
--                           INTERVAL '1-3' YEAR TO MONTH
--
-- INTERVAL DAY TO SECOND
--                       - Интервал в днях, часах, минутах, секундах.
--
--                         Примеры:
--                           INTERVAL '5' DAY
--                           INTERVAL '02:30' HOUR TO MINUTE
--                           INTERVAL '1 02:30:10' DAY TO SECOND
--
-- Основные функции даты/времени:
--   SYSDATE            - текущая дата и время сервера базы, тип DATE.
--   SYSTIMESTAMP       - текущая дата и время сервера с долями секунд/time zone.
--   CURRENT_DATE       - текущая дата в time zone сессии, тип DATE.
--   CURRENT_TIMESTAMP  - timestamp в time zone сессии.
--   ADD_MONTHS(date,n) - добавить n месяцев.
--   MONTHS_BETWEEN(d1,d2) - разница в месяцах.
--   TRUNC(date)        - обрезать дату, часто до начала дня.
--   ROUND(date)        - округлить дату.
--
-- Важно:
--   Отображение DATE зависит от NLS_DATE_FORMAT.
--   Значение в базе одно, но на экране формат может быть разный.
--   Для надежного преобразования строк используй TO_DATE/TO_TIMESTAMP
--   с явной маской формата.
--
-- Примеры объявлений:
--   v_today      DATE := SYSDATE;
--   v_created_at TIMESTAMP WITH TIME ZONE := SYSTIMESTAMP;
--   v_deadline   DATE := TO_DATE('2026-08-07', 'YYYY-MM-DD');
--
-- Пример блока:
   DECLARE
     v_started_at TIMESTAMP WITH TIME ZONE := SYSTIMESTAMP;
     v_due_date   DATE := ADD_MONTHS(SYSDATE, 1);
   BEGIN
     DBMS_OUTPUT.PUT_LINE('Started at = ' || v_started_at);
     DBMS_OUTPUT.PUT_LINE('Due date = ' || TO_CHAR(v_due_date, 'YYYY-MM-DD'));
   END;
--   /


-- ============================================================
-- Boolean data type
-- ============================================================
-- BOOLEAN       - Логический тип PL/SQL.
--                 Может принимать 3 значения:
--                   TRUE
--                   FALSE
--                   NULL
--
--                 Используется в IF, WHILE, LOOP, функциях и процедурах.
--
-- Важно:
--   Во многих Oracle-проектах BOOLEAN используется только внутри PL/SQL.
--   Для колонок таблицы часто используют NUMBER(1) или CHAR(1),
--   если версия/стандарт проекта не поддерживает SQL BOOLEAN.
--
-- Примеры объявлений:
--   v_is_active BOOLEAN := TRUE;
--   v_is_found  BOOLEAN := FALSE;
--   v_is_valid  BOOLEAN;
--
-- Пример блока:
   DECLARE
     v_salary    NUMBER(10, 2) := 2500;
     v_has_bonus BOOLEAN;
   BEGIN
     v_has_bonus := v_salary > 2000;

     IF v_has_bonus THEN
       DBMS_OUTPUT.PUT_LINE('Bonus allowed');
     ELSE
       DBMS_OUTPUT.PUT_LINE('Bonus not allowed');
     END IF;
   END;
--   /
--
-- BOOLEAN и NULL:
--   IF v_flag THEN
--     ...
--   END IF;
--
-- Если v_flag = NULL, условие не считается TRUE.
-- Поэтому nullable boolean проверяют осторожно:
--   IF v_flag THEN
--     -- TRUE
--   ELSIF NOT v_flag THEN
--     -- FALSE
--   ELSE
--     -- NULL
--   END IF;


-- ============================================================
-- Large object data types
-- ============================================================
-- CLOB          - Большой текст.
--                 Примеры: article body, HTML, XML, JSON text, logs.
--
-- NCLOB         - Большой Unicode-текст.
--
-- BLOB          - Binary Large Object.
--                 Большие бинарные данные.
--                 Примеры: image, PDF, audio, video, archive.
--
-- BFILE         - Указатель на внешний бинарный файл на сервере базы.
--                 Сам файл хранится вне таблицы.
--                 В таблице хранится locator.
--
-- Важно:
--   LOB-значение может быть очень большим.
--   Для работы с LOB часто используют пакет DBMS_LOB.
--   Не надо тянуть огромный CLOB/BLOB в память без необходимости.
--
-- Когда что выбирать:
--   VARCHAR2    - короткий/средний текст.
--   CLOB        - большой текст.
--   RAW         - короткие binary-значения.
--   BLOB        - большие binary-файлы.


-- ============================================================
-- Rowid data types
-- ============================================================
-- ROWID         - Физический адрес строки в таблице.
--                 Используется редко в обычной бизнес-логике.
--                 Может быть полезен для быстрой технической операции.
--
-- UROWID        - Universal ROWID.
--                 Может хранить ROWID для разных типов таблиц.
--
-- Важно:
--   ROWID не является бизнес-ключом.
--   Не используй ROWID как постоянный id клиента, заказа, продукта.
--   Для бизнес-id используй primary key.


-- ============================================================
-- Anchored declarations: %TYPE and %ROWTYPE
-- ============================================================
-- %TYPE         - Тип переменной берется из колонки таблицы
--                 или из другой переменной.
--
--                 Это помогает не дублировать типы руками.
--                 Если тип колонки изменится, PL/SQL-код легче поддерживать.
--
-- Пример:
--   v_employee_id employees.employee_id%TYPE;
--   v_salary      employees.salary%TYPE;
--
-- %ROWTYPE      - Переменная получает структуру всей строки таблицы
--                 или результата курсора.
--
-- Пример:
--   v_employee employees%ROWTYPE;
--
-- Пример блока:
   DECLARE
     v_employee employees%ROWTYPE;
   BEGIN
     SELECT *
     INTO v_employee
     FROM employees
     WHERE employee_id = 100;

     DBMS_OUTPUT.PUT_LINE(v_employee.first_name);
   END;
--   /
--
-- Когда использовать:
--   %TYPE    - когда нужна одна колонка.
--   %ROWTYPE - когда нужна вся строка.
--
-- Хорошая практика:
--   Для переменных, связанных с таблицами, используй %TYPE.
--   Так меньше ошибок при изменении структуры таблиц.


-- ============================================================
-- Composite data types
-- ============================================================
-- RECORD        - Пользовательская структура из нескольких полей.
--                 Похожа на строку таблицы, но ты сам задаешь поля.
--
-- Пример:
--   TYPE t_employee_info IS RECORD (
--     employee_id NUMBER(10),
--     full_name   VARCHAR2(100),
--     salary      NUMBER(9, 2)
--   );
--
--   v_employee_info t_employee_info;
--
-- Associative array / Index-by table
--               - PL/SQL-коллекция key-value.
--                 Может индексироваться числом или строкой.
--                 Удобна для временных данных внутри PL/SQL.
--
-- Пример:
--   TYPE t_names IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
--   v_names t_names;
--
-- Nested table   - Коллекция, похожая на список.
--                  Может использоваться в SQL и PL/SQL.
--
-- Пример:
--   TYPE t_numbers IS TABLE OF NUMBER;
--   v_numbers t_numbers := t_numbers(10, 20, 30);
--
-- VARRAY         - Коллекция с максимальным количеством элементов.
--
-- Пример:
--   TYPE t_top_3_names IS VARRAY(3) OF VARCHAR2(100);
--   v_top_names t_top_3_names := t_top_3_names('Ali', 'Vali', 'Nigar');
--
-- Когда что выбирать:
--   RECORD            - одна сложная структура.
--   %ROWTYPE          - строка таблицы.
--   Associative array - временный key-value список в PL/SQL.
--   Nested table      - список значений, который может участвовать в SQL.
--   VARRAY            - маленький список с известным максимумом.


-- ============================================================
-- Reference cursor data types
-- ============================================================
-- CURSOR        - Указатель на результат SQL-запроса.
--                 Используется, когда нужно пройтись по строкам результата.
--
-- REF CURSOR    - Тип ссылки на cursor.
--                 Удобен, когда процедура/функция должна вернуть набор строк.
--
-- SYS_REFCURSOR - Готовый системный тип REF CURSOR.
--                 Часто используется в процедурах.
--
-- Пример:
--   v_cursor SYS_REFCURSOR;
--
-- Пример процедуры:
--   PROCEDURE get_employees(p_result OUT SYS_REFCURSOR) IS
--   BEGIN
--     OPEN p_result FOR
--       SELECT employee_id, first_name, salary
--       FROM employees;
--   END;


-- ============================================================
-- Subtypes
-- ============================================================
-- SUBTYPE       - Свой псевдоним/ограничение для уже существующего типа.
--
-- Зачем нужен:
--   1. сделать код понятнее;
--   2. переиспользовать ограничения;
--   3. описать бизнес-смысл значения.
--
-- Примеры:
--   SUBTYPE t_money IS NUMBER(12, 2);
--   SUBTYPE t_email IS VARCHAR2(320);
--   SUBTYPE t_id IS NUMBER(10);
--
-- Использование:
--   v_salary t_money := 2500.00;
--   v_email  t_email := 'ali@example.com';
--   v_id     t_id := 100;
--
-- Важно:
--   SUBTYPE не создает совершенно новый физический тип.
--   Это удобное имя или дополнительное ограничение.


-- ============================================================
-- Constants
-- ============================================================
-- CONSTANT      - Константа.
--                 Значение задается один раз при объявлении
--                 и потом не может быть изменено.
--
-- Пример:
--   c_tax_rate CONSTANT NUMBER(5, 2) := 18.00;
--   c_status_active CONSTANT CHAR(1) := 'A';
--
-- Хорошая практика:
--   Для значений, которые не должны меняться,
--   используй CONSTANT вместо обычной переменной.
--
-- Пример блока:
   DECLARE
     c_vat_rate CONSTANT NUMBER(5, 2) := 18;
     v_price    NUMBER(10, 2) := 100;
     v_total    NUMBER(10, 2);
   BEGIN
     v_total := v_price + (v_price * c_vat_rate / 100);
     DBMS_OUTPUT.PUT_LINE(v_total);
   END;
--   /


-- ============================================================
-- NULL
-- ============================================================
-- NULL          - Отсутствие данных.
--                 NULL не равен 0.
--                 NULL не равен пустой строке по смыслу.
--                 NULL не равен FALSE.
--
-- В Oracle пустая строка '' обычно рассматривается как NULL.
-- Поэтому:
--   v_name := '';
-- часто означает:
--   v_name := NULL;
--
-- Проверка NULL:
--   Правильно:
--     WHERE column_name IS NULL
--     WHERE column_name IS NOT NULL
--
--   Неправильно:
--     WHERE column_name = NULL
--     WHERE column_name <> NULL
--
-- Почему:
--   NULL означает unknown.
--   Сравнение с unknown тоже дает unknown, а не TRUE.
--
-- Арифметика с NULL:
--   10 + NULL = NULL
--   10 * NULL = NULL
--
-- Конкатенация:
--   'Hello ' || NULL обычно дает 'Hello '
--
-- Полезные функции:
--   NVL(value, replacement)
--     Если value = NULL, вернуть replacement.
--
--   COALESCE(value1, value2, value3)
--     Вернуть первое NOT NULL значение.
--
--   NULLIF(value1, value2)
--     Если value1 = value2, вернуть NULL.
--     Иначе вернуть value1.
--
--   NVL2(value, if_not_null, if_null)
--     Если value NOT NULL, вернуть if_not_null.
--     Иначе вернуть if_null.
--
-- Пример:
   SELECT NVL(commission_pct, 0)
   FROM employees;
--
-- Пример PL/SQL:
   DECLARE
     v_bonus NUMBER;
     v_total NUMBER;
   BEGIN
     v_total := 1000 + NVL(v_bonus, 0);
     DBMS_OUTPUT.PUT_LINE(v_total);
   END;
--   /


-- ============================================================
-- Explicit conversion
-- ============================================================
-- Oracle умеет делать implicit conversion,
-- но лучше не надеяться на автоматическое преобразование.
-- Явное преобразование делает код понятнее и стабильнее.
--
-- TO_CHAR       - Преобразовать число/дату в строку.
--
-- Пример:
--   TO_CHAR(SYSDATE, 'YYYY-MM-DD')
--   TO_CHAR(1250.5, '9999990.00')
--
-- TO_NUMBER     - Преобразовать строку в число.
--
-- Пример:
--   TO_NUMBER('1250.50')
--
-- TO_DATE       - Преобразовать строку в DATE.
--
-- Пример:
--   TO_DATE('2026-08-07', 'YYYY-MM-DD')
--
-- TO_TIMESTAMP  - Преобразовать строку в TIMESTAMP.
--
-- Пример:
--   TO_TIMESTAMP('2026-08-07 15:28:43.123',
--                'YYYY-MM-DD HH24:MI:SS.FF3')
--
-- CAST          - Преобразовать значение в указанный тип.
--
-- Пример:
--   CAST('100' AS NUMBER)
--   CAST(SYSDATE AS TIMESTAMP)
--
-- Хорошая практика:
--   Для дат всегда указывай формат.
--   Плохо:
--     TO_DATE('07-08-2026')
--
--   Лучше:
--     TO_DATE('2026-08-07', 'YYYY-MM-DD')


-- ============================================================
-- Type conversion examples
-- ============================================================
-- Пример 1: string -> number
   DECLARE
     v_text   VARCHAR2(20) := '1250.50';
     v_amount NUMBER(10, 2);
   BEGIN
     v_amount := TO_NUMBER(v_text);
     DBMS_OUTPUT.PUT_LINE(v_amount);
   END;
--   /
--
-- Пример 2: date -> string
   DECLARE
     v_today DATE := SYSDATE;
   BEGIN
     DBMS_OUTPUT.PUT_LINE(TO_CHAR(v_today, 'YYYY-MM-DD HH24:MI:SS'));
   END;
--   /
--
-- Пример 3: string -> date
   DECLARE
     v_hire_date DATE;
   BEGIN
     v_hire_date := TO_DATE('2026-08-07', 'YYYY-MM-DD');
     DBMS_OUTPUT.PUT_LINE(TO_CHAR(v_hire_date, 'DD.MM.YYYY'));
   END;
--   /


-- ============================================================
-- Choosing the right type
-- ============================================================
-- Ситуация                         Рекомендуемый тип
-- ------------------------------------------------------------
-- Primary key/id                   NUMBER(10) / NUMBER(19)
-- Счетчик внутри PL/SQL            PLS_INTEGER
-- Деньги                           NUMBER(12, 2)
-- Процент                          NUMBER(5, 2)
-- Имя                              VARCHAR2(50)
-- Email                            VARCHAR2(320)
-- Код страны                       CHAR(2)
-- Статус 'A'/'I'                   CHAR(1)
-- Большой текст                    CLOB
-- Картинка/PDF/файл                BLOB
-- Дата без долей секунды           DATE
-- Дата с долями секунды            TIMESTAMP
-- Дата с часовым поясом            TIMESTAMP WITH TIME ZONE
-- Логический флаг в PL/SQL         BOOLEAN
-- Логический флаг в таблице        NUMBER(1) или CHAR(1)
-- Строка таблицы                   table_name%ROWTYPE
-- Тип как у колонки                table_name.column_name%TYPE


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Использовать VARCHAR вместо VARCHAR2.
--    В Oracle лучше VARCHAR2.
--
-- 2. Использовать CHAR для обычного текста.
--    CHAR дополняет строку пробелами.
--    Для имен и описаний лучше VARCHAR2.
--
-- 3. Использовать FLOAT для денег.
--    Для денег нужен точный NUMBER(p, s).
--
-- 4. Сравнивать NULL через = или <>.
--    Используй IS NULL / IS NOT NULL.
--
-- 5. Преобразовывать даты без формата.
--    Используй TO_DATE(value, format_mask).
--
-- 6. Дублировать тип колонки руками.
--    Для переменных, связанных с таблицами, используй %TYPE.
--
-- 7. Забывать, что DATE хранит время.
--    DATE - это не только день/месяц/год.
--    Там также есть hour, minute, second.
--
-- 8. Делать VARCHAR2 слишком маленьким.
--    Например, email VARCHAR2(30) часто слишком мало.
--
-- 9. Хранить yes/no как текст без правила.
--    Если используешь CHAR(1), договорись о значениях:
--      'Y'/'N' или 'A'/'I'
--
-- 10. Тянуть большой CLOB/BLOB целиком без необходимости.
--     Для больших данных используй аккуратную обработку.


-- ============================================================
-- Small practice tasks
-- ============================================================
-- Task 1:
--   Объяви переменные:
--     v_employee_id NUMBER(10)
--     v_first_name VARCHAR2(50)
--     v_salary NUMBER(10, 2)
--     v_hire_date DATE
--     v_is_active BOOLEAN
--
-- Task 2:
--   Присвой значения этим переменным и выведи их через DBMS_OUTPUT.
--
-- Task 3:
--   Создай переменную v_total_salary.
--   Если v_bonus = NULL, посчитай salary + 0 через NVL.
--
-- Task 4:
--   Преобразуй строку '2026-08-07' в DATE через TO_DATE.
--   Потом выведи дату в формате 'DD.MM.YYYY'.
--
-- Task 5:
--   Создай subtype t_money как NUMBER(12, 2).
--   Объяви две переменные этого типа и сложи их.
--
-- Task 6:
--   Создай record t_employee_info с полями:
--     employee_id
--     full_name
--     salary
--   Заполни record и выведи full_name.
--
-- Task 7:
--   Создай associative array для списка имен.
--   Добавь 3 имени и выведи их в цикле.
