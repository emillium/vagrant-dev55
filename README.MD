Vagrant Development 55 Multi provisioned
====

The Vagrant Development is able to use multiple providers for creating a vagrant box, currently supported (virtual box, libvirt-kvm)

### Host Setup

#### 1. Download & install requirements

## Windows Setup
[Windows Readme](docs/windows.md)

## Linux Setup
[Linux Readme](docs/linux.md)

## Mac Setup
[Mac Readme](docs/osx.md)

#### 2. Clone this repository

```
git clone git@104.236.178.120:container-boxes/vagrant-dev55.git
cd vagrant-dev55
```

#### 3. Configure the config

The setup for the vagrant box is a config file in yaml format the default settings are as follows

To alter use config-custom.yml in the same directory this will overwrite values or append additional values as required.

eg.. The following in config-custom will over-ride the default environment settings and memory.

```
        vm:
            environment: staging
            memory: '2048'

```

## Default settings

```
# Configuration for vagrant

        vm:
            box: s3than/trusty64
            hostname: vagrant.dev55
            environment: development #Currently only development environment has been tested
            #Memory and Cpus if set to empty will use auto generated
            memory: ''
            cpus: ''
            chosen_provider: virtualbox
            ssh:
                forward: '1'
                known_hosts_command: "ssh-keyscan -t rsa -T 10"
                known_hosts_file: "/etc/ssh/ssh_known_hosts"
                known_hosts:
                  - 104.236.178.120
                  - github.com
                  - bitbucket.org
            network:
                private_network: 192.168.56.102
                forwarded_port:
                    ssh_forward_port:
                        host: '9592'
                        guest: '22'
                    mysql_forward_port:
                        host: '9593'
                        guest: '3306'
            provider: # see [virtualbox](https://docs.vagrantup.com/v2/virtualbox/index.html) & [libvirt](https://github.com/pradels/vagrant-libvirt#domain-specific-options) for more options
                virtualbox:
                    modifyvm:
                        natdnshostresolver1: 'on'
                        nictype1: virtio
                        nictype2: virtio
                        natdnsproxy1: 'on'
            synced_folder:
                project_folder:
                    sync_type: 'default'
                    host_machine:  ./project_files
                    guest_machine: /home/vagrant/project_files
                    owner: vagrant
                    group: www-data
            usable_port_range:
                start: 9000
                stop: 10500
        server:
            install: '1'
            packages: [htop, imagemagick, multitail, ant, xvfb, chromium-browser]
            timezone: UTC
            locale: en_AU.UTF-8
            swap:
                swap_file_path: /swapfile
                # Use any of the following suffixes
                # c=1
                # w=2
                # b=512
                # kB=1000
                # K=1024
                # MB=1000*1000
                # M=1024*1024
                # xM=M
                # GB=1000*1000*1000
                # G=1024*1024*1024
                swap_file_size: 1024M
                swappiness: 1
            hosts:
                - url: 127.0.0.1
                  name: single-sign-on
                  local: '1'
                - url: 192.168.20.21
                  name: packages.temando.com
                  local: '0'
                - url: 192.168.7.175
                  name: webservices.hunterexpress.com.au
                  local: '0'
                - url: 192.168.7.175
                  name: hunterexpress.com.au
                  local: '0'
                - url: 192.168.7.175
                  name: farmapi.fastway.org
                  local: '0'
                - url: 192.168.7.175
                  name: api.fastway.org
                  local: '0'
                - url: 192.168.7.175
                  name: au.api.fastway.org
                  local: '0'
                - url: 192.168.7.175
                  name: xmlapi.emea.netdespatch.com
                  local: '0'
        tmux:
            install: '1'
            repo: 'ppa:pi-rho/dev'
            package: 'tmux=2.0-1~ppa1~t'
            version: '2'
        dot_files:
            install: '0'
        git:
            install: '1'
            user_name: ''
            email: ''
        apache:
            install: '1'
        mariadb:
            install: '1'
            root_password: '123'
            database: db
            options:
                bind_address: '0.0.0.0'
            users:
                - { name: dbuser, host: '%', password: 1234, priv: '*.*:ALL,GRANT' }
            dump: ''
            adminer: '1'
        newrelic:
            install: '1'
        php:
            install: '1'
            ppa: php5
            ioncube: '1'
            packages: [php5-cli, php5-curl, php-http, php5-imagick, php5-intl, php5-mcrypt, php5-mysql, php5-redis, php5-ssh2]
            pecl_with_dependents:
                - package: pecl_http
                  package_name: http
                  depends_on:
                       - package: raphf
                         package_name: raphf
                         priority: 25
                       - package: propro
                         package_name: propro
                         priority: 30
                  priority: 35
        xdebug:
            install: '1'
        composer:
            install: '1'
            auth: ''
        nodejs:
            install: '1'
            nodejs_version: '0.12'
            nodejs_forever: false
            nodejs_npm_global_packages:
              - name: bower
              - name: grunt-cli
```            


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

In your hosts directory use the following format *.vagrant.dev55 where * is the project folder name ip address is 192.168.56.102

#### 5. Change Log
[Change Log](docs/change_log.md)