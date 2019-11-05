# Arch fresh install Script
For my basic programs use the `.dotfiles/.install` script

# Dotfile adaptation

- First, install `zsh` if not already done
- Second, download the `Nerd-Font` of your choice here: [Releases](https://github.com/ryanoasis/nerd-fonts/releases/tag/v2.0.0)
  or install it from the [AUR](https://aur.archlinux.org/packages/nerd-fonts-complete/) from Arch
- Third, copy that Files into your Font Folder (On Arch `/usr/share/fonts/`) and enable them in your Terminal
- Fourth, `mkdir $HOME/.dotfiles` then `cd $HOME/.dotfiles` and finally 
  `git clone --bare https://github.com/Biskit1943/dotfiles.git .`
- Fith, run this command `alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
- Sixth, rm/backup all Files that are provided by this Repo
- Seventh, run this `dotfiles checkout` and afterwards this `dotfiles config --local status.showUntrackedFiles no`

Install additional Packages:
- To use `ccat` the Package `pygmentize` must be installed

# Result:

![dark-wood Screenshot](https://github.com/Biskit1943/dotfiles/blob/master/Pictures/dark_wood_theme_thumb.png)

# OOMOX

If you want to apply the dark_wood theme to all GTK applications use the [base16-builder](https://github.com/base16-builder/base16-builder)
like that
```bash
base16-builder -s solarized -b dark -t oomox
```