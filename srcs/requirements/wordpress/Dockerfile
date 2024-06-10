# Start with the Alpine base image
FROM alpine:3.15

# Install necessary packages for WordPress
RUN apk update && apk add php7 php7-fpm php7-mysqli php7-pecl-redis supervisor curl

# Create necessary directories and set permissions
RUN mkdir -p /var/www /var/log/php-fpm /var/run/php-fpm && \
    touch /var/log/php-fpm/error.log 

# Add nginx user and group
RUN adduser -D -g 'nginx' nginx

# Configure PHP-FPM to listen on port 9000
COPY ./conf/www.conf /etc/php7/php-fpm.d/www.conf

# Download and extract WordPress
RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xzf wordpress.tar.gz -C /var/www/ && \
    mv /var/www/wordpress /var/www/html && \
    rm wordpress.tar.gz

# Copy custom configuration files
COPY ./tools/wp-config.php /var/www/html/wp-config.php
COPY ./conf/supervisord.conf /etc/supervisord.conf

# Expose port 9000 internally
EXPOSE 9000

# Command to start services
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
