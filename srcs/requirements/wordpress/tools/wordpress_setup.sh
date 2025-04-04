#!/bin/bash

# let mdb_init.sh finish
sleep 5

if [ -f wp-config.php ]
then
	echo "Wordpress already installed"
else
# autofill wp startup fields
	wp core download --allow-root
	wp config create --allow-root --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --dbhost=$DB_HOST --skip-check
	wp core install --allow-root --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email
	wp user create --allow-root $WP_USER $WP_EMAIL --user_pass=$WP_PASS --role='contributor'

# Bonus

	wp config set WP_REDIS_HOST redis --allow-root
	wp config set WP_REDIS_PORT 6379 --raw --allow-root
#	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
#	wp config set WP_REDIS_CLIENT phpredis --allow-root
	wp plugin install redis-cache --activate --allow-root
	wp plugin update --all --allow-root
	wp redis enable --allow-root
	
fi

# launch php-fpm
exec /usr/sbin/php-fpm8.2 -F
