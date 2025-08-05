#!/bin/bash
set -e

# Start MariaDB
mysqld_safe &

 # Wait for MariaDB to start
if [ -n "$ROOT_PASSWORD" ]; then
    MYSQL_PWD_ARG="-p$ROOT_PASSWORD"
else
    MYSQL_PWD_ARG=""
fi
while ! mysqladmin ping -uroot $MYSQL_PWD_ARG --silent; do
    sleep 1
done

 # Create database and user
mysql -uroot $MYSQL_PWD_ARG <<-EOSQL
    CREATE DATABASE IF NOT EXISTS $DATABASE;
    CREATE USER IF NOT EXISTS '$USER'@'%' IDENTIFIED BY '$USER_PASSWORD';
    GRANT ALL PRIVILEGES ON $DATABASE.* TO '$USER'@'%';
    FLUSH PRIVILEGES;
EOSQL

# Keep container running
tail -f /dev/null