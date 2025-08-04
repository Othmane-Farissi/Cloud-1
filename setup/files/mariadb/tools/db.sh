#!/bin/bash
set -eo pipefail

# Initialize database if empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

# Start temporary server for setup
mysqld_safe --skip-networking --socket=/var/run/mysqld/mysqld.sock &
MYSQL_PID=$!

# Wait for server to start
for i in {1..30}; do
    mysqladmin --socket=/var/run/mysqld/mysqld.sock ping >/dev/null 2>&1 && break
    sleep 1
done

# Set root password and create database/user
mysql --socket=/var/run/mysqld/mysqld.sock <<-EOSQL
    SET @@SESSION.SQL_LOG_BIN=0;
    DELETE FROM mysql.user WHERE user NOT IN ('mysql.sys', 'mariadb.sys') OR host NOT IN ('localhost');
    SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}');
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

# Stop temporary server
kill $MYSQL_PID
wait $MYSQL_PID

# Start MariaDB normally
exec mysqld_safe