# Defines Vagrant environment

Vagrant.configure("2") do |config|
N = 3
config.ssh.insert_key = false
  # create load balancer
  config.vm.define :lb do |lb_config|
      lb_config.vm.box = "ubuntu/trusty64"
      lb_config.vm.hostname = "lb"
      lb_config.vm.network :private_network, ip: "10.0.0.5"
      lb_config.vm.network "forwarded_port", guest: 80, host: 8080
      lb_config.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
      end
  end

  # create web servers
  (1..N).each do |i|
    config.vm.define "web#{i}" do |node|
      node.vm.box = "ubuntu/trusty64"
      node.vm.hostname = "web#{i}"
      node.vm.network :private_network, ip: "10.0.0.5#{i}"
      node.vm.network "forwarded_port", guest: 80, host: "808#{i}"
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
      end
    end
  end

  # create man node
  config.vm.define :man do |man_config|
      man_config.vm.box = "ubuntu/trusty64"
      man_config.vm.hostname = "man"
      man_config.vm.network :private_network, ip: "10.0.0.2"
      man_config.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
      end
      man_config.vm.provision :shell, path: "bootstrap.sh"
      man_config.vm.provision "file", source: "/root/.vagrant.d/insecure_private_key", destination: ".ssh/id_rsa"
      man_config.vm.provision :ansible do |ansible|
	ansible.limit = "all"
        ansible.verbose = "v"
        ansible.inventory_path = "examples/inventory.ini"
        ansible.playbook = "examples/env-role.yml"
      end

  end
end
