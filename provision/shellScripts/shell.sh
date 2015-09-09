#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

if [ -f /vagrant/provision/files/bash/.bash_aliases ] && [ ! -f /home/vagrant/.bash_aliases ]; then
  cp "/vagrant/provision/files/bash/.bash_aliases" /home/vagrant/.bash_aliases
fi

if [ -f /vagrant/provision/files/bash/.bash_git ] && [ ! -f /home/vagrant/.bash_git ]; then
  cp "/vagrant/provision/files/bash/.bash_git" /home/vagrant/.bash_git
fi

if [ -f /home/vagrant/.bash_aliases ]; then
  chown vagrant:vagrant /home/vagrant/.bash_aliases
fi

if [ -f /home/vagrant/.bash_git ]; then
  chown vagrant:vagrant /home/vagrant/.bash_git
fi

source /home/vagrant/.bashrc
