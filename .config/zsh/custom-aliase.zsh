# ls Command but with exa
alias ls='exa'
alias l='exa -lgFh'
alias la='exa -lgaFh'
alias lr='exa -lRFr'
alias lrr='exa -lRFL '
alias lt='exa -lgRFhs date'
alias ll='exa -lh'

# Edit .zshrc
alias zshrc='$EDITOR $HOME/.zshrc'
alias szshrc='source $HOME/.zshrc'

# Open File and follow
alias t='tail -f'

# Pipe extensions
alias -g G='| rg'
alias -g NE='2> /dev/null'
alias -g NUL='> /dev/null 2>&1'

# Show disk Udage
alias dud='du -d 1 -h'
alias duf='du -sh *'

# Find
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# History
alias h='history'
alias hgrep="fc -El 0 | grep"

# Show Processes of current Shell
alias p='ps -f'

# Make these Commands to ask bevor doing something
alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Set Editor to nvim if available
if which nvim &>/dev/null; then
    alias vim='() { $(whence -p nvim) $@ }'
    export EDITOR=nvim
else
    alias vim='() { $(whence -p vim) $@ }'
    export EDITOR=vim
fi

# Enable autocolor
alias grep='() { $(whence -p grep) --color=auto $@ }'
alias egrep='() { $(whence -p grep) --color=auto $@ }'

# Dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=/'

# Alias for docker-compose
alias compose='docker-compose'

alias portainer='/opt/portainer/portainer --data /opt/portainer/portainer-data -p :10001 --template-file /opt/portainer/templates.json'
alias update="sudo apt update && sudo apt upgrade && sudo apt autoremove"
alias upd="sudo apt update"
alias upg="sudo apt upgrade"

alias dc="docker-compose"

alias pip="python3 -m pip"

# fzf
# Setting rg as default source for fzf
export FZF_DEFAULT_COMMAD='rg --file --hidden'
# Apply to Ctrl+t
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}
