#!/bin/sh

###############################################
# 
# patch for SEED VM 12.04
# author: Kailiang kying@syr.edu
#
###############################################

mysql -u root -pseedubuntu -e "CREATE DATABASE if not exists Users; "
mysql -u root -pseedubuntu Users < Users.sql
sudo mkdir /var/www/SQLInjection
sudo cp *.css *.php *.html /var/www/SQLInjection
if grep -q "127.0.0.1       www.SeedLabSQLInjection.com" /etc/hosts; then
    echo "SEED SQL Injection lab local host already set" 
else
    sudo sh -c "echo '127.0.0.1       www.SeedLabSQLInjection.com' >> /etc/hosts"
fi
if grep -q "http://www.SeedLabSQLInjection.com" /etc/apache2/sites-available/default; then
    echo "SEED SQL Injection lab virtual host already set"
else
    sudo sh -c "echo '<VirtualHost *:80>' >> /etc/apache2/sites-available/default"
    sudo sh -c "echo '        ServerName http://www.SeedLabSQLInjection.com' >> /etc/apache2/sites-available/default"
    sudo sh -c "echo '        DocumentRoot /var/www/SQLInjection' >> /etc/apache2/sites-available/default"
    sudo sh -c "echo '</VirtualHost>' >> /etc/apache2/sites-available/default"
    sudo service apache2 restart
fi



