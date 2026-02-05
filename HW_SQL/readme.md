створення бази даних
я створив нову базу SchoolDB командою CREATE DATABASE SchoolDB;.

створення таблиць
спочатку зробив чотири таблиці без зовнішніх ключів:
Institutions — заклади (id, назва, тип, адреса)

mysql> create table Institutions (
    -> institution_id INT AUTO_INCREMENT PRIMARY KEY,
    -> institution_name VARCHAR(100),
    -> institution_type VARCHAR(20),
    -> address VARCHAR(200)
    -> );
Query OK, 0 rows affected (0.649 sec)

Classes — класи (id, назва, institution_id, напрям)

mysql> CREATE TABLE Classes (
    -> class_id INT AUTO_INCREMENT PRIMARY KEY,
    -> class_name VARCHAR(50),
    -> institution_id INT,
    -> direction VARCHAR(50)
    -> );
Query OK, 0 rows affected (0.755 sec)

Children — діти (id, ім’я, прізвище, дата народження, рік вступу, вік, institution_id, class_id)

mysql> CREATE TABLE Children (
    -> child_id INT AUTO_INCREMENT PRIMARY KEY,
    -> first_name VARCHAR(50),
    -> last_name VARCHAR(50),
    -> birth_date DATE,
    -> year_of_entry INT,
    -> age INT,
    -> institution_id INT,
    -> class_id INT
    -> );
Query OK, 0 rows affected (0.644 sec)

Parents — батьки (id, ім’я, прізвище, child_id, вартість навчання)

mysql> CREATE TABLE Parents (
    -> parent_id INT AUTO_INCREMENT PRIMARY KEY,
    -> first_name VARCHAR(50),
    -> last_name VARCHAR(50),
    -> child_id INT,
    -> tuition_fee DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.674 sec)

вставка даних
заповнив таблиці реалістичними прикладами (по 4–6 записів у кожну), додаючи їх у правильному порядку: спочатку Institutions, потім Classes, далі Children і Parents. це дозволило уникнути проблем із цілісністю після додавання зовнішніх ключів.

mysql> INSERT INTO Institutions (institution_name, institution_type, address) VALUES
    -> ('Київська гімназія №178', 'School', 'вул. Велика Васильківська, 178, Київ'),
    -> ('Дитячий садок "Веселка"', 'Kindergarten', 'пров. Яблуневий, 12, Буча'),
    -> ('Львівська спеціалізована школа №7', 'School', 'вул. Личаківська, 45, Львів'),
    -> ('Садочок "Малятко"', 'Kindergarten', 'вул. Центральна, 8, Ірпінь');
Query OK, 4 rows affected (0.434 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Classes (class_name, institution_id, direction) VALUES
    -> ('1-А клас', 1, 'Mathematics'),
    -> ('Група "Сонечко" (молодша)', 2, 'Biology and Chemistry'),
    -> ('10-Б профільний', 3, 'Language Studies'),
    -> ('Група "Зірочки" (середня)', 4, 'Mathematics'),
    -> ('11-А гуманітарний', 1, 'Language Studies');
Query OK, 5 rows affected (0.443 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Children (first_name, last_name, birth_date, year_of_entry, age, institution_id, class_id) VALUES
    -> ('Софія', 'Коваленко', '2016-04-12', 2023, 9, 1, 1),
    -> ('Максим', 'Бондаренко', '2019-07-05', 2024, 6, 2, 2),
    -> ('Анастасія', 'Шевчук', '2011-11-30', 2021, 14, 3, 3),
    -> ('Данило', 'Лисенко', '2018-02-18', 2023, 7, 4, 4),
    -> ('Вікторія', 'Мельник', '2010-09-22', 2020, 15, 1, 5);
Query OK, 5 rows affected (0.426 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Parents (first_name, last_name, child_id, tuition_fee) VALUES
    -> ('Ольга', 'Коваленко', 1, 6200.00),
    -> ('Ігор', 'Бондаренко', 2, 3800.00),
    -> ('Тетяна', 'Шевчук', 3, 8500.00),
    -> ('Сергій', 'Лисенко', 4, 4100.00),
    -> ('Марія', 'Мельник', 5, 7800.00),
    -> ('Олександр', 'Коваленко', 1, 0.00);   -- другий батько для Софії (наприклад, тато, без оплати)
Query OK, 6 rows affected (0.327 sec)
Records: 6  Duplicates: 0  Warnings: 0

додавання зовнішніх ключів
після перевірки даних прописав зв’язки через ALTER TABLE:
Classes.institution_id → Institutions.institution_id
Children.institution_id → Institutions.institution_id
Children.class_id → Classes.class_id
Parents.child_id → Children.child_id
для зручності використав ON DELETE CASCADE, щоб при видаленні записів автоматично видалялися пов’язані.

виконання запитів
написав три основні SELECT‑запити з JOIN:
список дітей із назвою закладу та напрямом навчання:
select children.first_name, children.last_name, children.age,
    -> institutions.institution_name as institution,
    -> classes.direction as class_direction
    -> from children
    -> join institutions on children.institution_id = institutions.institution_id
    -> join classes on children.class_id = classes.class_id;
+------------+------------+------+-----------------------------------+-----------------------+
| first_name | last_name  | age  | institution                       | class_direction       |
+------------+------------+------+-----------------------------------+-----------------------+
| Соф?я      | Коваленко  |    9 | Київська г?мназ?я ?178            | Mathematics           |
| В?ктор?я   | Мельник    |   15 | Київська г?мназ?я ?178            | Language Studies      |
| Максим     | Бондаренко |    6 | Дитячий садок "Веселка"           | Biology and Chemistry |
| Анастас?я  | Шевчук     |   14 | Льв?вська спец?ал?зована школа ?7 | Language Studies      |
| Данило     | Лисенко    |    7 | Садочок "Малятко"                 | Mathematics           |
+------------+------------+------+-----------------------------------+-----------------------+
5 rows in set (0.070 sec)

інформація про батьків, дітей та вартість навчання
mysql> select parents.first_name as parent_first, parents.last_name as parent_last,
    -> children.first_name as child_first, children.last_name as child_last,
    -> parents.tuition_fee
    -> from parents
    -> join children on parents.child_id = children.child_id
    -> ;
+--------------+-------------+-------------+------------+-------------+
| parent_first | parent_last | child_first | child_last | tuition_fee |
+--------------+-------------+-------------+------------+-------------+
| Ольга        | Коваленко   | Соф?я       | Коваленко  |     6200.00 |
| Олександр    | Коваленко   | Соф?я       | Коваленко  |        0.00 |
| ?гор         | Бондаренко  | Максим      | Бондаренко |     3800.00 |
| Тетяна       | Шевчук      | Анастас?я   | Шевчук     |     8500.00 |
| Серг?й       | Лисенко     | Данило      | Лисенко    |     4100.00 |
| Мар?я        | Мельник     | В?ктор?я    | Мельник    |     7800.00 |
+--------------+-------------+-------------+------------+-------------+
6 rows in set (0.017 sec)

список закладів з адресами та кількістю дітей (через GROUP BY)
mysql> SELECT
    ->     Institutions.institution_name, Institutions.address,
    ->     COUNT(Children.child_id) AS children_count
    -> FROM Institutions
    -> LEFT JOIN Children ON Institutions.institution_id = Children.institution_id
    -> GROUP BY Institutions.institution_id;
+-----------------------------------+--------------------------------------+----------------+
| institution_name                  | address                              | children_count |
+-----------------------------------+--------------------------------------+----------------+
| Київська г?мназ?я ?178            | вул. Велика Васильк?вська, 178, Київ |              2 |
| Дитячий садок "Веселка"           | пров. Яблуневий, 12, Буча            |              1 |
| Льв?вська спец?ал?зована школа ?7 | вул. Личак?вська, 45, Льв?в          |              1 |
| Садочок "Малятко"                 | вул. Центральна, 8, ?рп?нь           |              1 |
+-----------------------------------+--------------------------------------+----------------+
4 rows in set (0.022 sec)

бекап і відновлення
зробив резервну копію бази командою:
mysqldump -u root -p SchoolDB > schooldb_backup.sql  
створив нову базу SchoolDB_New і відновив дані з бекапу:
mysql -u root -p SchoolDB_New < schooldb_backup.sql  
перевірив — таблиці, дані й запити працюють так само, як у вихідній базі.

висновок
я успішно створив реляційну базу даних із кількома таблицями, налаштував зв’язки через FOREIGN KEY, виконав тестові запити та показав процес резервного копіювання й відновлення. у результаті отримав практичні навички роботи з MySQL: створення структури, вставка даних, забезпечення цілісності та робота з бекапами.
