## Prerequisites
- You need the **Docker client** installed on your system.

## Setup
1. Create directories for data persistence:

```bash
mkdir -p /home/$(users)/data/wordpress
mkdir -p /home/$(users)/data/mariadb
```
2. Edit the /etc/hosts file and add the following line:
```
127.0.0.1   mzouine.42.fr
```

## Makefile Usage
- Setup containers: make
- Stop containers: make clean

## Wordpress website
- access the website: https://mzouine.42.fr
- access the admin pannel: https://mzouine.42.fr/wp-admin

## Mariadb
```
To login:
	mysql -u root -p 
	then enter the password

To show databases: 
	SHOW DATABASES;

To use a database:
	USE <Database_name>;

To show tables of a database:
	SHOW TABLES;

To show contents of a table:
	SELECT * FROM <Table_name>
```

## Managing credentials
- create a .env file located in /srcs and modify the creds using this template:
```
DOMAINE_NAME=
WP_PORT=
WP_TITLE=
WP_ADMIN_USER=
WP_ADMIN_PASS=
WP_ADMIN_EMAIL=
WP_USER=
WP_PASS=
WP_USER_EMAIL=
ROLE=
WP_PATH=

DB_HOST=
DB_PORT=
DB_NAME=
DB_USER=
DB_PASSWORD=
SQL_ROOT_PASSWORD=
```