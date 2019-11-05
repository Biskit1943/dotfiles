# Exports
export TERM="xterm-256color"
export BROWSER=chromium
export PAGER=less
export LESS="--tabs=4 --no-init --LONG-PROMPT --ignore-case --quit-if-one-screen --RAW-CONTROL-CHARS"
export RANGER_LOAD_DEFAULT_RC=FALSE
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Specify theme name here without file-ending
ZSH_THEME=steeef
#ZSH_THEME_PROMPT_ON_NEW_LINE=true

# History settings
HISTFILE=$HOME/.histfile
HISTSIZE=1000
SAVEHIST=10000

# ZSH setopt
setopt appendhistory
setopt autocd
setopt extendedglob
setopt notify

# Vi mode for zsh
bindkey -v

# Completion
zstyle :compinstall filename '$HOME/.zshrc'
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit

# Assemble files
source $HOME/.config/zsh/zplug.zsh
source $HOME/.config/zsh/custom_aliase.zsh
source $HOME/.config/zsh/path.zsh
source $HOME/.config/zsh/ssh.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
