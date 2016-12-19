# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
ServersCount = 2
 
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
#config.vm.box = "ubuntu/trusty64"
  config.vm.box = "centos/7"
 
#  config.vm.provider "virtualbox" do |vb|
#    vb.cpus = 2
#  end
#  config.vm.synced_folder ".", "/vagrant", type: "nfs"

 (1..ServersCount).each do |i| 
    config.vm.define :"kafka#{i}" do |srv|
      srv.vm.hostname = "kafka#{i}"
      srv.vm.network "private_network", ip: "192.168.50.3#{i}"
      srv.vm.provision "shell", path: "kafka.sh" , :args => "#{i}"
      end
 end

#  config.vm.define :producer1 do |pr|
#    pr.vm.hostname = "producer1"
#    pr.vm.network "private_network", ip: "192.168.50.41"
#    pr.vm.provision "shell", path: "producer.sh"
#  end

#  config.vm.define :consumer1 do |cn|
#    cn.vm.hostname = "consumer1"
#    cn.vm.network "private_network", ip: "192.168.50.51"
#    cn.vm.provision "shell", path: "consumer.sh"
#  end  

end
