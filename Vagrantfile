# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

# bootstrap = <<SCRIPT
#   useradd -m vagrant --groups sudo
#   sudo chown vagrant:vagrant /home/vagrant
# SCRIPT
# u -c "printf 'cd /home/vagrant\nsudo su vagrant' >> .bash_profile" -s /bin/sh ubuntu


# Vagrant.configure("2") do |config|
#   config.vm.box = "bento/ubuntu-16.04"
#   config.vm.host_name = "kevin"
#   config.vm.provision "shell", inline: "#{bootstrap}", privileged: true
# end

## Overwrite host locale in ssh session
ENV["LC_ALL"] = "en_US.UTF-8"


Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  ## config.vm.box = "torchbox/wagtail-jessie64"
  ## config.vm.box_version = "~> 1.0"
  #config.ssh.private_key_path = '$HOME/.ssh/github_rsa.pub' # 'PATH TO YOUR PRIVATE KEY'
  config.ssh.private_key_path = '/Users/jan/.ssh/id_rsa' # 'PATH TO YOUR PRIVATE KEY'
  config.ssh.username         = 'ubuntu'
  config.vm.box               = 'lightsail'
  config.vm.box_url           = 'https://github.com/thejandroman/vagrant-lightsail/raw/master/box/lightsail.box'
  # config.useradd.users = ['vagrant']
  # config.vm.provision "shell", inline: "#{bootstrap}", privileged: true
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false
  
  config.vm.provider :lightsail do |provider, override|
    provider.access_key_id     = 'AKIAIPR2UUCUAKUZ7C2A'
    provider.secret_access_key = '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'
    provider.keypair_name      = 'AWS'
   # provider.availability_zone = 'us-east-1a'
    override.nfs.functional = false
  end
  #  provider.port_info         = [{ from_port: 443, to_port: 443, protocol: 'tcp' }]
  # IPNumber not available  
  # config.vm.provider :aws do |aws, override|
  #   override.nfs.functional = false
  # end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8000" will access port 8000 on the guest machine.
  ## config.vm.network "forwarded_port", guest: 8000, host: 8000

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder ".", "/home/ubuntu/bakerydemo"
  #   owner:"vagrant"
  #    group:"vagrant"
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y python3-pip python3-dev libpq-dev postgresql postgresql-contrib nginx
  # SHELL
  # Begin Configuring
  #config.vm.define "lamp" do|lamp|
  #lamp.vm.hostname = "lamp" # Setting up hostname
  #lamp.vm.network "private_network", ip: "192.168.205.10" # Setting up machine's IP Address
  # lamp.vm.provision :shell, path: "bootstrap.sh" # Provisioning with script.sh
  #end
  # config.vm.hostname = "mysql57"
  #config.vm.provision "shell", path: "bootstrap.sh"
  config.vm.provision :shell, :path => ".provision/bootstrap.sh"
  config.vm.provision :shell, :path => ".provision/provision.sh", :args => "bakerydemo"

  # Enable agent forwarding over SSH connections.
  config.ssh.forward_agent = true
end
