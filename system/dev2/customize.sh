#!/usr/bin/env bash

# set -x
set -e

#symlink() {
#    local source=$1
#    local dest=$2
#    if [[ ! -L "${dest}" ]]; then
#        if [[ -e "${dest}" ]] &&  [[ ! -d "${dest}" ]]; then
#            mv "${dest}" "${dest}.bak"
#        fi
#
#    if [[ -d $dest ]]; then
#          ln -s -t "${dest}" "$(realpath "${source}")"
#    else
#      ln -s -T ${source} ${dest}
#    fi
#    fi
#}
#
#copy_file() {
#    local source=$1
#    local dest=$2
#    if [[ ! -L "$dest" ]]; then
#        if [[ -e "$dest" ]]; then
#            mv "$dest" "${dest}.bak"
#        fi
#
#        cp -T "$source" "$dest"
#    fi
#}

export DEBIAN_FRONTEND=noninteractive

echo "################################################################################"
echo "# Customize Docker"
echo "################################################################################"

sudo apt update
sudo apt install -y \
	  pipx \
	  plocate \
	  python3-dev \
	  python3-pip \
	  ripgrep \
    clang-format-14 \
    curl \
    gdb \
    git \
    htop \
    less \
    ros-jazzy-ament-mypy \
    ros-jazzy-example-interfaces \
    ros-jazzy-rmw-cyclonedds-cpp \
    ros-jazzy-tinyxml-vendor \
    silversearcher-ag \
    tree \
    vim

sudo add-apt-repository --yes ppa:neovim-ppa/unstable

sudo apt update
sudo apt install -y \
	fonts-firacode \
	fonts-font-awesome \
	neovim \
	python3-neovim

sudo apt autoremove -y
sudo apt clean

# TODO(damb): install `wezterm`

# XXX(damb): this file is sourced by `~/.bashrc_custom`.
echo 'export PS1="(dev2) \[\033]0;\u@\h:\w\007\]\[\033[01;36m\]\u@\h\[\033[01;34m\] \w \$ \[\033[00m\]"' | tee --append ${HOME}/.bashrc_dev


PATH_DOTFILES="${HOME}/.dotfiles"
pushd "${PATH_DOTFILES}"
./install.sh
popd >/dev/null

pushd "${PATH_DOTFILES}/config/nvim/.config/nvim/pack/bundle/opt/command-t/lua/wincent/commandt/lib"
make clean && make
popd >/dev/null

#
## Install additional Mason packages
#nvim -c 'execute "MasonInstall clang-format flake8 mdformat shfmt yamlfmt" | q'
#
mkdir -p "${HOME}/.config"
cat << EOF > "${HOME}/.config/black"
[tool.black]
line-length = 140
EOF


echo "################################################################################"
echo "# DONE"
echo "################################################################################"

exit 0
