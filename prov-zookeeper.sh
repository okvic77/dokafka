#!/bin/bash


cd ~;
wget http://www-us.apache.org/dist/zookeeper/stable/zookeeper-3.4.10.tar.gz
tar -xzf zookeeper-3.4.10.tar.gz;
cd zookeeper-3.4.10;
cp conf/zoo_sample.cfg conf/zoo.cfg;
bin/zkServer.sh start;