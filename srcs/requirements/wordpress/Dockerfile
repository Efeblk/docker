FROM alpine:3.15

RUN apk update && apk add php7 php7-fpm php7-mysqli php7-pecl-redis php7-phar php7-mbstring php7-iconv php7-gd supervisor curl

RUN mkdir -p /var/www /var/log/php-fpm /var/run/php-fpm && \
    touch /var/log/php-fpm/error.log 

RUN adduser -D -g 'nginx' nginx

COPY ./conf/www.conf /etc/php7/php-fpm.d/www.conf

RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xzf wordpress.tar.gz -C /var/www/ && \
    mv /var/www/wordpress /var/www/html && \
    rm wordpress.tar.gz

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/wp-config.php /var/www/html/wp-config.php
COPY ./conf/supervisord.conf /etc/supervisord.conf
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]