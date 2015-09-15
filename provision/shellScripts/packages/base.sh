#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

# Install base packages
echo 'Installing Base Packages'
apt-get -y -qq install ntp
