#!/bin/bash

#Creating the directory...
echo "Creating directory : $WP_PATH ..."
WP_PATH='/var/www/wordpress'
mkdir -p "$WP_PATH"
echo "Directory $WP_PATH Created !"

#Waiting for MariaDB to start...
#sleep 5  MAYBE I NEED IT MAYBE NOT
echo "Waiting for MariaDB to be ready..."
while ! mariadb -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" -e "SELECT 1;" >/dev/null 2>&1; do
  sleep 1
done
echo "MariaDB is ready!"

#Downloading WordPress Core...
echo "Downloading WordPress Core..."
if [ ! -f "$WP_PATH/wp-load.php" ]; then
    wordpress core download --path="$WP_PATH" --allow-root
	echo "WordPress Core Downloaded!"
else
    echo "WordPress Core is already downloaded!"
fi

#Creating WordPress config...
echo "Creating WordPress config..."
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    wordpress config create \
		--dbname="$DB_NAME" \
		--dbuser="$DB_USER" \
    	--dbpass="$DB_PASSWORD" \
		--dbhost="$DB_HOST:$DB_PORT" \
		--path="$WP_PATH" \
		--allow-root
    echo "WordPress configuration created!"
else
    echo "WordPress config already exists!"
fi

#Installing WordPress...
if ! wordpress core is-installed --path="$WP_PATH" --allow-root; then
    echo "Installing WordPress..."
    wordpress core install \
		--url="$DOMAINE_NAME" \
		--title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
		--admin_password="$WP_ADMIN_PASS" \
        --admin_email="$WP_ADMIN_EMAIL" \
		--path="$WP_PATH" \
		--allow-root
    echo "WordPress installed!"
else
    echo "WordPress is already installed!"
fi

#Adding normal a user...
#echo "Creating normal WordPress user..."
#if ! wp user get "$WP_USER" --field=ID --path="$WP_PATH" --allow-root &> /dev/null; then
#    wp user create "$WP_USER" "$WP_USER_MAIL" --role="$ROLE" --user_pass="$USER_PASS" --path="$WP_PATH" --allow-root
#    echo "WordPress user $WP_USER created."
#else
#    echo "user already created....."
#fi

echo "Setting permissions..."
chown -R www-data:www-data "$WP_PATH"
echo "Permissions applied!"

echo "Configuring PHP-FPM to listen on TCP port $WP_PORT..."
sed -i "s|^listen = .*|listen = 0.0.0.0:$WP_PORT|" /etc/php/8.2/fpm/pool.d/www.conf
mkdir -p /run/php
echo "PHP-FPM is configured."

echo "Starting PHP-FPM..."
exec php-fpm8.2 -F

