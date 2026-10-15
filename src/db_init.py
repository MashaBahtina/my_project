"""
Инициализация базы данных SQLite из файла schema.sql
"""
import sqlite3
import os

# Пути к файлам
DB_PATH = os.path.join(os.path.dirname(__file__), '..', 'db', 'app.db')
SCHEMA_PATH = os.path.join(os.path.dirname(__file__), '..', 'db', 'schema.sql')

def init_db():
    """Создаёт базу данных и таблицы из schema.sql"""
    # Удаляем старую БД, если есть
    if os.path.exists(DB_PATH):
        os.remove(DB_PATH)
        print(f"Старая база удалена: {DB_PATH}")

    # Подключаемся и выполняем SQL-скрипт
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    with open(SCHEMA_PATH, 'r', encoding='utf-8') as f:
        sql_script = f.read()

    cursor.executescript(sql_script)
    conn.commit()
    conn.close()

    print(f"База данных создана: {DB_PATH}")
    print("Таблицы и тестовые данные добавлены.")

if __name__ == "__main__":
    init_db()