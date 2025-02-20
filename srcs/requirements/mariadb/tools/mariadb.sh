#!/bin/sh

# Initialize MariaDB data directory
mysql_install_db

# Start MariaDB service
/etc/init.d/mysql start

# Check if the database already exists
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "Database already exists"
else
    # Secure MariaDB installation using environment variables
    mysql_secure_installation << EOF

Y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
Y
n
Y
Y
EOF

    # Grant remote access to root user
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;"

    # Create database and user for WordPress
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;"

    # Import SQL file into the database
    mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql
fi

# Stop MariaDB service to allow the container to start it in the foreground
/etc/init.d/mysql stop

# Execute any command passed to the script
exec "$@"

