# ls Command but with exa
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
alias -g G='| ag'
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
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Alias for docker-compose
alias compose='docker-compose'

alias portainer='/opt/portainer/portainer --data /opt/portainer/portainer-data -p :10001 --template-file /opt/portainer/templates.json'
