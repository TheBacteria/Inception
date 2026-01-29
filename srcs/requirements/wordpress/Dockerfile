FROM debian:12

RUN apt update && apt install -y \
    curl \
    php8.2 \
    php8.2-fpm \
    php8.2-mysql \
    mariadb-client

RUN curl -o wp-cli.phar -s https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wordpress

COPY ./tools/script.sh /wordpress.sh

RUN chmod +x wordpress.sh

EXPOSE 9000

ENTRYPOINT ["/wordpress.sh"]