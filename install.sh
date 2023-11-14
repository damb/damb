#!/bin/bash

# set -x

create_symlink() {
	local link_dir=$1
	local target=$2
	if [[ ! -L "${link_dir}/$(basename $target)" ]]; then
		if [[ -e "${link_dir}/$(basename $target)" ]]; then
			mv "${link_dir}/$(basename $target)" "${link_dir}/$(basename $target).bak"
		fi

		ln -s -t "${link_dir}" "$(realpath $target)"
	fi
}

create_bashrc() {
	local bashrc="$HOME/.bashrc"
	if [[ ! -L "$bashrc" ]]; then
		if [[ -e "$bashrc" ]]; then
			mv "$bashrc" "${bashrc}.bak"
		fi

		ln -s -T "$HOME/.bash_profile" "$bashrc"
	fi
}

# bash
create_symlink "$HOME" runcom/.bash_profile
create_bashrc

# git
create_symlink "$HOME" config/git/.gitconfig

# vim
for c in config/vim/.vimrc config/vim/.vim; do
	create_symlink "$HOME" "$c"
done

# nvim
mkdir -p "$HOME/.config"
create_symlink "$HOME/.config" "config/nvim/.config/nvim"
