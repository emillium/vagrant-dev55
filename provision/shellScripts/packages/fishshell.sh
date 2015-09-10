#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

VAGRANT_CORE_FOLDER=$(echo "$1")

#if [ -f ${VAGRANT_CORE_FOLDER}/fishshell/config.fish ] && [ ! -f /home/vagrant/.bash_aliases ]; then
#  cp "${VAGRANT_CORE_FOLDER}/bash/.bash_aliases" /home/vagrant/.bash_aliases
#fi
