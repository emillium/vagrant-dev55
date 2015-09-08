Vagrant Development 55 Libvirt
====

### Under Developement

The Vagrant Development using multiple providers for creating a vagrant box

### Host Setup

#### 1. Download & install requirements

## Windows Setup
[Windows Readme](windows.MD)

## Linux Setup
[Linux Readme](linux.MD)

## Mac Setup
[Mac Readme](mac.MD)

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

* Important set provider if you are not using the default
```
vagrant up --provider=libvirt
```

## Project Setup

```
vagrant ssh
```

Go to

```
cd ~/project_files
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