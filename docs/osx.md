OSX Installation
====

### Required

1. homebrew
2. Virtual Box
3. Vagrant SshFS
4. Vagrant BindFS

### Setup

1. Download and install virtual box via homebrew

```
brew install virtualbox
```

2. Setup SSHFS and/or BindFS vagrant plug-ins

```
vagrant plugin install vagrant-sshfs
vagrant plugin install vagrant-bindfs
```

### Configure

Open up ```provision/config.yaml``` and edit the *sync_type* field, change it's value to 'sshfs'.
You could also use NFS, however it is much slower on OSX than tradional Linux systems. If using 'sshfs'
set the *source* field to something like ```~/mnt```. It just needs to point to an empty directory.
vagrant-sshfs will mount the ```/home/vagrant/project_files``` directory from within the VM to your
source directory on the host.
