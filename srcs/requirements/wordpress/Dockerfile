FROM debian:12

RUN apt update && apt install -y \
    curl \
    php8.2 \
    php-fpm \
    php-mysql \
    mariadb-client

COPY ./tools/script.sh /wordpress.sh

RUN chmod +x wordpress.sh

ENTRYPOINT ["/wordpress.sh"]