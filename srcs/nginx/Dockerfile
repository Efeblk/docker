FROM nginx:1.10.1-alpine

RUN apk update && apk add openssl

EXPOSE 443

COPY /src/nginx.conf /etc/nginx/nginx.conf
COPY /src/ssl.sh /var/www/ssl.sh
COPY /src/index.html /usr/share/nginx/html/index.html

RUN chmod +x /var/www/ssl.sh
RUN /bin/sh /var/www/ssl.sh

CMD ["nginx", "-g", "daemon off;"]
