завдання 1. успішно встановив docker на своєму ноуті.

завдання 2. в навчальній директорії створив папку multi-container-app, в ній файл docker-compose.yml, у якому визначив конфігурацію для трьох сервісів: вебсервер (nginx), база даних (postgres) та кеш (redis).
додав volume db-data для збереження даних PostgreSQL та web-data для nginx.
налаштував спільну мережу appnet, щоб сервіси могли взаємодіяти між собою.
також створив файл index.html з простим змістом

завдання 3. запустив застосунок командою docker compose up -d, всі сервіси стартували у фоновому режимі
перевірив стан контейнерів через docker compose ps, побачив web, db та cache у статусі up
відкрив браузер на http://localhost:8080, nginx відобразив стартову сторінку

завдання 4: переглянув створені мережі та томи командами docker network ls та docker volume ls, побачив appnet, db-data та web-data
підключився до бази даних всередині контейнера postgres через docker exec -it <db_container_name> psql -U user -d mydb, отримав доступ до консолі psql

завдання 5: запустив три екземпляри вебсервера командою docker compose up -d --scale web=3
перевірив стан контейнерів через docker compose ps, побачив три web‑контейнери у статусі up
