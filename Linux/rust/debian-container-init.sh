#!/bin/bash

#############################################################################
# Debian source:
sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list
sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list
apt-get update

#############################################################################
# Install packages
apt-get install -y vim-nox locales tmux bash-completion ctags patch man tree cifs-utils fzf ripgrep tofrodos neovim
# Clean up the apt cache
rm -rf /var/lib/apt/lists/*

#############################################################################
# For Debian and Tmux
# Uncomment en_US.UTF-8 for inclusion in generation
sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen

# Generate locale
locale-gen

# Implemented in alias.sh
# Export env vars
#echo "export LC_ALL=en_US.UTF-8" >> ~/.bashrc
#echo "export LANG=en_US.UTF-8" >> ~/.bashrc
#echo "export LANGUAGE=en_US.UTF-8" >> ~/.bashrc

#############################################################################
# Change time zone to Shanghai
echo "Asia/Shanghai" > /etc/timezone
rm /etc/localtime
dpkg-reconfigure -f noninteractive tzdata
