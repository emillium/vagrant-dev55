#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

# wget "http://www.adminer.org/latest.php" -O /usr/share/adminer/latest.php
if [ -f /usr/share/adminer/latest.php ]; then
  wget "http://www.adminer.org/latest.php" -O /usr/share/adminer/latest.php
fi

if [ ! -f /usr/share/adminer/latest.php ]; then
  mkdir /usr/share/adminer
  wget "http://www.adminer.org/latest.php" -O /usr/share/adminer/latest.php
  ln -s /usr/share/adminer/latest.php /usr/share/adminer/adminer.php
  echo "Alias /adminer.php /usr/share/adminer/adminer.php" | tee /etc/apache2/conf-available/adminer.conf
  a2enconf adminer.conf
  service apache2 restart
fi
