# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  
    config.vm.network "public_network"
  
    $script = <<-SCRIPT
    sudo yum update -y
    sudo yum install kernel-devel -y
    sudo yum install gcc* -y
    SCRIPT
  
    #$OS = 'bento/ubuntu-16.04';
     $OS = 'bento/centos-6.9';
     config.vm.define "centos", primary: true do |v|
      v.vm.box = $OS
      v.vm.hostname = "centos.local"
      v.vm.network :private_network, ip: "192.168.2.5"

      # v.vm.provision "shell", run: "always" do |s|
      #   s.inline = $script
      # end

      v.vm.provision "ansible_local" do |ansible|
        ansible.playbook = "provisioning/provision.yml"
       ansible.inventory_path = "inventory"
       ansible.limit          = "all" # or only "nodes" group, etc.
        ansible.extra_vars = {
          mysql_root_password: "98_Av&%Ac54",
          wordpress_database_name: "wordpress",
          mysql_wordpress_username: "wordpress_db",
          mysql_wordpress_password: "28_Av&%Ac54",
        }
      end

      v.vm.synced_folder "www", "/var/www/html"
      
      v.vm.provider "virtualbox" do |apache|
        apache.linked_clone = true
        apache.memory = "2024"
        apache.name = "centos_machine"
       end
    end


    config.vm.define "mysql" do |v|
    v.vm.box = $OS
    v.vm.hostname = "mysql.local"
    v.vm.network :private_network, ip: "192.168.2.6"
    v.vm.provider "virtualbox" do |mysql|
        mysql.memory = "2024"
        mysql.name = "MySQL"
    end
    end
   
  end
  