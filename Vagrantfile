# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  unless Vagrant.has_plugin?("vagrant-bindfs")
    raise 'vagrant-bindfs plugin is not installed!'
    exit
  end

  unless Vagrant.has_plugin?("vagrant-libvirt")
    raise 'vagrant-libvirt plugin is not installed!'
    exit
  end

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.define :dbserver do |dbserver|
    dbserver.vm.box = "ubuntu/trusty64"



    if Vagrant.has_plugin?("vagrant-cachier")
        # Configure cached packages to be shared between instances of the same base box.
        # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
        config.cache.scope = :box
    end

    dbserver.vm.network :private_network, :ip => "192.168.56.101"

    dbserver.vm.synced_folder "./project_files/", "/mnt/vagrant-1", id: "1", type: 'nfs'
    dbserver.bindfs.bind_folder "/mnt/vagrant-1", "/home/vagrant/www", owner: "vagrant", group: "www-data", perms: "u=rwX:g=rwX:o=rD"

    dbserver.vm.provider :libvirt do |domain|
      # Create a forwarded port mapping which allows access to a specific port
      # within the machine from a port on the host machine. In the example below,
      # accessing "localhost:8080" will access port 80 on the guest machine.
      config.vm.network "forwarded_port", guest: 22, host: 9592

      host = RbConfig::CONFIG['host_os']
      # Give VM 1/4 system memory & access to all cpu cores on the host
      if host =~ /darwin/
        cpus = `sysctl -n hw.ncpu`.to_i
        # sysctl returns Bytes and we need to convert to MB
        mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
      elsif host =~ /linux/
        cpus = `nproc`.to_i / 2
        # meminfo shows KB and we need to convert to MB
        mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
      end

      domain.memory = mem
      domain.cpus = cpus.ceil
      domain.volume_cache = 'none'

      config.vm.provision 'shell' do |s|
        s.path = "provision/swap.sh"
      end

      config.vm.provision 'shell' do |s|
        s.path = "provision/initial-setup.sh"
        s.args = "/vagrant/files"
      end

      config.vm.provision 'shell' do |s|
        s.path = "provision/project-dependencies.sh"
        s.args = "/vagrant/files"
      end

      config.vm.provision 'shell' do |s|
        s.path = "provision/shell.sh"
        s.args = "/vagrant/files"
      end

      config.vm.provision 'shell' do |s|
        s.path = "provision/ssh-keygen.sh"
        s.args = "/vagrant/files"
      end
    end
  end
end
