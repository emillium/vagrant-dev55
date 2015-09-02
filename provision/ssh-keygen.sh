#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

VAGRANT_CORE_FOLDER=$(echo "$1")

cp "${VAGRANT_CORE_FOLDER}/ssh/id_rsa" '/home/vagrant/.ssh/'
cp "${VAGRANT_CORE_FOLDER}/ssh/id_rsa.pub" '/home/vagrant/.ssh/'

chown -R vagrant '/home/vagrant/.ssh'
chgrp -R vagrant '/home/vagrant/.ssh'
chmod 700 '/home/vagrant/.ssh'
chmod 644 '/home/vagrant/.ssh/id_rsa.pub'
chmod 600 '/home/vagrant/.ssh/id_rsa'
chmod 600 '/home/vagrant/.ssh/authorized_keys'

cat ~/.ssh/id_rsa.pub | tee ~/.ssh/authorized_keys

# Know our hosts
ssh-keyscan -H 104.236.178.120 >> ~/.ssh/known_hosts
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts

cp "${VAGRANT_CORE_FOLDER}/.bash_aliases" '/home/vagrant/.bash_aliases'
cp "${VAGRANT_CORE_FOLDER}/.bash_git" '/home/vagrant/.bash_git'

chown vagrant:vagrant /home/vagrant/.bash_aliases
chown vagrant:vagrant /home/vagrant/.bash_git

source /home/vagrant/.bashrc
