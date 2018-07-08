# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
    # The most common configuration options are documented and commented below.
    # For a complete reference, please see the online documentation at
    # https://docs.vagrantup.com.
  
    # Every Vagrant development environment requires a box. You can search for
    # boxes at https://atlas.hashicorp.com/search.
    config.vm.box = "bento/centos-6.9"
  
    # Disable automatic box update checking. If you disable this, then
    # boxes will only be checked for updates when the user runs
    # `vagrant box outdated`. This is not recommended.
    # config.vm.box_check_update = false
  
    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    # config.vm.network "forwarded_port", guest: 80, host: 8080
  
    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    # config.vm.network "private_network", ip: "192.168.33.10"
  
    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
    config.vm.network "public_network"
  
    $script = <<-SCRIPT
    sudo yum update -y
    sudo yum install kernel-devel -y
    sudo yum install gcc* -y
    SCRIPT
  
  
     config.vm.define "apache" do |v|
      v.vm.box = "bento/centos-6.9"
      v.vm.hostname = "apache.local"
      v.vm.network :private_network, ip: "192.168.2.2"
      v.vm.provision "shell", run: "always" do |s|
        s.inline = $script
      end
      v.vm.provision "ansible_local" do |ansible|
        ansible.playbook = "provisioning/playbook.yml"
      end
      def directory_exists?(apache)
        v.vm.synced_folder "apache", "/var/www/html"
      end
      
      v.vm.provider "virtualbox" do |a|
        a.memory = "2024"
        a.name = "Apache"
       end
    end


   # next stage to create another VM just to host MySQL only
    if 1 == 2 
        config.vm.define "mysql" do |v|
        v.vm.box = "bento/centos-6.9"
        v.vm.hostname = "mysql.local"
        v.vm.network :private_network, ip: "192.168.2.3"
        v.vm.synced_folder "mysql", "/var/www/html"
        v.vm.provision "shell", run: "always" do |s|
            s.inline = "sudo yum update -y"
        end
        v.vm.provider "virtualbox" do |mysql|
            mysql.memory = "2024"
            mysql.name = "MySQL"
        end
        end
    end
   
  end
  