#!/bin/bash

echo "MariaDB starting..."
service mariadb start

until mariadb -e "SELECT 1" >/dev/null 2>&1; do
  echo "Waiting for MariaDB to be ready..."
  sleep 1
done

echo "Creating the Database..."
mariadb -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"

echo "Creating the User..."
mariadb -e "CREATE USER IF NOT EXISTS ${DB_USER}@'%' IDENTIFIED BY '${DB_PASSWORD}';"

echo "Granting Privileges..."
mariadb -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' WITH GRANT OPTION;"

echo "Flushing Privileges..."
mariadb -e "FLUSH PRIVILEGES;"

echo "Stopping MariaDB..."
mysqladmin -u root shutdown

echo "Starting MariaDB with Monitoring..."
mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
