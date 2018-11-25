# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
fi

# Activate zplug
source ~/.zplug/init.zsh

# =============================================================================
# Load theme from local directory. Name is specified in the main file
zplug "~/.config/zsh/themes", from:local, as:theme, use:$ZSH_THEME.zsh-theme


# Zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Completion from zsh-users
zplug "zsh-users/zsh-completions", defer:0
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Archlinux specific aliase
zplug "plugins/archlinux", from:oh-my-zsh, if:"which pacman"

# Git, the most important one
zplug "plugins/git", from:oh-my-zsh

# Auto-close and delete matching delimiters
zplug "hlissner/zsh-autopair", defer:2

# Coloring for man-pages
zplug "plugins/colored-man-pages", from:oh-my-zsh

# Copy the current Path to the Clipboard
zplug "plugins/copydir", from:oh-my-zsh

# Copy the content of a File to the Clipboard
zplug "plugins/copyfile", from:oh-my-zsh

# =============================================================================
# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

# Load plugins
zplug load
