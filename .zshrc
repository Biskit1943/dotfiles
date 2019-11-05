export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM="xterm-256color"
bindkey -v # Use Vim inside of the Terminal
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.zplug/repos/robbyrussell/oh-my-zsh"
export LESS="--tabs=4 --no-init --LONG-PROMPT --ignore-case --quit-if-one-screen --RAW-CONTROL-CHARS"

# Watching other users
#WATCHFMT="%n %a %l from %m at %t."
watch=(notme)         # Report login/logout events for everybody except ourself.
#watch=(all)         # Report login/logout events for everybody except ourself.
LOGCHECK=60           # Time (seconds) between checks for login/logout activity.
REPORTTIME=5          # Display usage statistics for commands running > 5 sec.
#WORDCHARS="\"*?_-.[]~=/&;!#$%^(){}<>\""
#WORDCHARS="\"*?_-[]~&;!#$%^(){}<>\""
WORDCHARS='`~!@#$%^&*()-_=+[{]}\|;:",<.>/?'"'"

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt autocd                   # Allow changing directories without `cd`
setopt append_history           # Dont overwrite history
setopt extended_history         # Also record time and duration of commands.
setopt share_history            # Share history between multiple shells
setopt hist_expire_dups_first   # Clear duplicates when trimming internal hist.
setopt hist_find_no_dups        # Dont display duplicates during searches.
setopt hist_ignore_dups         # Ignore consecutive duplicates.
setopt hist_ignore_all_dups     # Remember only one unique copy of the command.
setopt hist_reduce_blanks       # Remove superfluous blanks.
setopt hist_save_no_dups        # Omit older commands in favor of newer ones.

# Changing directories
#setopt auto_pushd
setopt pushd_ignore_dups        # Dont push copies of the same dir on stack.
setopt pushd_minus              # Reference stack entries with "-".

setopt extended_glob

zstyle ':completion:*' rehash true
zstyle ':completion:*' verbose yes

# case-insensitive (all), partial-word and then substring completion
zstyle ":completion:*" matcher-list \
   #  "m:{a-zA-Z}={A-Za-z}" \
   #    "r:|[._-]=* r:|=*" \
   #      "l:|=* r:|=*"

      zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS}

# source config for powerlevel9k
source ~/.config/zsh/themes/p9kgt
# ZSH_THEME="xxf"
plugins=(
    git
)

source ~/.config/zsh/plugins.zsh
# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# history
if zplug check "zsh-users/zsh-history-substring-search"; then
    zmodload zsh/terminfo
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down
    bindkey "^[[1;5A" history-substring-search-up
    bindkey "^[[1;5B" history-substring-search-down
fi

# highlighting
if zplug check "zsh-users/zsh-syntax-highlighting"; then
    #ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
    ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

    typeset -A ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[cursor]='bg=yellow'
    ZSH_HIGHLIGHT_STYLES[globbing]='none'
    ZSH_HIGHLIGHT_STYLES[path]='fg=white'
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=grey'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[function]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[command]='fg=green'
    ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'
    ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green'
    ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=yellow'
    ZSH_HIGHLIGHT_STYLES[redirection]='fg=magenta'
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=cyan,bold'
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=green,bold'
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=magenta,bold'
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=yellow,bold'
fi

# Source functions and aliases.
[[ -f $HOME/.zsh_functions ]] && source ~/.zsh_functions
[[ -f $HOME/.zsh_aliases ]] && source ~/.zsh_aliases
source $ZSH/oh-my-zsh.sh

# --- FZF ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [[ $TERM =~ konsole.* ]]; then
    export FZF_DEFAULT_OPTS='--color fg+:5,hl+:6'
fi

vf() {
  local files

  files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})

  if [[ -n $files ]]
  then
     vim -- $files
     print -l $files[1]
  fi
}

export FZF_TMUX=1

# fuzzy rg
vg() {
  local file

  file="$(rg --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1 " +" $2}')"

  if [[ -n $file ]]
  then
     vim $file
  fi
}

export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:/usr/share/code/bin
export PATH=$PATH:/usr/share/code-insiders/bin
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="${HOME}/.local/bin/:${PATH}"
source ~/.config/zsh/custom-aliase.zsh
