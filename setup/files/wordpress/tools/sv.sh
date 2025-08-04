#!/bin/bash

# Wait for DB to be ready
until mysqladmin ping -h"$DB_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
  echo "Waiting for database at $DB_HOST..."
  sleep 2
done

# Download and install WP if not already present
if [ ! -f /var/www/html/wp-config.php ]; then
  echo "Downloading WordPress..."
  wp core download --allow-root

  echo "Creating wp-config.php..."
  wp config create \
    --dbname="$MYSQL_DATABASE" \
    --dbuser="$MYSQL_USER" \
    --dbpass="$MYSQL_PASSWORD" \
    --dbhost="$DB_HOST" \
    --allow-root

  echo "Installing WordPress..."
  wp core install \
    --url="http://${IP}" \
    --title="${BLOG_TITLE}" \
    --admin_user="${AD_USER}" \
    --admin_password="${AD_PASSWORD}" \
    --admin_email="${AD_EMAIL}" \
    --allow-root
fi

echo "Trying to connect to DB at host: $WORDPRESS_DB_HOST, user: $MYSQL_USER"

# Start PHP-FPM
php_fpm_bin=$(find /usr/sbin /usr/local/sbin /usr/bin -name "php*-fpm" | head -n 1)

if [ -x "$php_fpm_bin" ]; then
  exec "$php_fpm_bin" -F
else
  echo "⚠️ Could not find php-fpm binary."
  exit 1
fi
