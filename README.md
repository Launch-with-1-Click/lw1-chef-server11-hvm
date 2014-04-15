# lw1-chef-server

![Chef-Server](./_images/chef_server_login.png)

`VERSION: 11.0.10`


`vagrant up --provider=aws`

`curl https://raw.github.com/Launch-with-1-Click/lw1-chef-server/master/cleanup.sh | bash`

## Build by Packer(testing)

`packer build packer_ec2.json`


## How to Upgrade on AMI

1. Download package (such as *.deb or *.rpm) from [getchef website](http://www.getchef.com/chef/install/).
2. Upgrade package
  - For rhel family, `rpm -Uvh *.rpm`.
  - For debian family, `dpkg -i *.deb`.
3. Run `chef-server-ctl reconfigure`.
3. Restart all services. Do `chef-server-ctl restart`.
