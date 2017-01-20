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
fi

if [ ! -f /tmp/cluster_configured ]; then 
fi
