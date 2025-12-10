Завдання 1: Деплой Jenkins
Успішно інсталював docker та запустив у ньому jenkins на локальному сервері, скориставшись наданим docker-compose файлом. Скріншоти в папці task_1.

Завдання 2: Налаштувати Freestyle Job
Створив freestyle job з назвою simple freestyle job у jenkins
в source code managment вказав форкнутий репозиторій https://github.com/bohdanmatveiev/gs-spring-boot, виправив branch specifier з master на main, для збирання проекту використав mvn clean install та додав збереження артифакту локально: initial/target/*.jar. в результаті після успішного виконання білда (з 6 разу:) бо то branch specifier невірний, то mvn не встановлений, то шлях до mvn невірний, то шлях до архівації невірний) проект був збережний як готовий до вжитку й розгортання артефакт. Скріншоти в папці task_2.

Завданнями з зірочками ще займаюсь, перше виконав, але ще не оформив.
