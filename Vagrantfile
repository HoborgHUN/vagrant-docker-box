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
    # TODO: add-apt-repository with proper keys?
    echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu xenial main" \
      >> /etc/apt/sources.list
    echo "deb http://ppa.launchpad.net/neovim-ppa/stable/ubuntu xenial main" \
      >> /etc/apt/sources.list
    echo "deb http://ppa.launchpad.net/jonathonf/python-3.6/ubuntu xenial main" \
      >> /etc/apt/sources.list
    apt-get -y update

    # Install gui and virtualbox additions
    apt-get install -y xfce4 virtualbox-guest-dkms virtualbox-guest-utils \
      virtualbox-guest-x11 xfonts-base slim
    # Install packages from standard repo
    apt-get install -y mc silversearcher-ag bash zsh tmux rubygems \
      build-essential make python2.7 rxvt-unicode-256color chromium-browser
    # Install packages from ppa's
    apt-get install -y --allow-unauthenticated git neovim python3.6

    # Homesick
    gem install homesick
    su - vagrant -c "homesick clone https://github.com/HoborgHUN/zshrc.git"
    su - vagrant -c "homesick symlink zshrc"

    su - vagrant -c "homesick clone https://github.com/HoborgHUN/dotvim.git"
    su - vagrant -c "homesick symlink dotvim"

    su - vagrant -c "homesick clone https://github.com/HoborgHUN/dev-dotfiles.git"
    su - vagrant -c "homesick symlink dev-dotfiles"

    # Powerline fonts
    # FIXME they still don't work
    wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
    mkdir -p /home/vagrant/.local/share/fonts
    mv PowerlineSymbols.otf /home/vagrant/.local/share/fonts/
    fc-cache -vf /home/vagrant/.local/share/fonts/
    mkdir -p /home/vagrant/.config/fontconfig/conf.d
    mv 10-powerline-symbols.conf /home/vagrant/.config/fontconfig/conf.d/

    # TODO: rmtrash and misc scripts (copy from work)
    # TODO: vimwiki assets

    # Start virtualbox guest
    VBoxClient --clipboard
    VBoxClient --draganddrop
    VBoxClient --display
    VBoxClient --checkhostversion
    VBoxClient --seamless

    # Switch shell
    chsh -s /usr/bin/zsh  # for root
    chsh -s /usr/bin/zsh vagrant

    # Neovim plugins
    nvim -c "PlugInstall"

    systemctl set-default graphical.target
    systemctl enable slim.service
  SHELL

  config.vm.define "PyDev" do |pydev|
  end
end
