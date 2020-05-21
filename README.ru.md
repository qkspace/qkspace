![QKspace Logo](/public/images/logo.png "QKspace Logo")

# Что такое QKspace?

QKspace (читается «квик спэйс») это минималистичная база знаний для небольших команд.

Отлично подойдёт для создания справочной базы курса при образовательной организации; для составления списка «вопросов и ответов» в сфере IT; для обмена знаниями внутри команд, ведущих общественную деятельность; для ведения тематического списка личных цитат или заметок.

# Примеры использования

Набор рецептов для новичков Ruby: http://ruby.qkspace.com

Ликбез про закон «О реновации» в Москве: http://renovation.qkspace.com/

Цитаты Лавкрафта: http://lovecraft.qkspace.com

# Возможности

* Создание проектов с набором страниц
* Markdown-разметка и удобный редактор
* Подключение своего домена
* Коллективная работа
* Приватные и публичные проекты

# Как сделать вклад в проект

Проект ведётся некоммерческим сообществом.

Список планируемых возможностей здесь: https://github.com/issues

Присылайте свои пулреквесты. Если задача не закрыта, значит она актуальна.

Поддержка по общим вопросам в [чате](https://t.me/qkspace).

# Контактная информация

По всем вопросам: support@qkspace.com

Коммерческое сотрудничество: business@qkspace.com

# Авторы

[Вадим Венедиктов](https://github.com/installero)
[Евгений Золотарев](https://github.com/EugZol)
[Александр Клименков](https://github.com/prisioner)
[Дмитрий Смирнов](https://github.com/vergilsm)
[Игорь Строганов](https://github.com/Gargantua88)
[Дмитрий Малышев](https://github.com/tenseisan)

Посмотреть вклад участников можно на [соответствующей странице](https://github.com/qkspace/qkspace/graphs/contributors).

# Лицензия

MIT (см. LICENSE)

# Установка ImageMagick на Ubuntu:

- `sudo apt-get update`
- `sudo apt-get upgrade`
- `sudo apt-get install imagemagick`

# Установка Redis Ubuntu:
### На локальном сервере(development):

- `sudo apt-get update`
- `sudo apt-get upgrade`
- `sudo apt-get install redis-server`

### Проверка установки
- `redis-server -v`

### На удаленном сервере(production):

- `sudo apt-get update`
- `sudo apt-get upgrade`

- установите необходимые пакеты:
  - `sudo apt-get install build-essential tcl`
- перейти во временную папку
  - `cd /tmp`
- загружаем стабильную версию Redis
  - `curl -O http://download.redis.io/redis-stable.tar.gz`
- распаковываем архив
  - `tar xzvf redis-stable.tar.gz`
- переходим в распакованную папку
  - `cd redis-stable`
- компилирует бинарные файлы, и тестируем их
  - `make`
  - `make test`
- устанавливаем бинарные файлы
  - `sudo make install`
- настраиваем Redis, и копируем туда дефолтный конфиг
  - `sudo mkdir /etc/redis`
  - `sudo cp /tmp/redis-stable/redis.conf /etc/redis`
- открываем этот конфиг и прописываем нужные настройки:
  - `sudo nano /etc/redis/redis.conf`
  - ищем в файле строку `supervised` и вместо `no`подставляем `systemd`.
  - затем ищем строку `dir` и вместо `./` подставляем `dir /var/lib/redis`
  - нажимаем `ctrl + O`, `enter` и `ctrl + X`
- нужно создать ещё один файл для `systemd`
  - `sudo nano /etc/systemd/system/redis.service`
  - добавляем в этот файл следующее
    ```
    [Unit]
    Description=Redis In-Memory Data Store
    After=network.target

    [Service]
    User=redis
    Group=redis
    ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
    ExecStop=/usr/local/bin/redis-cli shutdown
    Restart=always

    [Install]
    WantedBy=multi-user.target
    ```
  - сохраняем и выходим
-  создадим системного пользователя, группу и папку, чтобы запускать Redis
    - `sudo mkdir /var/lib/redis`
    - `sudo adduser --system --group --no-create-home redis`
    - `sudo chown redis:redis /var/lib/redis`
    - запрещаем обычным пользователям доступ к этой папке
      - `sudo chmod 770 /var/lib/redis`
- Добавляем Redis в автозагрузку
  - `sudo systemctl enable redis`

### Проверка установки
- `sudo systemctl start redis`
- `sudo systemctl status redis`
