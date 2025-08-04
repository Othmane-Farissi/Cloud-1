#!/bin/bash

# Start PHP-FPM in background
service php-fpm start

# Wait for database to be ready
while ! mysqladmin ping -h"db" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
  echo "Waiting for database..."
  sleep 2
done

# Configure WordPress
if [ ! -f /var/www/html/wp-config.php ]; then
  wp core download --allow-root
  wp config create \
    --dbname="$MYSQL_DATABASE" \
    --dbuser="$MYSQL_USER" \
    --dbpass="$MYSQL_PASSWORD" \
    --dbhost="db" \
    --allow-root
  
  wp core install \
    --url="http://${IP:-localhost}" \
    --title="${BLOG_TITLE:-WordPress}" \
    --admin_user="${AD_USER:-admin}" \
    --admin_password="${AD_PASSWORD:-password}" \
    --admin_email="${AD_EMAIL:-admin@example.com}" \
    --allow-root
fi

# Keep PHP-FPM running in foreground
php-fpm7.3 -F