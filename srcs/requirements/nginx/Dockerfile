FROM debian:12

RUN apt update && apt install -y nginx openssl

RUN rm -f /etc/nginx/sites-enabled/default

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -newkey rsa:4096 -nodes -days 365 \
    -subj "/C=MA/ST=KH/L=KH/O=42/OU=IT/CN=mzouine.42.fr" \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt

COPY ./conf/nginx.conf /etc/nginx/sites-enabled/default

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]