# Start with the Alpine base image
FROM alpine:3.15

# Install necessary packages for MariaDB
RUN apk update && apk add mariadb mariadb-client mariadb-server-utils openrc

# Copy custom configuration files
COPY ./conf/my.cnf /etc/my.cnf

# Create necessary directories and set permissions
RUN mkdir -p /run/mysqld /var/log/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql /var/log/mysql

# Initialize MariaDB data directory
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Copy initialization script
COPY ./tools/init.sql /var/www/initdb.sql

# Manually start MariaDB, run the initialization script
RUN openrc && touch /run/openrc/softlevel && \
    rc-service mariadb start && \
    mysql < /var/www/initdb.sql && \
    rm -f /var/www/initdb.sql

# Expose the default MySQL port
EXPOSE 3306

# Command to start MariaDB
CMD ["mysqld"]
