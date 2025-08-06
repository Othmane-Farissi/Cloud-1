#!/bin/bash

# Wait for MariaDB to fully start
until mariadb-admin ping --silent; do
  echo "⏳ Waiting for MariaDB to be available..."
  sleep 2
done

# Now use authenticated root access
echo "✅ MariaDB is up, running initialization..."

mariadb -u root -p"${ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS \`${DATABASE}\`;
CREATE USER IF NOT EXISTS \`${USER}\`@'%' IDENTIFIED BY '${USER_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DATABASE}\`.* TO \`${USER}\`@'%';
FLUSH PRIVILEGES;
EOF

# Do NOT shut down the database!
echo "✅ Initialization done."
