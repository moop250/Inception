#!/bin/bash

# Start MariaDB service
mysqld_safe &

# Wait for the service to be ready
until mysqladmin ping --silent; do
  echo "Waiting for MariaDB to start..."
  sleep 1
done

# Check if the database already exists
if mysql -u root -e "USE $SQL_DATABASE" 2>/dev/null; then
  echo "Database $SQL_DATABASE already exists. Skipping setup."
else
  # Create and setup database
  mysql -u root <<EOF
  CREATE DATABASE IF NOT EXISTS \`$SQL_DATABASE\`;
  CREATE USER IF NOT EXISTS \`$SQL_USER\`@'%' IDENTIFIED BY '$SQL_PASSWORD';
  GRANT ALL PRIVILEGES ON \`$SQL_DATABASE\`.* TO \`$SQL_USER\`@'%';
  ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';
  FLUSH PRIVILEGES;
  EOF
fi

# Restart MariaDB service
mysqladmin -u root -p"$SQL_ROOT_PASSWORD" shutdown
exec mysqld_safe
