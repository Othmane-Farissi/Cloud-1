FROM debian:bullseye

# Install dependencies in single RUN to reduce layers
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo \
    wget \
    php7.4 php7.4-fpm php7.4-mysql mariadb-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates && \
    update-ca-certificates && \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM
RUN mkdir -p /run/php && \
    chown -R www-data:www-data /run/php

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY tools/cli-config.sh /var/www/html/  # Changed from /var/www/wordpress/
RUN chmod +x /var/www/html/cli-config.sh

# Update WORKDIR to match
WORKDIR /var/www/html
ENTRYPOINT ["sh", "cli-config.sh"]