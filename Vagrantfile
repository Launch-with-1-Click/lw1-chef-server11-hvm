# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "dummy"


  ## AWS
  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV['AWS_ACCESS_KEY']
    aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    aws.keypair_name = ENV['AWS_EC2_KEYPAIR']

    aws.region = "ap-northeast-1"
    aws.ami = "ami-3f32ac3e" # Ubuntu12.04

    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = ENV['AWS_EC2_KEYPASS']
  end

  config.vm.provision :shell, :path => "bootstrap.sh"

end
