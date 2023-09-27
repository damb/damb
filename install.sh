#!/bin/bash

#set -x

# bash
if [[ -f $HOME/.bash_profile && ! -L $HOME/.bash_profile ]]
then
  mv $HOME/.bash_profile $HOME/.bash_profile.bak
fi

for c in runcom/.bash_profile
do
  if [[ ! -L  $HOME/$(basename $c) ]]
  then
    ln -s -t $HOME "$(realpath $c)"
  fi
done

# bashrc
if [[ -f $HOME/.bashrc && ! -L $HOME/.bashrc ]]
then
  mv $HOME/.bashrc $HOME/.bashrc.bak
fi
if [[ ! -L $HOME/.bashrc ]]
then
  ln -s -T $HOME/.bash_profile $HOME/.bashrc
fi

# vim
for c in config/vim/.vimrc config/vim/.vim
do
  if [[ -e $HOME/$(basename $c) && ! -L  $HOME/$(basename $c) ]]
  then
    mv "$HOME/$(basename $c)" "$HOME/$(basename $c).bak"
  fi
  if [[ ! -L  $HOME/$(basename $c) ]]
  then
    ln -s -t $HOME "$(realpath $c)"
  fi
done

# git
for c in config/git/.gitconfig
do
  if [[ -f $HOME/$(basename $c) && ! -L  $HOME/$(basename $c) ]]
  then
    mv "$HOME/$(basename $c)" "$HOME/$(basename $c).bak"
  fi
  if [[ ! -L  $HOME/$(basename $c) ]]
  then
    ln -s -t $HOME "$(realpath $c)"
  fi
done

