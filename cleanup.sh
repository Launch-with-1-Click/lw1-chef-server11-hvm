#!/usr/bin/env bash

set -ex

sudo apt-get clean all

sudo chef-server-ctl stop
sudo chef-server-ctl cleanse
sudo rm -rf /root/chef-server-cleanse-*
sudo install -d /etc/chef-server
sudo install -o root -g root -m 0640 /tmp/chef-server/files/chef-server.rb /etc/chef-server/


sudo rm -rf /tmp/*
sudo rm -f /etc/ssh/ssh_host_*
cd /var/log
find /var/log/ -type f -name '*.log' -exec sudo cp /dev/null {} \;
sudo cp /dev/null /var/log/syslog


yes | sudo cp /dev/null /root/.ssh/authorized_keys
yes | sudo cp /dev/null /root/.bash_history
if [ -d /home/ubuntu ]; then
  yes | sudo cp /dev/null /home/ubuntu/.ssh/authorized_keys
  yes | sudo cp /dev/null /home/ubuntu/.bash_history
fi
history -c

