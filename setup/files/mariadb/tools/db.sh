service mysql start
mysql -e "CREATE DATABASE IF NOT EXISTS $MY_DATABASE ;"
mysql -e "CREATE USER IF NOT EXISTS $MYSQL_USER@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;"
mysql -e "GRANT ALL PRIVILEGES ON $MY_DATABASE.* TO $MYSQL_USER@'%' ;"
#mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MY_ROOT';"
#kill $(cat /var/run/mysqld/mysqld.pid)
echo "database  and user created succesfuly"
service mysql stop
mysqld_safe