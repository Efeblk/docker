<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'user');
define('DB_PASSWORD', 'password');
define('DB_HOST', 'mariadb:3306');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

$table_prefix = 'wp_';

define('WP_DEBUG', false);

if (!defined('ABSPATH')) {
    define('ABSPATH', dirname(__FILE__) . '/');
}

require_once(ABSPATH . 'wp-settings.php');
