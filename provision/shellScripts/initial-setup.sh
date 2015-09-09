#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

#Install Apache
type apache2 >/dev/null 2>&1 || {
  echo 'Installing Apache'
  apt-get -y -qq install apache2 >/dev/null;

  usermod -a -G www-data vagrant >/dev/null

  echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf
  a2enconf fqdn >/dev/null

  service apache2 reload >/dev/null

  a2enmod ssl
  mkdir /etc/apache2/ssl
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt -subj "/C=AU/ST=QLD/L=Brisbane/O=Dis/CN=*.vagrant.dev55"

  cp "/vagrant/provision/files/apache/virtual.conf" '/etc/apache2/sites-available/virtual.conf'
  a2enmod vhost_alias
  a2ensite virtual.conf
  service apache2 reload

  a2enmod rewrite

  echo 'Finished installing Apache'
}

#Install Mysql
type mysql >/dev/null 2>&1 || {
  echo 'Install Mysql'
  apt-get -q -y install mysql-server >/dev/null
  mysqladmin -u root password 123 >/dev/null

  echo 'Finished installing Mysql'
}

#Install PHP
type php >/dev/null 2>&1 || {
  echo 'Add PHP repo'
  add-apt-repository ppa:ondrej/php5 >/dev/null

  echo 'update repo'
  apt-get update >/dev/null
  apt-get install python-software-properties >/dev/null

  echo 'Install PHP'
  apt-get -y -qq install php5 php5-cli php5-mysql php5-curl php5-intl php5-ssh2 php5-redis php-http php5-dev php5-xdebug >/dev/null
  echo 'Finished installing PHP'
}

#Reload apache to resolve ssl items
service apache2 reload >/dev/null
