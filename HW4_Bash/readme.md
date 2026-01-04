1. Автоматичне резервне копіювання директорії через Bash-скрипт + cron
Створений скрипт /home/vagrant/backup_data.sh
Виконано chmod +x /home/vagrant/backup_data.sh
Створено тестову директорію /home/vagrant/data з кількома файлами для перевірки.

Налаштування cron
Виконано crontab -e та додано рядок:
text0 2 * * * /home/vagrant/backup_data.sh
Пояснення: Скрипт виконуватиметься щодня о 2:00 ранку. Використано rsync для ефективного копіювання з видаленням застарілих файлів у бекапі.
Перевірка: crontab -l показує завдання. screen1 + screen2

2. Власний systemd-сервіс для моніторингу доступності сайту
Скрипт /home/vagrant/check_website.sh
chmod +x /home/vagrant/check_website.sh

Створено юніт-файл /etc/systemd/system/website-check.service
Створено таймер /etc/systemd/system/website-check.timer
Результат: Перевірка виконується кожні 5 хвилин, результати записуються у /var/log/website_status.log. screen3

3. Скрипт /home/vagrant/system_monitor.sh
chmod +x /home/vagrant/system_monitor.sh
Запущено вручну для перевірки — дані коректно записуються. screen4

4. Ротація access-логу Nginx
Створено конфіг ротації /etc/logrotate.d/nginx-access
Результат: Лог успішно ротується, Nginx продовжує писати в новий файл без перезапуску. screen5 + screen6
