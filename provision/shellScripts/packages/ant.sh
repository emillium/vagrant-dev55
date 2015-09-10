#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

type ant >/dev/null 2>&1 || {
  echo 'Install ant'
  apt-get -y install ant >/dev/null
  echo 'Finished installing ant'
}
