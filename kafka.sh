##test commit from mac
#!/bin/bash -ex
echo "server $1"
if [ ! -f /tmp/yum_installed ]; then
#  yum update -y
  yum install mc bash-completion java-1.8.0-openjdk java-1.8.0-openjdk-devel wget -y
  mkdir -p /root/.config/mc
  cp /vagrant/sysconfs/root/.config/mc/ini /root/.config/mc/ini
  touch /tmp/yum_installed
fi

if [ ! -f /tmp/kafka_installed ]; then
  echo "export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk" >> /etc/profile
  echo "export JRE_HOME=/usr/lib/jvm/jre" >> /etc/profile
  source /etc/profile
  cp   /vagrant/kafka/kafka_2.11-0.10.1.0.tgz /opt
  tar xvzf /opt/kafka_2.11-0.10.1.0.tgz -C /opt 
  useradd kafka
  chown -R kafka:kafka /opt/kafka_2.11-0.10.1.0
  ln -s /opt/kafka_2.11-0.10.1.0 /opt/kafka
  chown -R kafka:kafka  /opt/kafka
  cp  /vagrant/kafka/etc/systemd/system/* /etc/systemd/system/
  systemctl daemon-reload
  systemctl enable kafka-zookeeper.service
  systemctl enable kafka.service
  systemctl stop firewalld.service
  systemctl disable firewalld.service
  touch /tmp/kafka_installed
fi

if [ ! -f /tmp/cluster_configured ]; then 
  cp /vagrant/kafka/etc/hosts /etc/hosts
  sed -r "s/broker.id=0/broker.id=${1}/g" /vagrant/kafka/opt/kafka/config/server.properties > /opt/kafka/config/server.properties.tmp
  echo "host.name=kafka$1" >> /opt/kafka/config/server.properties.tmp  
  servstr="zookeeper.connect="
  cp /vagrant/kafka/opt/kafka/config/zookeeper.properties /opt/kafka/config/zookeeper.properties
  i=0
  while [ $i -lt $2 ] 
  do
    i=$[$i+1]
    if [ $i -eq 1 ];
    then 
     servstr="${servstr}kafka$i:2181"
    else
      servstr="${servstr},kafka$i:2181"
    fi
    sed -r "s/zookeeper.connect=127.0.0.1:2181/${servstr}/g" /opt/kafka/config/server.properties.tmp > /opt/kafka/config/server.properties
    echo "server.$i=kafka$i:2888:3888" >> /opt/kafka/config/zookeeper.properties
  done
  mkdir -p /tmp/zookeeper
  echo $1 > /tmp/zookeeper/myid
  chown kafka:kafka /tmp/zookeeper -R
  systemctl start kafka-zookeeper.service
  systemctl status kafka-zookeeper.service
  systemctl start kafka.service
  systemctl status kafka.service
  touch /tmp/cluster_configured
fi
