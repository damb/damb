#!/usr/bin/env bash

set -e

echo "################################################################################"
echo "# Customize Docker"
echo "################################################################################"

sudo apt update
sudo apt install -y \
	curl \
	gdb \
	git \
	gpg \
	htop \
	iputils-ping \
	mlocate \
	pipx \
	python3-dev \
	python3-pip \
	ripgrep \
	ros-noetic-anymal-logs \
	ros-noetic-log-view \
	ros-noetic-rqt-dep \
	ros-noetic-swri-console \
	ros-noetic-tf2-tools \
	silversearcher-ag \
	vim \
  anymal-pc-setup \
  black \
  tree \
	software-properties-common

sudo add-apt-repository --yes ppa:neovim-ppa/unstable
# sudo mkdir -p /etc/apt/keyrings
# curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
# echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list

sudo apt update
sudo apt install -y \
	fonts-firacode \
	fonts-font-awesome \
	neovim \
	python3-neovim
# wezterm

path_deb_wezterm=/tmp/wezterm-20240203-110809-5046fc22.Ubuntu20.04.deb 
curl --output "${path_deb_wezterm}" -LO https://github.com/wez/wezterm/releases/download/20240203-110809-5046fc22/wezterm-20240203-110809-5046fc22.Ubuntu20.04.deb  
sudo apt install -y "${path_deb_wezterm}"

sudo apt autoremove -y
sudo apt clean

# XXX(damb): this file is sourced by `~/.bashrc_custom`.
echo 'export PS1="(dev1) \[\033]0;\u@\h:\w\007\]\[\033[01;36m\]\u@\h\[\033[01;34m\] \w \$ \[\033[00m\]"' | tee --append ${HOME}/.bashrc_dev

PATH_DOTFILES="${HOME}/.dotfiles"
pushd "${PATH_DOTFILES}"
./install.sh
popd >/dev/null

pushd "${PATH_DOTFILES}/config/nvim/.config/nvim/pack/bundle/opt/command-t/lua/wincent/commandt/lib"
make clean && make
popd >/dev/null

# Install additional Mason packages
nvim -c 'execute "MasonInstall clang-format flake8 mdformat shfmt yamlfmt" | q'

mkdir -p "${HOME}/.config"
cat << EOF > "${HOME}/.config/black"
[tool.black]
line-length = 140
EOF

exit 0
