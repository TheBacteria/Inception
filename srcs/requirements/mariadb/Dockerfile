FROM debian:12

RUN apt update && apt install -y mariadb-server

COPY tools/script.sh /mariadb.sh

RUN chmod +x /mariadb.sh

CMD ["mysqld_safe"]