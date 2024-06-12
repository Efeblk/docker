FROM alpine:3.15

RUN apk update && apk add mariadb mariadb-client mariadb-server-utils openrc

COPY ./conf/my.cnf /etc/my.cnf


RUN mkdir -p /run/mysqld /var/log/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql /var/log/mysql

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY ./tools/init.sql /var/www/initdb.sql

RUN openrc && touch /run/openrc/softlevel && \
    rc-service mariadb start && \
    mysql < /var/www/initdb.sql && \
    rm -f /var/www/initdb.sql

EXPOSE 3306

CMD ["mysqld"]
