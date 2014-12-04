#!/usr/bin/env bash
set -ex

curl https://packagecloud.io/install/repositories/chef/stable/script.rpm | sudo bash

sudo yum update -y
sudo yum install git -y

## Setup hint for ec2
sudo mkdir -p /etc/chef/ohai/hints
sudo touch /etc/chef/ohai/hints/ec2.json
echo '{}' > ./ec2.json
sudo mv ./ec2.json /etc/chef/ohai/hints/ec2.json
sudo chown root.root /etc/chef/ohai/hints/ec2.json

## Install Chef-Server11 and ChefDK
sudo yum install chef-server chefdk -y


## Configure Chef-Server
git clone https://github.com/Launch-with-1-Click/lw1-chef-server11-hvm.git /tmp/chef-server
sudo install -d /etc/chef-server
sudo install -o root -g root -m 0640 /tmp/chef-server/files/chef-server.rb /etc/chef-server/
sudo chef-server-ctl reconfigure

## miscs

sudo install -o root -g root -m 0644 /tmp/chef-server/files/chef-server.cron /etc/cron.d/chef-server
sudo install -o root -g root -m 0600 /tmp/chef-server/files/client.rb /etc/chef/
sudo ln -s /etc/chef-server/chef-validator.pem  /etc/chef/validation.pem

sleep 10
sudo chef-client


## setup Knife
install -d /home/ec2-user/.chef
sudo install -o ec2-user -g ec2-user -m 0644 /tmp/chef-server/files/knife.rb /home/ec2-user/.chef/

