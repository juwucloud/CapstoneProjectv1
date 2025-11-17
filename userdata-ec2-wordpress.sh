#!/bin/bash

# -----------------------------
# System Update & Packages
# -----------------------------
dnf update -y
dnf install -y httpd mariadb1011-server php php-mysqlnd php-fpm php-json php-mbstring php-xml php-gd unzip wget

# -----------------------------
# Enable & Start Services
# -----------------------------
systemctl enable --now httpd
systemctl enable --now mariadb

# -----------------------------
# Download & Install WordPress
# -----------------------------
cd /tmp
wget https://wordpress.org/latest.zip
unzip latest.zip

# Move WP files
mv wordpress/* /var/www/html/

# Permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# -----------------------------
# Configure Apache default index
# -----------------------------
sed -i 's/DirectoryIndex.*/DirectoryIndex index.php index.html/' /etc/httpd/conf/httpd.conf
systemctl restart httpd

# -----------------------------
# Secure MariaDB (non-interactive)
# -----------------------------
MYSQL_ROOT_PASSWORD="root"
MYSQL_WP_PASSWORD="user"c

mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
FLUSH PRIVILEGES;
EOF

# -----------------------------
# Create WP Database + User
# -----------------------------
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE wordpressdb;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY '${MYSQL_WP_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpressdb.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
EOF

# -----------------------------
# Configure wp-config.php
# -----------------------------
cd /var/www/html
cp wp-config-sample.php wp-config.php

sed -i "s/database_name_here/wordpressdb/" wp-config.php
sed -i "s/username_here/wpuser/" wp-config.php
sed -i "s/password_here/${MYSQL_WP_PASSWORD}/" wp-config.php
sed -i "s/localhost/localhost/" wp-config.php

# -----------------------------
# Final Restart
# -----------------------------
systemctl restart httpd
systemctl restart mariadb
