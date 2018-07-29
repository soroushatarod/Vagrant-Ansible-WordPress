# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    $OS = 'bento/ubuntu-16.04';
    # $OS = 'bento/centos-6.9';
    config.vm.box = $OS

    $script = <<-SCRIPT
    sudo yum install kernel* -y
    SCRIPT

    $mysql_local_ip_address = "192.168.2.6"


    config.vm.network "public_network"
    config.ssh.insert_key = false

    config.vm.define "apache", primary: true do |v|
      v.vm.hostname = "apache.local"
      v.vm.network :private_network, ip: "192.168.2.5"

      if $OS == 'bento/centos-6.9'
        v.vm.provision "shell", run: "always" do |s|
          s.inline = $script
        end
      end



      v.vm.synced_folder "www", "/var/www/html"

      v.vm.provider "virtualbox" do |apache|
        apache.linked_clone = true
        apache.memory = "2024"
        apache.name = "apache_machine"
       end
    end




    config.vm.define "mysql" do |v|

      v.vm.box = $OS
      v.vm.synced_folder '.', '/vagrant', disabled: true

      v.vm.hostname = "mysql.local"
      v.vm.network :private_network, ip: $mysql_local_ip_address
        v.vm.provider "virtualbox" do |mysql|
            mysql.memory = "4024"
            mysql.name = "MySQL"
        end
    end





    config.vm.define "ansible_controller", primary: true do |v|
      v.vm.network :private_network, ip: "192.168.2.65"

      if $OS == 'bento/centos-6.9'
        v.vm.provision "shell", run: "always" do |s|
          s.inline = $script
        end
      end

      v.vm.provision "ansible_local" do |ansible|
        ansible.playbook = "provisioning/provision.yml"
          ansible.inventory_path = "inventory"
          ansible.config_file = "ansible.cfg"
          ansible.limit          = "all" # or only "nodes" group, etc.
          ansible.extra_vars = {
            mysql_root_password: "98_Av&%Ac54",
            mysql_server_ip_address: $mysql_local_ip_address,
            wordpress_database_name: "wordpress",
            mysql_wordpress_username: "wordpress_db",
            mysql_wordpress_password: "123456"
          }
        end
    end




   
  end
  