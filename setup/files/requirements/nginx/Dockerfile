FROM debian:bookworm

RUN apt update && apt install nginx -y && apt install openssl -y

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY tools/ssl.sh /tmp/


RUN chmod +x /tmp/ssl.sh && /tmp/ssl.sh

EXPOSE 443

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]