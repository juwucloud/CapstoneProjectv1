#!/bin/bash

# -----------------------------
# System Update & Packages
# -----------------------------
dnf update -y
dnf install -y httpd mariadb1011-server-utils php php-mysqlnd php-fpm php-json php-mbstring php-xml php-gd unzip wget

# -----------------------------
# Enable & Start Services
# -----------------------------
systemctl enable --now httpd
# systemctl enable --now mariadb => only need tools dont start it

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
# Secure MariaDB not needed as using RDS
# -----------------------------
# MYSQL_ROOT_PASSWORD="${dbroot_password}"
# MYSQL_WP_PASSWORD="${dbuser_password}"

# mysql -u root <<EOF
# ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
# DELETE FROM mysql.user WHERE User='';
# DROP DATABASE IF EXISTS test;
# DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
# FLUSH PRIVILEGES;
# EOF





# -----------------------------
# Configure wp-config.php (RDS)
# -----------------------------
cd /var/www/html
cp wp-config-sample.php wp-config.php

# RDS variables (must be passed via Terraform variables or SSM or secrets manager)
DB_NAME="${db_name}"
DB_USER="${db_user}"
DB_PASSWORD="${db_password}"
DB_HOST="${db_endpoint}"        # e.g. mydb.xxxxxx.eu-central-1.rds.amazonaws.com

sed -i "s/database_name_here/$DB_NAME/" wp-config.php
sed -i "s/username_here/$DB_USER/" wp-config.php
sed -i "s/password_here/$DB_PASSWORD/" wp-config.php
sed -i "s/localhost/$DB_HOST/" wp-config.php


####################### -----------------------------
# Create WP Database + User
# -----------------------------
mysql -h $DB_HOST -u $DB_USER -p $DB_PASSWORD <<EOF
CREATE DATABASE $DB_NAME;
EOF

# -----------------------------
# Final Restart
# -----------------------------
systemctl restart httpd

