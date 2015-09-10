#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

#Install Mysql
type mysql >/dev/null 2>&1 || {
  echo 'Install Mysql'
  apt-get -q -y install mysql-server >/dev/null
  mysqladmin -u root password 123 >/dev/null

  echo 'Finished installing Mysql'
}
