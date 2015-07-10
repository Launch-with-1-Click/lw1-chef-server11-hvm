# lw1-chef-server

![Chef-Server](./_images/chef_server_login.png)

[Relase Notes](https://github.com/Launch-with-1-Click/lw1-chef-server11-hvm/wiki/Release-notes)

## Includes

- Chef-Server11 Open Source Edition
- Chef-DK 3.x

## Vagrant

`vagrant up --provider=aws`

`curl -L https://raw.github.com/Launch-with-1-Click/lw1-chef-server11-hvm/master/cleanup.sh | bash`
`

## Build by Packer

```
export AWS_ACCESS_KEY='KEY'
export AWS_SECRET_ACCESS_KEY='SECRET'
packer build packer_ec2.json
```


## How to Upgrade on AMI

1. Upgrade chef-server
  - `yum update`.
2. Run `chef-server-ctl upgrade`.
3. Run `chef-server-ctl reconfigure`.
4. Restart all services. Do `chef-server-ctl restart`.
