#!/bin/bash

set -e

sleep 10

WP_PATH="/var/www/html"

if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root --path="$WP_PATH"

    echo "Creating wp-config.php..."
    wp config create \
        --allow-root \
        --dbname=$DATABASE \
        --dbuser=$USER \
        --dbpass=$USER_PASSWORD \
        --dbhost=mariadb:3306 \
        --path="$WP_PATH"

    echo "Installing WordPress..."
    wp core install \
        --allow-root \
        --title="$TITLE" \
        --url="$IP" \
        --admin_user="$ADMIN_USER" \
        --admin_password="$ADMIN_PASSWORD" \
        --admin_email="$ADMIN_EMAIL" \
        --path="$WP_PATH"

    echo "Creating test user..."
    wp user create testuser testuser@42.fr \
        --role=author \
        --user_pass="23061966" \
        --allow-root \
        --path="$WP_PATH"
fi

exec php-fpm7.4 -F -R
