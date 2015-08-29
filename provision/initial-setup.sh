#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

VAGRANT_CORE_FOLDER=$(echo "$1")

echo 'Running initial-setup apt-get update and upgrade'
apt-get update >/dev/null
apt-get upgrade >/dev/null
echo 'Finished running initial-setup apt-get update and upgrade'

type curl >/dev/null 2>&1 || {
  echo 'Installing curl'
  apt-get -y install curl >/dev/null;
  echo 'Finished installing curl'
}

type git >/dev/null 2>&1 || {
  echo 'Installing git'
  apt-get -y install git-core >/dev/null;
  echo 'Finished installing git'
}

echo 'Installing build-essential packages'
apt-get -y install build-essential >/dev/null
echo 'Finished installing build-essential packages'

type apache2 >/dev/null 2>&1 || {
  echo 'Installing Apache'
  apt-get -y -qq install apache2 >/dev/null;

  usermod -a -G www-data vagrant >/dev/null

  echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf
  a2enconf fqdn >/dev/null

  service apache2 reload >/dev/null

  a2enmod ssl
  mkdir /etc/apache2/ssl
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt -subj "/C=AU/ST=QLD/L=Brisbane/O=Dis/CN=*vagrant.dev55"

  cp "${VAGRANT_CORE_FOLDER}/virtual.conf" '/etc/apache2/sites-available/virtual.conf'
  a2enmod vhost_alias
  a2ensite virtual.conf
  service apache2 reload


  echo 'Finished installing Apache'
}

type mysql >/dev/null 2>&1 || {
  echo 'Install Mysql'
  apt-get -q -y install mysql-server >/dev/null
  mysqladmin -u root password 123 >/dev/null

  echo 'Finished installing Mysql'
}

type php >/dev/null 2>&1 || {
  echo 'Add PHP repo'
  add-apt-repository ppa:ondrej/php5-5.6 >/dev/null

  echo 'update repo'
  apt-get update >/dev/null
  apt-get install python-software-properties >/dev/null

  echo 'Install PHP'
  apt-get -y -qq install php5 php5-cli php5-mysql php5-curl php5-intl php5-ssh2 php5-redis php-http php5-dev php5-xdebug >/dev/null
  echo 'Finished installing PHP'
}

type wget >/dev/null 2>&1 || {
  echo 'Install wget'
  apt-get -y install wget >/dev/null
  echo 'Finished installing wget'
}

if [ ! -f /usr/lib/ssl/cert.pem ]; then
    wget http://curl.haxx.se/ca/cacert.pem >/dev/null
    mv cacert.pem /usr/lib/ssl/cert.pem >/dev/null
fi

if ! grep -n 'openssl.cafile=/usr/lib/ssl/cert.pem' /etc/php5/cli/php.ini;
  then
  echo "openssl.cafile=/usr/lib/ssl/cert.pem" | tee -a /etc/php5/cli/php.ini
  echo "openssl.cafile=/usr/lib/ssl/cert.pem" | tee -a /etc/php5/apache2/php.ini
fi


service apache2 reload >/dev/null

if [ ! -f /usr/local/bin/composer ]; then
    curl -sS https://getcomposer.org/installer | php >/dev/null
    mv composer.phar /usr/local/bin/composer >/dev/null
fi

if [ ! -f /etc/php5/mods-available/http.ini ]; then
    #Install pecl module non-interactively
    printf "\n" | sudo pecl install pecl_http

    #export and install missing extensions

    echo "extension=/usr/lib/php5/20131226/raphf.so" | tee -a /etc/php5/mods-available/raphf.ini
    echo "; priority=25" | tee -a /etc/php5/mods-available/raphf.ini
    php5enmod raphf

    echo "extension=/usr/lib/php5/20131226/propro.so" | sudo tee -a /etc/php5/mods-available/propro.ini
    echo "; priority=30" | tee -a /etc/php5/mods-available/propro.ini
    php5enmod propro

    #Install pecl module non-interactively
    printf "\n" | sudo pecl install pecl_http

    #add http module
    echo "extension=/usr/lib/php5/20131226/http.so" | tee -a /etc/php5/mods-available/http.ini
    echo "; priority=35" | tee -a /etc/php5/mods-available/http.ini
    php5enmod http

    echo "File not found!"
fi


type ant >/dev/null 2>&1 || {
  echo 'Install ant'
  apt-get -y install ant >/dev/null
  echo 'Finished installing ant'
}

if ! grep -n 'export APPLICATION_ENV="development"' /home/vagrant/.profile;
  then
    echo 'export APPLICATION_ENV="development"' | tee -a /home/vagrant/.profile
fi

type node >/dev/null 2>&1 || {
  echo 'Install node js'
  apt-get -y install nodejs >/dev/null
  echo 'Symlink nodejs to node'
  ln -s /usr/bin/nodejs /usr/bin/node
  echo 'Node Js Installed'

  apt-get -y install npm >/dev/null

  echo 'Install Bower'
  npm install -g bower >/dev/null
  echo 'Bower Installed'

  echo 'Install Grunt'
  npm install -g grunt-cli
  echo 'Grunt Installed'
}
