#!/usr/bin/env bash

# set -x
set -e

create_symlink() {
	local link_dir=$1
	local target=$2
	local real_target
	real_target="${link_dir}/$(basename "${target}")"
	if [[ ! -L "${real_target}" ]]; then
		if [[ -e "${real_target}" ]]; then
			mv "${real_target}" "${real_target}.bak"
		fi

		ln -s -t "${link_dir}" "$(realpath "${target}")"
	fi
}

create_bashrc() {
	local bashrc="$HOME/.bashrc"
	if [[ ! -L "${bashrc}" ]]; then
		if [[ -e "${bashrc}" ]]; then
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

# --
mkdir -p "$HOME/.config"

# nvim
create_symlink "$HOME/.config" "config/nvim/.config/nvim"
# wezterm
create_symlink "$HOME/.config" "config/wezterm/.config/wezterm"

# XXX(damb): make use of parameter expansion: https://stackoverflow.com/a/13864829
if [[ -z ${DAMB_DOTFILES_INSTALL_CONTAINER+x} ]]; then
  # XXX(damb): run host installation
  
	# fzf
	create_symlink "$HOME" config/fzf/.fzf
	~/.fzf/install \
		--completion \
		--key-bindings \
		--no-update-rc \
		--no-zsh \
		--no-fish

	# wallpapers
	create_symlink "$HOME/.config" "config/bg/.config/bg"
	# i3wm
	create_symlink "$HOME/.config" "config/i3/.config/i3"
	# sway
	create_symlink "$HOME/.config" "config/sway/.config/sway"
	# flameshot
	create_symlink "$HOME/.config" "config/flameshot/.config/flameshot"
	create_symlink "$HOME/.config" "config/xdg-desktop-portal/.config/xdg-desktop-portal"
fi

exit 0
