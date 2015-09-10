#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

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

  # install deps API project
  apt-get install libmagic-dev libpcre3-dev imagemagick libmagickwand-dev libmagickcore-dev

  echo "extension=imagick.so" | sudo tee -a /etc/php5/mods-available/imagick.ini
  php5enmod imagick
}

if [ ! -f /etc/php5/mods-available/http.ini ]; then
    #Install pecl module non-interactively
    printf "\n" | pecl install pecl_http

    #export and install missing extensions

    echo "extension=/usr/lib/php5/20121212/raphf.so" | tee -a /etc/php5/mods-available/raphf.ini
    echo "; priority=25" | tee -a /etc/php5/mods-available/raphf.ini
    php5enmod raphf

    echo "extension=/usr/lib/php5/20121212/propro.so" | tee -a /etc/php5/mods-available/propro.ini
    echo "; priority=30" | tee -a /etc/php5/mods-available/propro.ini
    php5enmod propro

    #Install pecl module non-interactively
    printf "\n" | pecl install pecl_http

    #add http module
    echo "extension=/usr/lib/php5/20121212/http.so" | tee -a /etc/php5/mods-available/http.ini
    echo "; priority=35" | tee -a /etc/php5/mods-available/http.ini
    php5enmod http

    echo "File not found!"
fi

if ! grep -n 'xdebug.idekey=PHPSTORM' /etc/php5/mods-available/xdebug.ini;
  then
    yes | cp "/vagrant/provision/files/xdebug/xdebug.ini" /etc/php5/mods-available
    php5dismod xdebug
    php5enmod xdebug
fi

#Install Composer
if [ ! -f /usr/local/bin/composer ]; then
    curl -sS https://getcomposer.org/installer | php >/dev/null
    mv composer.phar /usr/local/bin/composer >/dev/null
fi

#Reload apache to resolve ssl items
service apache2 reload >/dev/null
