# AlmaLinux 8 mariadb-mroonga
https://mroonga.org/docs/install/almalinux.html#almalinux-8-with-mariadb-10-6-package
## Quick Start

    $ sudo docker build -t REPOSITORY .
    $ sudo docker run -e MYSQL_ROOT_PASSWORD=PASSWORD -d -p 13306:3306 REPOSITORY
    $ mysql --user=root --password=PASSWORD --host=127.0.0.1 --port=13306 REPOSITORY



## Version

| MariaDB | Groonga | Mroonga |
|---------|---------|---------|
| 10.6    | 11.3    | 11.3    |
