#!/bin/bash
set -e

# Start MariaDB
mysqld_safe &

# Wait for MariaDB to start
while ! mysqladmin ping -uroot -p"$ROOT_PASSWORD" --silent; do
    sleep 1
done

# Create database and user
mysql -uroot -p"$ROOT_PASSWORD" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS $DATABASE;
    CREATE USER IF NOT EXISTS '$USER'@'%' IDENTIFIED BY '$PASSWORD';
    GRANT ALL PRIVILEGES ON $DATABASE.* TO '$USER'@'%';
    FLUSH PRIVILEGES;
EOSQL

# Keep container running
tail -f /dev/null