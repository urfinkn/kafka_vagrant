# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
ServersCount = 3
AnsibleMaster = 1
 
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
 
  config.vm.synced_folder ".", "/vagrant"

 (1..ServersCount).each do |i| 
    config.vm.define :"kafka#{i}" do |srv|
      srv.vm.hostname = "kafka#{i}"
      srv.vm.network "private_network", ip: "192.168.50.3#{i}", :netmask => "255.255.255.0"
      srv.vm.provision "shell", path: "ansimble.sh" , :args => "#{i} #{ServersCount} #{AnsibleMaster}"
      end
 end


end
