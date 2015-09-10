#!/usr/bin/env bash
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