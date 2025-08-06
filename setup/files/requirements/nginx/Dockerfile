FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y 

RUN apt-get install apt-utils nginx openssl -y

# Set up WordPress directory
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html

# Nginx config
COPY conf/wordpress /etc/nginx/sites-available/wordpress
COPY conf/*.conf /etc/nginx/snippets/
RUN ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/wordpress && \
    rm /etc/nginx/sites-enabled/default

# SSL cert
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=MA/ST=IDF/L=CASABLANCA/O=1337/OU=1337/CN=hfanzaou.42.fr/UID=hfanzaou"

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
