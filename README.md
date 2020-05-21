![QKspace Logo](/public/images/logo.png "QKspace Logo")

QKspace (pronounced "quick space") is a minimalistic knowledge base for small teams.

It is perfect for creating a course reference base for an educational organisation, for making a QnA list in the IT, for exchanging knowledge within social work teams, for making a thematic list of personal quotes and notes.

# Usage examples

A list of guidelines for Ruby newbies: http://ruby.qkspace.com

Information about the law of renovation in Moscow: http://renovation.qkspace.com/

Lovecraft quotes: http://lovecraft.qkspace.com

# Features

* Creating projects with a number of pages
* Markdown user-friendly editor
* Adding your own domain
* Collaborative project editing
* Private and public projects

# How to contribute

The project is run by a non-profit community of developers.

The list of bugs and issues is here: https://github.com/issues

Feel free to send your PRs. If the task isn’t closed, it still needs to be done.

Use [chat](https://t.me/qkspace) for support and general questions.

# Contacts

For all questions please contact us at support@qkspace.com

Regarding commercial collaboration please contact us at business@qkspace.com

# Developers

[Vadim Venediktov](https://github.com/installero)
[Eugene Zolotarev](https://github.com/EugZol)
[Aleksander Klimenkov](https://github.com/prisioner)
[Dmitry Smirnov](https://github.com/vergilsm)
[Igor Stroganov](https://github.com/Gargantua88)
[Dmitry Malyshev](https://github.com/tenseisan)

The developers' contributions are listed on the [corresponding page](https://github.com/qkspace/qkspace/graphs/contributors).

# License

MIT.

See `LICENSE` for full text.

See `THIRDPARTY-LICENSES` for third-party licenses' texts.

This background of [this image](/public/images/og-image-sq.png) is courtesy NASA/JPL-Caltech.

# Install ImageMagick on Ubuntu:

- `sudo apt-get update`
- `sudo apt-get upgrade`
- `sudo apt-get install imagemagick`

# Install Redis
### on development(local) Ubuntu:

- `sudo apt-get update`
- `sudo apt-get upgrade`
- `sudo apt-get install redis-server`

### Check installation
- `redis-server -v`

### on production(remote) Ubuntu:

- `sudo apt-get update`
- `sudo apt-get upgrade`

- install the necessary packages:
  - `sudo apt-get install build-essential tcl`
- go to the temporary folder
  - `cd /tmp`
- download the stable version of Redis
  - `curl -O http://download.redis.io/redis-stable.tar.gz`
- Unpack
  - `tar xzvf redis-stable.tar.gz`
- go to the unpacked folder
  - `cd redis-stable`
- compile binary files, and testing them
  - `make`
  - `make test`
- install binary files
  - `sudo make install`
- configure Redis, and copy the default config to new folder
  - `sudo mkdir /etc/redis`
  - `sudo cp /tmp/redis-stable/redis.conf /etc/redis`
- open this config and write the necessary settings
  - `sudo nano /etc/redis/redis.conf`
  - find for string `supervised` in the file and replace `systemd` instead of `no`.
  - then find string `dir` and instead of `./` insert: `dir /var/lib/redis`
  - push `ctrl + O`, `enter` and `ctrl + X`
- create one more file for systemd
  - `sudo nano /etc/systemd/system/redis.service`
  - Add the following to this file
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
  - save and exit
-  Create a system user, group and folder to run Redis
    - `sudo mkdir /var/lib/redis`
    - `sudo adduser --system --group --no-create-home redis`
    - `sudo chown redis:redis /var/lib/redis`
    - and we disable other users to access this folder:
      - `sudo chmod 770 /var/lib/redis`
- And add Redis to autoload
  - `sudo systemctl enable redis`

### Check installation
- `sudo systemctl start redis`
- `sudo systemctl status redis`
