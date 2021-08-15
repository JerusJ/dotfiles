#!/usr/bin/env ruby

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.hostname = "devbox"

  config.vm.provider "virtualbox" do |v|
    v.cpus = "2"
    v.memory = "2048"
  end

  config.vm.synced_folder ".", "/vagrant", disabled: false

  config.vm.provision "shell", inline: "sudo apt-get update && sudo apt-get install -y python3 python3-pip"
  config.vm.provision "shell", inline: "python3 -m pip install ansible"
  config.vm.provision "shell", inline: "ansible-playbook /vagrant/ansible/install.yml"
  config.vm.provision "shell", path: "./install_linux"
end
