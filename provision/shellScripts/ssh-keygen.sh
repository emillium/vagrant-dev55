#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

cp "/vagrant/provision/files/ssh/id_rsa" '/home/vagrant/.ssh/'
cp "/vagrant/provision/files/ssh/id_rsa.pub" '/home/vagrant/.ssh/'

chown -R vagrant '/home/vagrant/.ssh'
chgrp -R vagrant '/home/vagrant/.ssh'
chmod 700 '/home/vagrant/.ssh'
chmod 644 '/home/vagrant/.ssh/id_rsa.pub'
chmod 600 '/home/vagrant/.ssh/id_rsa'
chmod 600 '/home/vagrant/.ssh/authorized_keys'

if [ -f ~/.ssh/id_rsa.pub ]; then
  cat ~/.ssh/id_rsa.pub | tee ~/.ssh/authorized_keys
fi

# # Know our hosts
ssh-keyscan -H 104.236.178.120 >> ~/.ssh/known_hosts
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts
