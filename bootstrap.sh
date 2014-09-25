#!/usr/bin/env bash
set -ex

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y update
sudo apt-get -y install git

## Install Chef-Client
curl -L https://www.getchef.com/chef/install.sh | sudo bash

## Setup hint for ec2
sudo mkdir -p /etc/chef/ohai/hints
sudo touch /etc/chef/ohai/hints/ec2.json
echo '{}' > ./ec2.json
sudo mv ./ec2.json /etc/chef/ohai/hints/ec2.json
sudo chown root.root /etc/chef/ohai/hints/ec2.json


## Install Chef-Server
CHEFSERVER_PKG="chef-server_11.1.5-1_amd64.deb"
wget -nv https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/${CHEFSERVER_PKG}
sudo dpkg -i ${CHEFSERVER_PKG}
rm ${CHEFSERVER_PKG}

## Configure Chef-Server
git clone https://github.com/Launch-with-1-Click/lw1-chef-server.git /tmp/chef-server
sudo install -d /etc/chef-server
sudo install -o root -g root -m 0640 /tmp/chef-server/files/chef-server.rb /etc/chef-server/
sudo chef-server-ctl reconfigure

## miscs

sudo install -o root -g root -m 0700 /tmp/chef-server/files/chef-server.cron /etc/cron.d/chef-server
sudo install -o root -g root -m 0700 /tmp/chef-server/files/client.rb /etc/chef/
sudo ln -s /etc/chef-server/chef-validator.pem  /etc/chef/validation.pem

sleep 10
sudo chef-client


## setup Knife
install -d /home/ubuntu/.chef
sudo install -o ubuntu -g ubuntu -m 0644 /tmp/chef-server/files/knife.rb /home/ubuntu/.chef/

