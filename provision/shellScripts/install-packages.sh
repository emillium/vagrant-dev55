#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

PACKAGES=$(echo "$1")

type ${PACKAGES} >/dev/null 2>&1 || {
  echo "Installing ${PACKAGES}"
  apt-get install -y ${PACKAGES} >/dev/null
  echo "Installed ${PACKAGES} packages"
}
