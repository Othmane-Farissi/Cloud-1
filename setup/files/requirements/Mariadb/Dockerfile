FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install -y mariadb-server

RUN mkdir -p /var/run/mysqld /var/log/mysql && \
    chown -R mysql:mysql /var/run/mysqld /var/log/mysql && \
    chmod 777 /var/run/mysqld && \
    chmod 755 /var/log/mysql

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/


COPY ./tools/init_db.sh /docker-entrypoint-initdb.d/  
RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

EXPOSE 3306

CMD ["/docker-entrypoint-initdb.d/init_db.sh"]