#!/bin/bash

#set -x

create_symlink() {
  if [[ ! -L "$HOME/$(basename $1)" ]]
  then
    if [[ -e "$HOME/$(basename $1)" ]]
    then
      mv "$HOME/$(basename $1)" "$HOME/$(basename $1).bak"
    fi

    ln -s -t $HOME "$(realpath $1)"
  fi
}

create_bashrc () {
  local bashrc="$HOME/.bashrc"
  if [[ ! -L "$bashrc" ]]
  then
    if [[ -e "$bashrc" ]]
    then
      mv "$bashrc" "${bashrc}.bak"
    fi

    ln -s -T "$HOME/.bash_profile" "$bashrc"
  fi
}

# bash
create_symlink runcom/.bash_profile
create_bashrc

# vim
for c in config/vim/.vimrc config/vim/.vim
do
  create_symlink "$c"
done

# git
create_symlink config/git/.gitconfig

