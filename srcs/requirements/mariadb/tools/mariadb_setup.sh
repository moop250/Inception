#!/bin/sh

# Start MariaDB service
mariadb-install-db --user=mysql --datadir=/var/lib/mysql --bind_address=0.0.0.0 --port=3306 --tmpdir=/tmp > /dev/null 2> /dev/null
mariadbd --user=mysql &
MARIADB_PID=$!

# Wait for the service to be ready
while ! mariadb -u root -h localhost -p"$SQL_ROOT_PASSWORD" -e "SELECT 1;" >/dev/null 2>&1; do
	echo "Waiting for MariaDB to start..."
	sleep 1
done

# Check if the database already exists
if mariadb -u root -h localhost -p"$SQL_ROOT_PASSWORD" -e "USE $SQL_DATABASE" 2>/dev/null; then
  echo "Database $SQL_DATABASE already exists. Skipping setup."
else
  # Create and setup database
  mariadb -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`$SQL_DATABASE\`;
CREATE USER IF NOT EXISTS \`$SQL_USER\`@'%' IDENTIFIED BY '$SQL_PASSWORD';
GRANT ALL PRIVILEGES ON \`$SQL_DATABASE\`.* TO \`$SQL_USER\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF
fi

# Wait for the mariadb to finish
echo "MariaDB is running"
wait "$MARIADB_PID"
