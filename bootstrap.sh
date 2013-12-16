#!/usr/bin/env bash
set -ex

sudo apt-get -y update

## Install Chef-Client
curl -L https://www.getchef.com/chef/install.sh | sudo bash

## Setup hint for ec2
mkdir -p /etc/chef/ohai/hints
echo '{}' > /etc/chef/ohai/hints/ec2.json


## Install Chef-Server
CHEFSERVER_PKG="chef-server_11.0.10-1.ubuntu.12.04_amd64.deb"
wget -nv https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/${CHEFSERVER_PKG}
sudo dpkg -i ${CHEFSERVER_PKG}
rm ${CHEFSERVER_PKG}
sudo chef-server-ctl reconfigure
