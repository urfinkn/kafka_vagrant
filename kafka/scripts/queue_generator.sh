#!/bin/bash 

topic=${3:-kafkatopic}
count=${2:-1000}
delay=${1:-1}
i=1

echo "delay is $delay, copunt is $count, topic is $topic"

/opt/kafka/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 2 --partitions 1 --topic $topic --if-not-exists


while [ "$i" -le $count ]
do
echo "mseege $i"  | /opt/kafka/bin/kafka-console-producer.sh --broker-list kafka1:9092,kafka2:9092 --topic kafkatopic > /dev/null 2>&1
echo "I said - mseege $i"
##sleep $delay
((i++))
done
