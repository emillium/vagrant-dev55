# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Added
- Allow the use of config-custom.yml file to over-ride default settings
### Changed
- document update for OSX
- adding PHP5 GD
- remote access for MariaDB
- add packages xvfb, chromium-browser
- convert swap install to ansible
- remote access for mariadb
- tmux allow ppa settings and version details
### Fix
- ssh known hosts update no longer duplicates records

## [2.0.2]
### Changed
- Add basic support for environments
### Fix
- libvirt cpu/mem string to integer

## [2.0.1]
### Added
- Add Change log

## [2.0.0] - 2015-10-09
### Changed
- Converted provision to Ansible
- Vagrant Config detection of host to run Ansible in guest if not installed on host
- Better detailing of shared folder details *guest_machine and *host_machine
- Config allows setting hosts setup, allows setting of local hosts and remotes[Automate hosts setup](http://104.236.178.120/container-boxes/vagrant-dev55/issues/13)
- Additional shared folders options available [Bind-FS slow file system performance on OSX and probz other platforms](http://104.236.178.120/container-boxes/vagrant-dev55/issues/8)
- Add auth.json details to config [Automate composer auth.json GitHub token](http://104.236.178.120/container-boxes/vagrant-dev55/issues/7)
- Add user name and email in config [Automate GIT User Setup in VM](http://104.236.178.120/container-boxes/vagrant-dev55/issues/6)
- Either set id_rsa/id_rsa.pub or use [Switch to SSH Agent Forwarding instead of copying SSH keys over](http://104.236.178.120/container-boxes/vagrant-dev55/issues/5)
- ImageMagik required [Imagemagick installation](http://104.236.178.120/container-boxes/vagrant-dev55/issues/3)
- General tidying of install process

## [1.0.0] - 2015-09-14
### Added
- Initial tagged release

