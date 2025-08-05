FROM mariadb:10.6

# Use official image instead of manual install
COPY conf/50-server.cnf /etc/mysql/conf.d/
COPY tools/mysqlsc.sh /docker-entrypoint-initdb.d/

RUN chmod +x /docker-entrypoint-initdb.d/mysqlsc.sh && \
    chown -R mysql:mysql /var/lib/mysql