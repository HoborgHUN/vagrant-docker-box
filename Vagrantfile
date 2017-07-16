# encoding: utf-8
# -*- mode: ruby -*-
# vim: set ft=ruby :

# If I don't want to download images on C drive:
# Need to set environment variable first
# VAGRANT_HOME = D:\vagrant.d

# Box / OS
VAGRANT_BOX = 'bento/ubuntu-16.04'

# Name for the VM
VM_NAME = 'docker-box'

# VM User
VM_USER = 'vagrant'

# Host folder to sync
HOST_PATH = 'D:/vagrant.d/share/' + VM_NAME

# Where to sync to on Guest
GUEST_PATH = '/home/' + VM_USER + '/share'

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
  # FIXME: sync folder not working (is it necessary?)
  # config.vm.synced_folder HOST_PATH, GUEST_PATH

  config.vm.provision "file", source: ".bashrc", destination: "/home/vagrant/.bashrc"
  config.vm.provision "file", source: ".Xresources", destination: "/home/vagrant/.Xresources"
  config.vm.provision "file", source: "slim.conf", destination: "slim.conf"

  config.vm.provision "shell", inline: <<-SHELL
    # ## Base: packages, development tools

    # # Install packages from standard repo
    # apt-get install -y mc silversearcher-ag bash zsh tmux rubygems \
    #   build-essential make python2.7
    # # Install packages from ppa's
    # # TODO: add ppa repos
    # apt-get install -y --allow-unauthenticated git neovim python3.6

    # # Homesick
    # gem install homesick
    # su - vagrant -c "homesick clone https://github.com/HoborgHUN/zshrc.git"
    # su - vagrant -c "homesick symlink zshrc"

    # su - vagrant -c "homesick clone https://github.com/HoborgHUN/dotvim.git"
    # su - vagrant -c "homesick symlink dotvim"

    # su - vagrant -c "homesick clone https://github.com/HoborgHUN/dev-dotfiles.git"
    # su - vagrant -c "homesick symlink dev-dotfiles"

    # # Powerline fonts
    # # FIXME they still don't work
    # # TODO: use git install script instead
    # wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    # wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
    # mkdir -p /home/vagrant/.local/share/fonts
    # mv PowerlineSymbols.otf /home/vagrant/.local/share/fonts/
    # fc-cache -vf /home/vagrant/.local/share/fonts/
    # mkdir -p /home/vagrant/.config/fontconfig/conf.d
    # mv 10-powerline-symbols.conf /home/vagrant/.config/fontconfig/conf.d/

    # # TODO: rmtrash and misc scripts (copy from work)
    # # TODO: vimwiki assets

    # # Switch shell
    # chsh -s /usr/bin/zsh  # for root
    # chsh -s /usr/bin/zsh vagrant

    # # Neovim plugins
    # nvim -c "PlugInstall"

    # -----------TESTING------------------
    # fucking config home dir...
    export XDG_CONFIG_HOME=/home/vagrant/.config

    # Install docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get -y update
    apt-get install -y docker-ce

    # Install xfce, terminal, vbox additions
    apt-get install -y xfce4 virtualbox-guest-dkms virtualbox-guest-utils \
        virtualbox-guest-x11 xfonts-base slim rxvt-unicode-256color

    # Start virtualbox guest
    VBoxClient --clipboard
    VBoxClient --draganddrop
    VBoxClient --display
    VBoxClient --checkhostversion
    VBoxClient --seamless

    # Chown files in home
    chown -R vagrant /home/vagrant

    # Allow user to use shared vm folders
    usermod -a -G vboxsf vagrant
    # Allow user to use docker commands
    usermod -a -G docker vagrant

    # Enable slim login
    systemctl set-default graphical.target
    systemctl enable slim.service
    # Move slim config to correct place
    mv /home/vagrant/slim.conf /etc/slim.conf

    # Install Powerline fonts
    su - vagrant -c "git clone https://github.com/powerline/fonts.git ~/fonts"
    # Terminess powerline is not working by default, extra setup needed
    su - vagrant -c "pushd ~/fonts && ./install.sh && \
        mkdir -p ~/.config/fontconfig/conf.d && \
        mv ~/fonts/fontconfig/*.conf ~/.config/fontconfig/conf.d/ && \
        popd && rm -rf fonts"
    fc-cache -vf /home/vagrant/.local/share/fonts

    # Reboot to apply changes
    sudo reboot now
  SHELL

  config.vm.define "docker-box" do |nothing|
  end
end
