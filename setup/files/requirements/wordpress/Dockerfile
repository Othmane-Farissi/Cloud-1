FROM debian:bullseye

# 1. Install all dependencies in one layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo \
    wget \
    php7.4 php7.4-fpm php7.4-mysql mariadb-client \
    ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 2. Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# 3. Configure PHP-FPM and create directories
RUN mkdir -p /run/php && \
    mkdir -p /var/www/html && \
    chown -R www-data:www-data /run/php /var/www/html

# 4. Copy configuration files
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf 
COPY tools/cli-config.sh /var/www/html/cli-config.sh
RUN chmod +x /var/www/html/cli-config.sh

# 5. Set working directory
WORKDIR /var/www/html
ENTRYPOINT ["sh", "/var/www/html/cli-config.sh"]