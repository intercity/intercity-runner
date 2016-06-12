# -*- mode: ruby -*-
# vi: set ft=ruby :

CLEAN_IP = "10.0.0.11"
PUBLIC_KEY_PATH = "#{Dir.home}/.ssh/test_key.pub"

Vagrant.configure(2) do |config|
  config.ssh.forward_agent = true
  config.vm.box = "bento/ubuntu-14.04"

  config.vm.define "clean", primary: true do |vm|
    vm.vm.network :private_network, ip: CLEAN_IP

    if Pathname.new(PUBLIC_KEY_PATH).exist?
      config.vm.provision :file, source: PUBLIC_KEY_PATH, destination: '/tmp/id_rsa.pub'
      config.vm.provision :shell, :inline => "rm -f /root/.ssh/authorized_keys && mkdir -p /root/.ssh && sudo cp /tmp/id_rsa.pub /root/.ssh/authorized_keys"
    end
  end
end
