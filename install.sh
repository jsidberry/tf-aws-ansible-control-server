#!/bin/bash
sudo apt update
sudo apt install -y python3-pip
# sudo apt install -y ansible-core
apt-get --assume-yes install openjdk-17-jdk python3-pip
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$PATH:~/.local/bin
pip3 install ansible ansible-rulebook ansible-runner
sudo apt-get install -y adduser libfontconfig1 musl
wget https://dl.grafana.com/oss/release/grafana_8.2.4_amd64.deb
sudo dpkg -i grafana_8.2.4_amd64.deb
sudo service grafana-server start
sudo systemctl enable grafana-server.service
