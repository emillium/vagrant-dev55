#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

VAGRANT_CORE_FOLDER=$(echo "$1")

if [ -f ${VAGRANT_CORE_FOLDER}/bash/.bash_aliases ] && [ ! -f /home/vagrant/.bash_aliases ]; then
  cp "${VAGRANT_CORE_FOLDER}/bash/.bash_aliases" /home/vagrant/.bash_aliases
fi

if [ -f ${VAGRANT_CORE_FOLDER}/bash/.bash_git ] && [ ! -f /home/vagrant/.bash_git ]; then
  cp "${VAGRANT_CORE_FOLDER}/bash/.bash_git" /home/vagrant/.bash_git
fi

if [ -f /home/vagrant/.bash_aliases ]; then
  chown vagrant:vagrant /home/vagrant/.bash_aliases
fi

if [ -f /home/vagrant/.bash_git ]; then
  chown vagrant:vagrant /home/vagrant/.bash_git
fi

source /home/vagrant/.bashrc
