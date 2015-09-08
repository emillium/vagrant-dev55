Vagrant Development 55 Libvirt
====

### MAC install ** UNDER Development **

CONFIGURE_ARGS="with-libvirt-include=/usr/include/libvirt with-libvirt-lib=/usr/lib" vagrant plugin install vagrant-libvirt

### Under Developement

The Vagrant Development uses libvirt for creating a vagrant box

## Currently the box must be downloaded and installed manually prior to use.

## Host Setup

#### 1. Download & install requirements

* Libvirt installation

```
egrep -c ‘(svm|vmx)’ /proc/cpuinfo
```

A 0 indicates that your CPU doesn’t support hardware virtualization, while a 1 or more indicates that it does. 
You may still have to enable hardware virtualization support in your computer’s BIOS, even if this command returns a 1 or more.

```
sudo apt-get install qemu-kvm libvirt-bin bridge-utils virt-manager
```

You may need to perform this step

```
sudo adduser name libvirtd
```

Logout of and log back in, kvm is now available

* Vagrant: https://www.vagrantup.com/downloads.html

### Vagrant Plugins (Required)
* vagrant-bindfs (Setting up permissions for NFS folders) https://github.com/gael-ian/vagrant-bindfs
* vagrant-libvirt (Setting libvirt(kvm/qemu) as a provider) https://github.com/pradels/vagrant-libvirt

### Vagrant Plugins (Optional)
* vagrant-cachier (Caches Box setups) https://github.com/fgrehm/vagrant-cachier

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
