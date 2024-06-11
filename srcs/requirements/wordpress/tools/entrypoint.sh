#!/bin/sh

# Ensure necessary environment variables are set
if [ -z "$WP_TITLE" ] || [ -z "$WP_ADMIN_LOGIN" ] || [ -z "$WP_ADMIN_PASSWORD" ] || [ -z "$WP_ADMIN_EMAIL" ] || [ -z "$WORDPRESS_DB_NAME" ] || [ -z "$WORDPRESS_DB_USER" ] || [ -z "$WORDPRESS_DB_PASSWORD" ] || [ -z "$WORDPRESS_DB_HOST" ]; then
    echo "Missing one or more required environment variables."
    exit 1
fi

# Check if WordPress is already installed
if ! wp core is-installed --path=/var/www/html --allow-root; then
    echo "Configuring WordPress..."
    wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --path=/var/www/html --allow-root
    echo "Installing WordPress..."
    wp core install --url="https://ibalik.42.fr" --title="$WP_TITLE" --admin_user="$WP_ADMIN_LOGIN" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --path=/var/www/html --allow-root
else
    echo "WordPress is already installed."
fi

# Ensure correct file permissions
chown -R nginx:nginx /var/www/html

# Start supervisord
exec "$@"
