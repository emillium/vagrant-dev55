Vagrant Development 55 Libvirt
====


ISSUES
======

* composer accessing https://packages.temando.com throws a ssl error still works but slows the process down


### Under Developement

The Vagrant Development uses libvirt for creating a vagrant box

## Currently the box must be downloaded and installed manually prior to use.

## Host Setup

#### 1. Download & install requirements

* Vagrant: https://www.vagrantup.com/downloads.html

### Vagrant Plugins (Required)
* vagrant-bindfs (Setting up permissions for NFS folders)
* vagrant-libvirt (Setting libvirt(kvm/qemu) as a provider)

### Vagrant Plugins (Optional)
* vagrant-cachier (Caches Box setups)

#### 2. Clone this repository

```
git clone git@104.236.178.120:container-boxes/vagrant-dev55-libvirt.git
cd vagrant-dev55-libvirt
```

#### 3. Configure the sandbox

Go to the ssh directory called ```ssh``` in the /files/ssh dir and copy your deployment keys into it.

```
cd files/ssh
cp ~/.ssh/mysshkeys id_rsa
cp ~/.ssh/mysshkeys.pub id_rsa.pub
```

This key will be copied into your virtual machine. Make sure it is configured to access Temando's repositories.

#### 4. Initialise vagrant virtual machine

* Important set provider for first provision
```
vagrant up --provider=libvirt
```

## Project Setup

```
vagrant ssh
```

Go to

```
cd ~/www
```

Clone the project you wish to use

### Features

* Mysql
* Apache

### Mysql
 
* username = root
* password = 123

### Accessing Projects

In your hosts directory use the following format *.vagrant.dev55 where * is the project folder name ip address is 192.168.56.101
