#!/bin/sh

# Check if WordPress is already installed
if ! $(wp core is-installed --path=/var/www/html --allow-root); then
    echo "Installing WordPress..."
    wp core install --url="http://localhost" --title="Your Blog Title" --admin_user="admin" --admin_password="admin_password" --admin_email="you@example.com" --path=/var/www/html --allow-root
    wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --path=/var/www/html --allow-root
else
    echo "WordPress is already installed."
fi

# Start supervisord
exec "$@"
