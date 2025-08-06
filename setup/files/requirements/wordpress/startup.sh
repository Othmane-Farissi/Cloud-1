#!/bin/bash
# Copy the config file to the correct location
cp /tmp/cli-config.sh /var/www/html/cli-config.sh
chmod +x /var/www/html/cli-config.sh

# Start PHP-FPM
exec php-fpm7.4 -F