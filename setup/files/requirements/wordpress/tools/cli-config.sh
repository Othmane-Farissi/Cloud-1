#!/bin/bash
set -e

# Wait for database
while ! mysqladmin ping -h"mariadb" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" --silent; do
    sleep 1
done

# Install WordPress if not installed
if [ ! -f wp-config.php ]; then
    wp core download --allow-root
    wp config create \
        --dbname="$DATABASE"\
        --dbuser="$USER"\
        --dbpass="$USER_PASSWORD" \
        --dbhost="mariadb" \
        --allow-root
    
    wp core install \
        --url="$IP" \
        --title="$TITLE" \
        --admin_user="$ADMIN_USER" \
        --admin_password="$ADMIN_PASS" \
        --admin_email="$ADMIN_EMAIL" \
        --allow-root
fi

# Start PHP-FPM
exec php-fpm8.2 -F