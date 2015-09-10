# -*- mode: ruby -*-
# vi: set ft=ruby :

dir = File.dirname(File.expand_path(__FILE__))
host = Vagrant::Util::Platform.platform

require 'yaml'

## Whatever vagrant dependencies we need here
unless Vagrant.has_plugin?("vagrant-bindfs")
  raise 'vagrant-bindfs plugin is not installed!'
  exit
end

#Use this method as it checks for cygwin, etc as well
if Vagrant::Util::Platform.windows?
  unless Vagrant.has_plugin?("vagrant-winnfsd")
    raise 'vagrant-winnfsd plugin is not installed!'
    exit
  end
end

if host =~ /linux/
  unless Vagrant.has_plugin?("vagrant-libvirt")
    raise 'vagrant-libvirt plugin is not installed!'
    exit
  end
end

if host =~ /darwin/
  ## Whatever vagrant dependencies we need here
end

configValues = YAML.load_file("#{dir}/provision/config.yaml")

data = configValues['vagrantfile']

eval File.read("#{dir}/provision/vagrant/VagrantConfig")
