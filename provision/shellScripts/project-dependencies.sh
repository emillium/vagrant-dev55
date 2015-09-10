#!/usr/bin/env bash


if ! grep -n '127.0.0.1 single-sign-on.vagrant.dev55' /etc/hosts;
  then
    echo '127.0.0.1 single-sign-on.vagrant.dev55' | tee -a /etc/hosts
fi

if ! grep -n 'export APPLICATION_ENV="development"' /home/vagrant/.profile;
  then
    echo 'export APPLICATION_ENV="development"' | tee -a /home/vagrant/.profile
fi
