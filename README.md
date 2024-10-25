# "dotfiles" and system configuration

## Dependencies

- [Bash](https://www.gnu.org/software/bash/)
- [Git](https://git-scm.com/)
- [Neovim](https://neovim.io/)
- [Nerd Fonts](https://www.nerdfonts.com/), e.g. [Fira Code
  Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode)

## Installation

First of all, make sure the required dependencies are installed. E.g.

- **Gentoo**:

    Install dependencies:

    ```
    emerge --ask \
        dev-vcs/git app-editors/neovim \
        media-fonts/firacode-nerdfont \
        media-fonts/font-awesome \
    ```


Next, clone the repository

```
git clone --recurse-submodules git@github.com:damb/damb.git .dotfiles && \
  cd .dotfiles
```

and run

```
./install.sh
```

Finally source your `~/.bashrc`

```
. ~/.bashrc
```
