# encoding: utf-8
# -*- mode: ruby -*-
# vim: set ft=ruby :
# FIXME: why does this piece of shit make images on C:/Users??????

# Box / OS
VAGRANT_BOX = 'bento/ubuntu-16.04'

# Name for the VM
VM_NAME = 'PyDev'

# VM User
VM_USER = 'vagrant'

# Host folder to sync
HOST_PATH = 'D:\\Dokumentumok\\DockerDev\\' + VM_NAME

# Where to sync to on Guest
GUEST_PATH = '/home/' + VM_USER + '/' + VM_NAME

Vagrant.configure("2") do |config|
  config.vm.box = VAGRANT_BOX
  config.vm.hostname = VM_NAME
  config.vm.provider "virtualbox" do |v|
    v.name = VM_NAME
    v.memory = 2048
    v.cpus = 2
    v.customize ["modifyvm", :id, "--vram", "128"]
    v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    v.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
    v.gui = true
  end

  config.vm.network "private_network", type: "dhcp"
  config.vm.synced_folder '.', '/home/'+VM_USER+'', disabled: true
  config.vm.provision "file", source: ".bashrc", destination: "/home/vagrant/.bashrc"
  config.vm.provision "shell", inline: <<-SHELL
    ## Base: packages, development tools

    # Add ppa repository for git and neovim
    echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu xenial main" \
      >> /etc/apt/sources.list
    echo "deb http://ppa.launchpad.net/neovim-ppa/stable/ubuntu xenial main" \
      >> /etc/apt/sources.list
    apt-get -y update

    # Install gui and virtualbox additions
    apt-get install -y xfce4 virtualbox-guest-dkms virtualbox-guest-utils \
      virtualbox-guest-x11 xfonts-base slim
    # Install packages from standard repo
    apt-get install -y mc silversearcher-ag bash zsh tmux rubygems \
      build-essential make python2.7 rxvt-unicode chromium-browser
    # INstall packages from ppa's
    apt-get install -y --allow-unauthenticated git neovim

    # Homesick
    gem install homesick
    # TODO: create a minimal config setup (copy from work)
    # TODO: rmtrash and misc scripts (copy from work)
    # TODO: vimwiki assets

    # Start virtualbox guest
    VBoxClient --clipboard
    VBoxClient --draganddrop
    VBoxClient --display
    VBoxClient --checkhostversion
    VBoxClient --seamless

    systemctl set-default graphical.target
    systemctl enable slim.service
  SHELL

  config.vm.define "PyDev" do |pydev|
  end
end
