# if not running interactively, don't do anything
test -z "$PS1" && return

PATH_DOTFILES=$HOME/.dotfiles

# source dotfiles
for DOTFILE in \
  "$PATH_DOTFILES"/system/.bashrc_{env,path,prompt,function,alias,custom} \
  "$PATH_DOTFILES"/system/locale.conf
do
  test -f "$DOTFILE" && . "$DOTFILE"
done

# clean up
unset DOTFILE

# export
export PATH_DOTFILES
