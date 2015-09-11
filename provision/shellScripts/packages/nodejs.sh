#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

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
