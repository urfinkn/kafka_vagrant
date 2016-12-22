# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
ServersCount = 2
 
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
 
  config.vm.synced_folder ".", "/vagrant", type: "nfs"

 (1..ServersCount).each do |i| 
    config.vm.define :"kafka#{i}" do |srv|
      srv.vm.hostname = "kafka#{i}"
      srv.vm.network "private_network", ip: "192.168.50.3#{i}"
      srv.vm.provision "shell", path: "kafka.sh" , :args => "#{i} #{ServersCount}"
      end
 end


end
