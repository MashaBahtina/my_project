-- Удаление старых таблиц (в обратном порядке, чтобы не ломать связи)
DROP TABLE IF EXISTS charges;
DROP TABLE IF EXISTS charge_types;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS user_roles;

-- Справочник ролей
CREATE TABLE user_roles (
    role_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

-- Пользователи
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    login TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    role_id INTEGER NOT NULL,
    FOREIGN KEY (role_id) REFERENCES user_roles(role_id)
);

-- Сотрудники
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL UNIQUE,
    full_name TEXT NOT NULL,
    position TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Справочник видов начислений
CREATE TABLE charge_types (
    charge_type_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

-- Начисления
CREATE TABLE charges (
    charge_id INTEGER PRIMARY KEY AUTOINCREMENT,
    employee_id INTEGER NOT NULL,
    charge_type_id INTEGER NOT NULL,
    amount REAL NOT NULL,
    charge_date TEXT NOT NULL,
    status TEXT NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (charge_type_id) REFERENCES charge_types(charge_type_id)
);

-- Тестовые данные
INSERT INTO user_roles (name) VALUES
('Бухгалтер'),
('Сотрудник');

INSERT INTO users (login, password_hash, role_id) VALUES
('accountant1', 'hash_pass_1', 1),
('ivanov', 'hash_pass_2', 2),
('petrova', 'hash_pass_3', 2);

INSERT INTO employees (user_id, full_name, position) VALUES
(2, 'Иванов Иван Иванович', 'Менеджер'),
(3, 'Петрова Мария Сергеевна', 'Бухгалтер');

INSERT INTO charge_types (name) VALUES
('Зарплата'),
('Премия'),
('Отпускные');

INSERT INTO charges (employee_id, charge_type_id, amount, charge_date, status) VALUES
(1, 1, 50000.00, '2026-10-01', 'выплачено'),
(1, 2, 10000.00, '2026-10-11', 'запланировано'),
(2, 1, 60000.00, '2026-10-01', 'выплачено'),
(2, 3, 30000.00, '2026-10-11', 'запланировано');