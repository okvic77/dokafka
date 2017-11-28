#!/bin/bash

cd ~;
wget http://www-us.apache.org/dist/kafka/1.0.0/kafka_2.11-1.0.0.tgz;
tar -xzf kafka_2.11-1.0.0.tgz;
cd kafka_2.11-1.0.0;
(
  cd config;
  cp server.properties server-test.properties;
  # sed s/zookeeper.connect=localhost:2181/zookeeper.connect=${digitalocean_droplet.zookeeper.ipv4_address_private}:2181/g server-test.properties;
)
# bin/kafka-server-start.sh config/server-test.properties
