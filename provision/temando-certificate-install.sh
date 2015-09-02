#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

VAGRANT_CORE_FOLDER=$(echo "$1")

#Install wget
type wget >/dev/null 2>&1 || {
  echo 'Install wget'
  apt-get -y install wget >/dev/null
  echo 'Finished installing wget'
}

#Redownload cert.pem as there seems to be an issue with composer and ssl
if [ ! -f /usr/lib/ssl/cert.pem ];
    then
    wget http://curl.haxx.se/ca/cacert.pem >/dev/null
    mv cacert.pem /usr/lib/ssl/cert.pem >/dev/null
fi

if ! grep -n 'openssl.cafile=/usr/lib/ssl/cert.pem' /etc/php5/cli/php.ini;
    then
    echo "openssl.cafile=/usr/lib/ssl/cert.pem" | tee -a /etc/php5/cli/php.ini
    echo "openssl.cafile=/usr/lib/ssl/cert.pem" | tee -a /etc/php5/apache2/php.ini
fi

#Download the cert from packages.temando.com to resolve the composer issue http://104.236.178.120/container-boxes/vagrant-dev55-libvirt/issues/1
if [ ! - f /usr/local/share/ca-certificates/temando.com.crt ];
    then
    openssl s_client -connect packages.temando.com:443 -showcerts </dev/null 2>/dev/null|openssl x509 -outform PEM >/usr/local/share/ca-certificates/temando.com.crt
    update-ca-certificates >/dev/null
fi

#Reload apache to resolve ssl items
service apache2 reload >/dev/null