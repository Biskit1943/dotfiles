if [ $(whence -p vim) ]; then
    export EDITOR=vim
    export VISUAL=vim
elif [ $(whence -p nvim) ]; then
    export EDITOR=nvim
    export VISUAL=nvim
else
    export EDITOR=vi
    export VISUAL=vi
fi

if [ $(whence -p zsh) ]; then
    export BASH=$(which zsh)
else
    export BASH=$(which bash)
fi

# Enable my Scripts to execute them everywhere
if [ -d $HOME/.config/scripts ]; then
    export PATH=$PATH:$HOME/.config/scripts
fi

export BROWSER=chromium
export PAGER=less
# Improved less
export LESS="--tabs=4 --no-init --LONG-PROMPT --ignore-case --quit-if-one-screen --RAW-CONTROL-CHARS"

export RANGER_LOAD_DEFAULT_RC=FALSE
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
