#!/usr/bin/env bash

# Update Repositories
echo 'Running update'
# sudo apt-get update

sudo apt-get install -y -qq software-properties-common >/dev/null

type ansible >/dev/null 2>&1 || {
    echo 'Install Ansible'
    # Add Ansible Repository & Install Ansible
    sudo add-apt-repository -y ppa:ansible/ansible >/dev/null
    sudo apt-get update  -y -qq >/dev/null
    sudo apt-get install -y -qq ansible >/dev/null

    # Setup Ansible for Local Use and Run
    echo $2 > /etc/ansible/hosts
    chmod 666 /etc/ansible/hosts
    cat /vagrant/provision/files/authorized_keys >> /home/vagrant/.ssh/authorized_keys
    echo 'Ansible Installed'
}
echo 'Run Ansible'
sudo PYTHONUNBUFFERED=1 ansible-playbook /vagrant/provision/playbook.yml -e hostname=$1 --connection=local -vvv
