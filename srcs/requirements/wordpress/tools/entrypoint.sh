#!/bin/sh

if ! $(wp core is-installed --path=/var/www/html --allow-root); then
    echo "Installing WordPress..."
    wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_LOGIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --path=/var/www/html --allow-root
    wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --path=/var/www/html --allow-root
    wp user create "$WP_NEW_USER_LOGIN" "$WP_NEW_USER_EMAIL" --user_pass="$WP_NEW_USER_PASSWORD" --role=subscriber --path=/var/www/html --allow-root
else
    echo "WordPress is already installed."
fi

exec "$@"