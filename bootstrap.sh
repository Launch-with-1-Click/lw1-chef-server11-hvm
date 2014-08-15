#!/usr/bin/env bash
set -ex


## for HVM work around from ubuntu forum https://bugs.launchpad.net/cloud-init/+bug/1309079
sudo rm /boot/grub/menu.lst
sudo update-grub-legacy-ec2 -y
sudo apt-get -y update
echo grub-pc grub-pc/install_devices_disks_changed select /dev/xvda | sudo debconf-set-selections
echo grub-pc grub-pc/install_devices select /dev/xvda | sudo  debconf-set-selections
DEBIAN_FRONTEND=noninteractive sudo apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" -y upgrade
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
CHEFSERVER_PKG="chef-server_11.1.4-1_amd64.deb"
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

