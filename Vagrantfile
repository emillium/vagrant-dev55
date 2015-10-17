# -*- mode: ruby -*-
# vi: set ft=ruby :

dir = File.dirname(File.expand_path(__FILE__))
host = Vagrant::Util::Platform.platform

require 'yaml'
require "#{dir}/provision/ruby/deep_merge.rb"

configValues = YAML.load_file("#{dir}/provision/vars/config.yml")

if File.file?("#{dir}/provision/vars/config-custom.yml")
  custom = YAML.load_file("#{dir}/provision/vars/config-custom.yml")
  configValues.deep_merge!(custom)
end

File.open("#{dir}/provision/vars/merge-config.yml", 'w') { |f| YAML.dump(configValues, f) }

vmValues = configValues['vm']

#Use this method as it checks for cygwin, etc as well
## Whatever vagrant dependencies we need here for windows
if Vagrant::Util::Platform.windows?
  vmValues['synced_folder'].each do |i, folder|
    if folder['sync_type'] == 'nfs'
      unless Vagrant.has_plugin?("vagrant-winnfsd")
        raise 'vagrant-winnfsd plugin is not installed!'
        exit
      end
    end
  end
end

## Whatever vagrant dependencies we need here for linux
if host =~ /linux/
  if vmValues['chosen_provider'] == 'libvirt'
    unless Vagrant.has_plugin?("vagrant-libvirt")
      raise 'vagrant-libvirt plugin is not installed!'
      exit
    end
  end
end

## Whatever vagrant dependencies we need here for mac os
if host =~ /darwin/

end

## Whatever global vagrant dependencies we need here
vmValues['synced_folder'].each do |i, folder|
  if folder['sync_type'] == 'sshfs'
    unless Vagrant.has_plugin?("vagrant-sshfs")
      raise 'vagrant-bindfs and/or vagrant-sshfs plugin is not installed!'
      exit
    end
  end
end

eval File.read("#{dir}/provision/VagrantConfig")
