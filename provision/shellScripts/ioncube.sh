# Ioncube
pushd /root/
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
tar zxvf ioncube_loaders_lin_x86-64.tar.gz
cp ioncube/ioncube_loader_lin_5.5.so /usr/lib/php5/20121212/
echo "zend_extension = /usr/lib/php5/20121212/ioncube_loader_lin_5.5.so" | sudo tee -a /etc/php5/apache2/php.ini
popd
