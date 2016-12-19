#!/bin/bash -ex
yum update -y
yum install mc -y
yum install bash-completion
yum install java-1.8.0-openjdk -y
yum install java-1.8.0-openjdk-devel -y
echo "export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk" >> /etc/profile
echo "export JRE_HOME=/usr/lib/jvm/jre" >> /etc/profile
source /etc/profile
yum install wget -y
wget -P /opt  http://www-us.apache.org/dist/kafka/0.10.1.0/kafka_2.11-0.10.1.0.tgz
tar /opt/xvzf kafka_2.11-0.10.1.0.tgz -C /opt 
useradd kafka
chown -R kafka:kafka /opt/kafka_2.11-0.10.1.0
ln -s /opt/kafka_2.11-0.10.1.0 /opt/kafka
chown -R kafka:kafka  /opt/kafka
cp  /vagrant/etc/systemd/system/* /etc/systemd/system/
systemctl daemon-reload
systemctl enable kafka-zookeeper.service
systemctl enable kafka.service
systemctl start kafka-zookeeper.service
systemctl status kafka-zookeeper.service
systemctl start kafka.service
systemctl status kafka.service
service stop firewalld.service
systemctl disable firewalld.service

