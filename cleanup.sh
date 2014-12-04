#!/usr/bin/env bash

set -ex

sudo yum clean all

sudo chef-server-ctl stop
sudo chef-server-ctl cleanse
sudo rm -rf /root/chef-server-cleanse-*
sudo install -d /etc/chef-server
sudo install -o root -g root -m 0640 /tmp/chef-server/files/chef-server.rb /etc/chef-server/

sudo rm /etc/chef/client.pem

sudo rm -rf /tmp/*
sudo rm -f /etc/ssh/ssh_host_*

sudo find /var/log/ -type f -name '*.log' -exec sudo cp /dev/null {} \;
sudo cp /dev/null /var/log/syslog


yes | sudo cp /dev/null /root/.ssh/authorized_keys
yes | sudo cp /dev/null /root/.bash_history
if [ -d /home/ec2-user ]; then
  yes | sudo cp /dev/null /home/ec2-user/.ssh/authorized_keys
  yes | sudo cp /dev/null /home/ec2-user/.bash_history
fi
history -c

