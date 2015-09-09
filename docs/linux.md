### Linux Installation

## Providers
* Virtual Box
* Libvirt

# Libvirt installation

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
## All
* vagrant-bindfs (Setting up permissions for NFS folders) https://github.com/gael-ian/vagrant-bindfs

## Linux
* vagrant-libvirt (Setting libvirt(kvm/qemu) as a provider) https://github.com/pradels/vagrant-libvirt

### Vagrant Plugins (Optional)
## All
* vagrant-cachier (Caches Box setups) https://github.com/fgrehm/vagrant-cachier

# Virtual Box Provider
* vagrant plugin install vagrant-vbguest (update virtualbox guest editions) https://github.com/dotless-de/vagrant-vbguest
