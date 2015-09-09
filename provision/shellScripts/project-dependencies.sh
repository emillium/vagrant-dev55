#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

#Install Composer
if [ ! -f /usr/local/bin/composer ]; then
    curl -sS https://getcomposer.org/installer | php >/dev/null
    mv composer.phar /usr/local/bin/composer >/dev/null
fi

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

type ant >/dev/null 2>&1 || {
  echo 'Install ant'
  apt-get -y install ant >/dev/null
  echo 'Finished installing ant'
}

if ! grep -n '127.0.0.1 single-sign-on.vagrant.dev55' /etc/hosts;
  then
    echo '127.0.0.1 single-sign-on.vagrant.dev55' | tee -a /etc/hosts
fi

if ! grep -n 'export APPLICATION_ENV="development"' /home/vagrant/.profile;
  then
    echo 'export APPLICATION_ENV="development"' | tee -a /home/vagrant/.profile
fi

if ! grep -n 'xdebug.idekey=PHPSTORM' /etc/php5/mods-available/xdebug.ini;
  then
    yes | cp "/vagrant/provision/files/xdebug/xdebug.ini" /etc/php5/mods-available
    php5dismod xdebug
    php5enmod xdebug
fi

#Nodejs items required by single sign on
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
