#!/usr/env/bin bash

set -ex

echo "Yes? or Ctrl+C"
read

rm -rf /vagrant
rm /home/ubuntu/.ssh/authorized_keys
history -c
