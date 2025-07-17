#!/bin/bash

wait_for_mariadb() {
	echo "Waiting for MariaDB to be ready..."
	while ! mariadb -h "$DB_HOST" -u "$SQL_USER" -p"$SQL_PASSWORD" -e "SELECT 1;" >/dev/null 2>&1; do
		echo "MariaDB is unavailable - sleeping"
		sleep 1
	done
	echo "MariaDB is up - continuing with WordPress setup"
}

# let mdb_init.sh finish
sleep 5

if [ -f wp-config.php ]
then
	echo "Wordpress already installed"
else
	echo "Installing and configuring wordpress"
	wait_for_mariadb
# autofill wp startup fields
	wp core download --allow-root
	wp config create --allow-root --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --dbhost=$DB_HOST --skip-check
	wp core install --allow-root --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email
	wp user create --allow-root $WP_USER $WP_EMAIL --user_pass=$WP_PASS --role='contributor'

# Bonus

	echo "Installing and setting up the redis-cache plugin"
	wp config set WP_REDIS_HOST redis --allow-root
	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
	wp plugin install redis-cache --activate --allow-root
	wp plugin update --all --allow-root
	wp redis enable --allow-root
fi

# launch php-fpm
exec /usr/sbin/php-fpm8.2 -F
