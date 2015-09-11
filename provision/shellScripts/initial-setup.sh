#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

sh /vagrant/provision/shellScripts/packages/apache.sh

sh /vagrant/provision/shellScripts/packages/mysql.sh

sh /vagrant/provision/shellScripts/packages/php.sh

sh /vagrant/provision/shellScripts/packages/nodejs.sh

sh /vagrant/provision/shellScripts/packages/ant.sh

sh /vagrant/provision/shellScripts/packages/adminer.sh

sh /vagrant/provision/shellScripts/packages/ioncube.sh

sh /vagrant/provision/shellScripts/packages/newrelic.sh

